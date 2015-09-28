package com.alidao.users.wap.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alidao.basic.entity.CashCoupon;
import com.alidao.basic.entity.Const;
import com.alidao.basic.entity.Intro;
import com.alidao.basic.entity.Order;
import com.alidao.basic.service.CashCouponService;
import com.alidao.basic.service.ConstService;
import com.alidao.basic.service.IntroService;
import com.alidao.basic.service.OrderService;
import com.alidao.basic.service.SmsService;
import com.alidao.cnpay.entity.CardBind;
import com.alidao.cnpay.service.CardBindService;
import com.alidao.common.Constants;
import com.alidao.exception.CommandException;
import com.alidao.gifts.entity.Award;
import com.alidao.gifts.entity.GiftsOrder;
import com.alidao.gifts.entity.WinningRecord;
import com.alidao.gifts.service.AwardService;
import com.alidao.gifts.service.GiftsOrderService;
import com.alidao.gifts.service.WinningRecordService;
import com.alidao.jse.util.BeanUtil;
import com.alidao.jse.util.Crypto;
import com.alidao.jse.util.DateUtil;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.help.PowerHelper;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.ParamException;
import com.alidao.jxe.model.ResponseForAjax;
import com.alidao.jxe.util.HttpUtil;
import com.alidao.users.authorizing.UseridTracker;
import com.alidao.users.entity.BuyProductRecord;
import com.alidao.users.entity.User;
import com.alidao.users.entity.UserBind;
import com.alidao.users.entity.UserHelper;
import com.alidao.users.entity.UserIntegral;
import com.alidao.users.entity.UserInvest;
import com.alidao.users.service.BuyProductRecordService;
import com.alidao.users.service.UserHelperService;
import com.alidao.users.service.UserIntegralService;
import com.alidao.users.service.UserInvestService;
import com.alidao.users.service.UserRiskEvaluationService;
import com.alidao.users.service.UserService;
import com.alidao.wxapi.bean.TokenForWxapis;
import com.alidao.wxapi.bean.UserForWxUnion;
import com.alidao.wxapi.util.OpenidTracker;
import com.alidao.wxapi.util.WxapiUtil;
import com.google.gson.Gson;

@Controller
@RequestMapping("wap/user")
public class UserWapCtrl extends WebCtrl {

	@Autowired
	private SmsService smsService;

	@Autowired
	private UserHelperService userHelperService;

	@Autowired
	private UserIntegralService userIntegralService;
	
	@Autowired
	private UserInvestService userInvestService;
	
	@Autowired
	private ConstService constService;
	
	@Autowired
	private IntroService introService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CashCouponService cashCouponService;
	
	@Autowired
	private CardBindService cardBindService;
	
	@Autowired
	private GiftsOrderService giftsOrderService;
	
	@Autowired
	private WinningRecordService winningRecordService;
	
	@Autowired
	private AwardService awardService;
	
	@Autowired
	private UserRiskEvaluationService userRiskEvaluationService;
	
	@Autowired
	private BuyProductRecordService buyProductRecordService;
	
	@Autowired
	private OrderService orderService;
	
	@RequestMapping(value = "donate/1", method = RequestMethod.GET)
	public void donate1() {
		List<User> list = userService.list(null);
		for (User user : list) {
			
			String userId = user.getId();
			User object = new User();
			object.setId(userId);
			
			// 更新好友数
			User ucdt = new User();
			ucdt.setPid(userId);
			List<User> chis = userService.list(ucdt);
			Integer fcount = 0;
			if (chis != null) {
				fcount = chis.size();
			}
			object.setFriend(fcount);
			
			// 更新订单数
			Order order = new Order();
			order.setUserId(userId);
			List<Order> orders = orderService.list(order);
			Integer ocount = 0;
			if (orders != null) {
				ocount = orders.size();
			}
			object.setOrders(ocount);
			
			// 更新投资数
			int isum = userInvestService.isum(
					userId, UserInvest.STATUS_HOLD_ING);
			object.setAssets(isum);

			// 更新绑卡数
			CardBind bind = new CardBind();
			bind.setUserId(userId);
			bind.setStatus(1);
			List<CardBind> ucbs = cardBindService.list(bind);
			Integer ccount = 0;
			if (ucbs != null) {
				ccount = ucbs.size();
			}
			object.setCards(ccount);

			userService.mdfy(object);
		}
	}
	
	@RequestMapping(value = "donate/2", method = RequestMethod.GET)
	public void donate2(String date, String id) throws Exception {
		String incomeendtemplateid = Constants.get("incomeend.templateId");
		TokenForWxapis tokenforwxapis = WxapiUtil.getWxapisToken(Constants.get("wxapi.appid"), Constants.get("wxapi.appsecret"));
		UserInvest invest = new UserInvest();
		invest.setStatus(UserInvest.STATUS_HAS_OVER);
		invest.addCondition("income_end_time", " = ", "'" + date + "'", UserInvest.SEP_AND);
		invest.addCondition("product_id", " = ", "'" + id + "'", UserInvest.SEP_AND);
		List<UserInvest> invests = userInvestService.list(invest);
		
		for (UserInvest cell : invests) {
			String pname = cell.getProductName();
			String money = (cell.getInvestMoney() + cell.getIncomeMoney()) + "元";
			// 组装json_data数据
			String json_data = "{\"first\": {\"value\":\"你认购的‘" + pname + "’产品收益已到账\",\"color\":\"#173177\"}," +
						"\"income_amount\":{\"value\":\"" + money + "\",\"color\":\"#173177\"}," +
						"\"income_time\": {\"value\":\"" + DateUtil.formatDate(new Date(), "yyyy年MM月dd日") + "\",\"color\":\"#173177\"}," +
						"\"remark\": {\"value\":\"你好，你的‘" + pname + "’产品收益已到账，请注意查看确认。客服热线400-6196-805。\",\"color\":\"#173177\"}}";
			System.out.println(json_data);	
			
			UserBind bind = userService.findUserBind(cell.getUserId(), User.BINDED_WECHAT);
			if (bind != null) {
				System.out.println(bind.getAccount());
				// 推送收益到账消息模版
				WxapiUtil.sendTM2WxUser(tokenforwxapis.getAccess_token(), bind.getAccount(), incomeendtemplateid, "", json_data);
			}
		}
		System.out.println("总共：" + invests.size() + "个");
	}
	
	@RequestMapping(value = "donate/3", method = RequestMethod.GET)
	public void donate3(String date) throws Exception {
		String incomeendtemplateid = Constants.get("incomeend.templateId");
		TokenForWxapis tokenforwxapis = WxapiUtil.getWxapisToken(Constants.get("wxapi.appid"), Constants.get("wxapi.appsecret"));
		String in = "('e0a9c71dc7265e36ac251dbbda331f7e')";
		UserInvest invest = new UserInvest();
		invest.setStatus(UserInvest.STATUS_HAS_OVER);
		invest.addCondition("income_end_time", " = ", "'" + date + "'", UserInvest.SEP_AND);
		invest.addCondition("product_id", " in ", in, UserInvest.SEP_AND);
		List<UserInvest> invests = userInvestService.list(invest);
		
		for (UserInvest cell : invests) {
			String pname = "畅享季【特权本金】";
			String money = null;
			String idate = DateUtil.formatDate(new Date(), "yyyy年MM月dd日");
			if (cell.getOrder().getActualMoney() == 2) {
				money = "16.34元";
			} else {
				money = "15.34元";
			}
			// 组装json_data数据
			String json_data = "{\"first\": {\"value\":\"你认购的‘" + pname + "’产品收益已到账\",\"color\":\"#173177\"}," +
						"\"income_amount\":{\"value\":\"" + money + "\",\"color\":\"#173177\"}," +
						"\"income_time\": {\"value\":\"" + idate + "\",\"color\":\"#173177\"}," +
						"\"remark\": {\"value\":\"你好，你的‘" + pname + "’产品收益已到账，请注意查看确认。客服热线400-6196-805。\",\"color\":\"#173177\"}}";
			System.out.println(json_data);	
			
			UserBind bind = userService.findUserBind(cell.getUserId(), User.BINDED_WECHAT);
			if (bind != null) {
				System.out.println(bind.getAccount());
				// 推送收益到账消息模版
				WxapiUtil.sendTM2WxUser(tokenforwxapis.getAccess_token(), bind.getAccount(), incomeendtemplateid, "", json_data);
			}
		}
		System.out.println("总共：" + invests.size() + "个");
	}
	
	@RequestMapping(value = "wxinfo", method = RequestMethod.GET)
	public void wxinfo(String openid, PrintWriter writer) throws Exception {
		TokenForWxapis tokenforwxapis = WxapiUtil.getWxapisToken(Constants.get("wxapi.appid"), Constants.get("wxapi.appsecret"));
		UserForWxUnion userforwxunion = WxapiUtil.getWxUnionUser(tokenforwxapis.getAccess_token(), openid);
		if (StringUtil.isNotBlank(userforwxunion.getNickname())) {
			userforwxunion.setNickname(new String(userforwxunion.getNickname().getBytes("iso-8859-1"), "utf-8"));
		}
		if (StringUtil.isNotBlank(userforwxunion.getCountry())) {
			userforwxunion.setCountry(new String(userforwxunion.getCountry().getBytes("iso-8859-1"), "utf-8"));
		}
		if (StringUtil.isNotBlank(userforwxunion.getProvince())) {
			userforwxunion.setProvince(new String(userforwxunion.getProvince().getBytes("iso-8859-1"), "utf-8"));
		}
		if (StringUtil.isNotBlank(userforwxunion.getCity())) {
			userforwxunion.setCity(new String(userforwxunion.getCity().getBytes("iso-8859-1"), "utf-8"));
		}
		writer.print(new Gson().toJson(userforwxunion));
	}
	
	/**
	 * 检查是否设置支付密码
	 * @param response
	 * @throws IOException 
	 */
	@RequestMapping(value = "exitpay", method = RequestMethod.POST)
	public void exitpay(HttpServletResponse response) throws IOException {
		ResponseForAjax resp = new ResponseForAjax();
		User user = userService.find(UseridTracker.get());
		if(StringUtil.isEmpty(user.getPayPassword())) {
			resp.setResult(3);
			resp.setMessage("还未设置支付密码，请先设置支付密码");
		} else {
			resp.setResult(1);
		}
		resp.jsonOut(response);
	}
	
	/**
	 * 校验支付密码
	 * @param payPassword
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "chkpay", method = RequestMethod.POST)
	public void chkpay(String payPassword, HttpServletResponse response) 
			throws IOException {
		ResponseForAjax resp = new ResponseForAjax();
		User user = userService.find(UseridTracker.get());
		if (StringUtil.isNotBlank(user.getPayPassword())) {
			if (user.getPayPassword().equals(Crypto.MD5(payPassword))) {
				resp.setResult(1);
				resp.setMessage("支付密码校验成功");
			} else {
				resp.setResult(2);
				resp.setMessage("支付密码不正确");
			}
		} else {
			resp.setResult(3);
			resp.setMessage("还未设置支付密码");
		}
		resp.jsonOut(response);
	}
	
	/**
	 * 校验手势密码
	 * @param touchsPassword
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "chktpw", method = RequestMethod.POST)
	public void chktpw(String touchsPassword, HttpServletResponse response) 
			throws IOException {
		ResponseForAjax resp = new ResponseForAjax();
		User user = userService.find(UseridTracker.get());
		if (StringUtil.isNotBlank(user.getTouchsPassword())) {
			if (user.getTouchsPassword().equals(Crypto.MD5(touchsPassword))) {
				resp.setResult(1);
				resp.setMessage("手势密码校验成功");
			} else {
				resp.setResult(2);
				resp.setMessage("旧手势密码不正确");
			}
		} else {
			resp.setResult(3);
			resp.setMessage("还未设置手势密码");
		}
		resp.jsonOut(response);
	}
	
	@RequestMapping(value = "touchs", method = RequestMethod.GET)
	public void touchs(HttpServletRequest request, Model model) {
		if (WxapiUtil.fromMicBrowser(request)) {
			User user = userService.find(
				OpenidTracker.get(), User.BINDED_WECHAT);
			if (user != null) {
				model.addAttribute("username", user.getUsername());
			}
		}
	}
	
	@RequestMapping(value = "stpswd", method = RequestMethod.GET)
	public void stpswd(HttpServletRequest request, Model model) {
		if (WxapiUtil.fromMicBrowser(request)) {
			User user = userService.find(
				OpenidTracker.get(), User.BINDED_WECHAT);
			if (user != null) {
				model.addAttribute("username", user.getUsername());
			}
		}
	}
	
	@RequestMapping(value = "stpswd", method = RequestMethod.POST)
	public void stpswd(String touchsPassword, HttpServletResponse response) 
					throws Exception {
		User user = userService.find(UseridTracker.get());
		user.setTouchsPassword(Crypto.MD5(touchsPassword));
		getResponse(userService.mdfy(user)).jsonOut(response);
	}
	
	@RequestMapping(value = "rtpswd", method = RequestMethod.GET)
	public void rtpswd(HttpServletRequest request, Model model) {
		if (WxapiUtil.fromMicBrowser(request)) {
			User user = userService.find(
				OpenidTracker.get(), User.BINDED_WECHAT);
			if (user != null) {
				model.addAttribute("username", user.getUsername());
			}
		}
	}
	
	@RequestMapping(value = "rtpswd", method = RequestMethod.POST)
	public void rtpswd(String oldTouchsPassword, 
			String newTouchsPassword, HttpServletResponse response) 
			throws IOException {
		ResponseForAjax resp = new ResponseForAjax();
		User user = userService.find(UseridTracker.get());
		if (StringUtil.isNotBlank(user.getTouchsPassword())) {
			if (user.getTouchsPassword().equals(Crypto.MD5(oldTouchsPassword))) {
				user.setTouchsPassword(Crypto.MD5(newTouchsPassword));
				resp = getResponse(userService.mdfy(user));
			} else {
				resp.setResult(2);
				resp.setMessage("旧手势密码不正确");
			}
		} else {
			resp.setResult(3);
			resp.setMessage("还未设置手势密码");
		}
		resp.jsonOut(response);
	}
	
	@RequestMapping(value = "slogin", method = RequestMethod.GET)
	public String slogin(
			HttpServletRequest request, String pid, String back, Model model) {
		boolean touchs = false;
		if (WxapiUtil.fromMicBrowser(request)) {
			User user = userService.find(
				OpenidTracker.get(), User.BINDED_WECHAT);
			if (user != null) {
				String password = user.getTouchsPassword();
				if (StringUtil.isNotBlank(password)) { 
					if (StringUtil.isEmpty(back)) {
						return "redirect:".concat("/wap/user/touchs");
					}
					touchs = true; 
				}
			}
		}
		model.addAttribute("touchs", touchs);
		model.addAttribute("pid", pid);
		return "/wap/user/slogin";
	}
	
	@RequestMapping(value = "slogin", method = RequestMethod.POST)
	public void slogin(HttpServletRequest request, String username, 
			String password, String touchsPassword,
			HttpServletResponse response) throws Exception {
		ResponseForAjax resp = new ResponseForAjax();
		if (StringUtil.isNotBlank(username)) {
			if (StringUtil.isNotBlank(password)) {
				password = Crypto.MD5(password);
			} else {
				password = null;
			}
			if (StringUtil.isNotBlank(touchsPassword)) {
				touchsPassword = Crypto.MD5(touchsPassword);
			} else {
				touchsPassword = null;
			}
			User user = new User();
			user.setUsername(username);
			user.setPassword(password);
			user.setTouchsPassword(touchsPassword);
			user = userService.find(user);
			if (user != null) {
				if (user.getStatus() == User.STATUS_WAITED) {
					resp.setResult(ResponseForAjax.FAIL);
					resp.setMessage("该账号还在审核中");
				} else if (user.getStatus() == User.STATUS_PAUSED) {
					resp.setResult(ResponseForAjax.FAIL);
					resp.setMessage("该账号已经被禁用");
				} else {
					resp.setResult(ResponseForAjax.SUCC);
					resp.setMessage("登录成功");
					String id = user.getId();
					if (WxapiUtil.fromMicBrowser(request)) {
						String openid = OpenidTracker.get();
						userService.bind(
							id, openid, User.BINDED_WECHAT);
					} else {
						PowerHelper.set(id);
					}
					if (user.getStatus() == User.STATUS_NEWREG) {
						user.setStatus(User.STATUS_NORMAL);
						userService.mdfy(user);
					}
				}
			} else {
				resp.setResult(ResponseForAjax.FAIL);
				resp.setMessage("用户名或密码不正确");
			}
		} else {
			resp.setResult(ResponseForAjax.FAIL);
			resp.setMessage("请输入用户名");
		}
		resp.jsonOut(response);
	}
	
	@RequestMapping(value = "logout", method = RequestMethod.POST)
	public void logout(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		if (WxapiUtil.fromMicBrowser(request)) {
			/*
			userService.drop(
				UseridTracker.get(), 
				OpenidTracker.get(), 
				User.BINDED_WECHAT
			);
			*/
			userService.over(
				UseridTracker.get(), 
				OpenidTracker.get(), 
				User.BINDED_WECHAT
			);
		} else {
			PowerHelper.lose();
		}
		getResponse(1).jsonOut(response);
	}
	
	@RequestMapping("exists")
	public void exists(String mobile, HttpServletResponse response)
			throws Exception {
		User user = new User();
		user.setMobile(mobile);
		user = userService.find(user);
		int result = 0;
		if (user != null) {
			if (user.getStatus() != User.STATUS_NEWREG) {
				result = 1;
			}
		}
		getResponse(result).jsonOut(response);
	}
	
	@RequestMapping(value = "regist", method = RequestMethod.GET)
	public void regist(String pid, String salerId, Model model) {
		if (StringUtil.isNotBlank(pid)) {
			User parent = userService.find(pid);
			String mobile = parent.getMobile();
			String prefix = mobile.substring(0, 3);
			String suffix = mobile.substring(7);
			parent.setMobile(prefix + "****" + suffix);
			model.addAttribute("parent", parent);
		}
		if(StringUtil.isNotBlank(salerId)) {
			model.addAttribute("salerId", salerId);
		}
	}
	
	@RequestMapping(value = "regist", method = RequestMethod.POST)
	public void regist(HttpServletRequest request, User object, 
			String token, HttpServletResponse response) throws Exception {
		ResponseForAjax resp = new ResponseForAjax();
		verifyParams(object.getMobile(), object.getPassword(), token);
		object.setPassword(Crypto.MD5(object.getPassword()));
		if (!smsService.isok(object.getMobile(), token)) {
			throw new CommandException("注册超时");
		}
		User user = new User();
		user.setMobile(object.getMobile());
		user = userService.find(user);
		String id = null;
		if (user != null) {
			if (user.getStatus() == User.STATUS_NEWREG) {
				user.setUsername(object.getMobile());
				user.setRealname(object.getRealname());
				user.setCredentialsType(object.getCredentialsType());
				user.setCredentialsCode(object.getCredentialsCode());
				user.setAddress(object.getAddress());
				user.setEmail(object.getEmail());
				user.setPassword(object.getPassword());
				user.setStatus(User.STATUS_NORMAL);
				resp = getResponse(userService.mdfy(user));
				id = user.getId();
			} else {
				throw new CommandException("手机号码已被注册");
			}
		} else {
			object.setUsername(object.getMobile());
			if (WxapiUtil.fromMicBrowser(request)) {
				object.setSource(User.SOURCE_WECHAT);
			} else {
				object.setSource(User.SOURCE_WAP);
			}
			object.setType(User.U_TYPE_COMMON);
			String need_verify = Constants.get("need_verify");
			if ("true".equals(need_verify)) {
				if (StringUtil.isEmpty(object.getPid())) {	// 邀请注册
					need_verify = Constants.get("user.need_verify_for_invreg");
				} else {	// 自主注册
					need_verify = Constants.get("user.need_verify_for_ownreg");
				}
			}
			String fwurl = null;
			if ("true".equals(need_verify)) {
				object.setStatus(User.STATUS_WAITED);
				fwurl = "/wap/user/verify";
			} else {
				object.setStatus(User.STATUS_NORMAL);
				fwurl = "/wap/user/gobank";
			}
			resp = getResponse(userService.save(object));
			id = object.getId();
			resp.setData(fwurl);
		}
		if (success(resp)) {
			if (WxapiUtil.fromMicBrowser(request)) {
				String openid = OpenidTracker.get();
				userService.bind(
					id, openid, User.BINDED_WECHAT);
			} else {
				PowerHelper.set(id);
			}
			smsService.used(token);
			resp.setMessage("注册成功");
		} else {
			resp.setMessage("注册失败");
		}
		resp.jsonOut(response);
	}
	
	@RequestMapping(value = "forget", method = RequestMethod.GET)
	public void forget() {}
	
	@RequestMapping(value = "forget", method = RequestMethod.POST)
	public void forget(HttpServletRequest request, String mobile, 
			String password, String token, HttpServletResponse response) 
					throws Exception {
		verifyParams(mobile, password, token);
		if (!smsService.isok(mobile, token)) {
			throw new CommandException("重置密码超时");
		}
		User object = new User();
		object.setMobile(mobile);
		object = userService.find(object);
		if (object == null) {
			throw new CommandException("手机号未注册");
		}
		object.setPassword(Crypto.MD5(password));
		ResponseForAjax resp = getResponse(userService.mdfy(object));
		if (success(resp)) {
			if (!WxapiUtil.fromMicBrowser(request)) {
				PowerHelper.set(object.getId());
			}
			smsService.used(token);
			resp.setMessage("密码重置成功");
		} else {
			resp.setMessage("密码重置失败");
		}
		resp.jsonOut(response);
	}
	
	@RequestMapping(value = "repswd", method = RequestMethod.GET)
	public void repswd() {}
	
	@RequestMapping(value = "repswd", method = RequestMethod.POST)
	public void repswd(HttpServletRequest request, String oldPswd, 
			String newPswd, HttpServletResponse response) throws Exception {
		verifyParams(oldPswd, newPswd);
		oldPswd = Crypto.MD5(oldPswd);
		newPswd = Crypto.MD5(newPswd);
		User user = userService.find(UseridTracker.get());
		ResponseForAjax resp = null;
		if (oldPswd.equals(user.getPassword())) {
			user.setPassword(newPswd);
			resp = getResponse(userService.mdfy(user));
		} else {
			resp = new ResponseForAjax();
			resp.setResult(0);
			resp.setMessage("旧登录密码不正确");
		}
		resp.jsonOut(response);
	}
	
	@RequestMapping(value = "psetok", method = RequestMethod.GET)
	public void psetok() {
		
	}
	
	@RequestMapping(value = "payset/{mode}", method = RequestMethod.GET)
	public String payset(
			@PathVariable("mode") Integer mode,
			HttpServletRequest request, Model model) {
		model.addAttribute("mode", mode);
		User user = userService.find(UseridTracker.get());
		model.addAttribute("mobile", user.getMobile());
		model.addAttribute("redirect_uri", HttpUtil.getWebAppUrl(request)+"/wap/user/psetok");
		return "wap/user/create";
	}
	
	@RequestMapping(value = "payset", method = RequestMethod.POST)
	public void create(HttpServletRequest request, Integer mode, 
			String mobile, String token, String password, 
			HttpServletResponse response) throws Exception {
		verifyParams(mobile, token, password);
		if (!smsService.isok(mobile, token)) {
			throw new CommandException("设置支付密码超时");
		}
		User user = new User();
		user.setMobile(mobile);
		user = userService.find(user);
		user.setPayPassword(Crypto.MD5(password));
		int result = userService.mdfy(user);
		if (result == 1) { smsService.used(token); }
		getResponse(result).jsonOut(response);
	}
	
	@RequestMapping(value = "makeup", method = RequestMethod.GET)
	public String makeup(User object, String token, Model model) 
			throws ParamException {
		model.addAttribute("token", token);
		model.addAttribute("mode", 1);
		if (smsService.isok(object.getMobile(), token)) {
			User user = new User();
			user.setMobile(object.getMobile());
			user = userService.find(user);
			if (user != null) {
				object.setType(user.getType());
				object.setRealname(user.getRealname());
				object.setCredentialsType(user.getCredentialsType());
				object.setCredentialsCode(user.getCredentialsCode());
				object.setAddress(user.getAddress());
				object.setEmail(user.getEmail()); 
			}
		}
		model.addAttribute("object", object);
		model.addAttribute("salerId", object.getSalerId());
		return "wap/user/update";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String update(Model model) {
		model.addAttribute("mode", 2);
		User object = userService.find(UseridTracker.get());
		model.addAttribute("object", object);
		return "wap/user/update";
	}
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public void update(User object, 
			HttpServletResponse response) 
			throws Exception {
		object.setId(UseridTracker.get());
		getResponse(
			userService.mdfy(object)
		).jsonOut(response);
	}
	
	@RequestMapping(value = "verify", method = RequestMethod.GET)
	public void verify() {}
	
	@RequestMapping(value = "gotowx", method = RequestMethod.GET)
	public void gotowx(String from, Model model) {
		if ("bindcard".equals(from)) {
			model.addAttribute("text", "绑卡成功");
			model.addAttribute("note", "恭喜绑定银行卡成功");
		} else if ("register".equals(from)) {
			model.addAttribute("text", "注册成功");
			model.addAttribute("note", "恭喜注册成功");
		}
	}
	
	@RequestMapping(value = "center", method = RequestMethod.GET)
	public void center(Model model, HttpServletRequest request) {
		String userId = UseridTracker.get();
		User object = userService.find(userId);
		String mobile = object.getMobile();
		String prefix = mobile.substring(0, 3);
		String suffix = mobile.substring(7);
		object.setMobile(prefix + "****" + suffix);
		model.addAttribute("object", object);
		// 获取用户当前总收益额
//		double gsum = userIncomeService.isum(userId);
		double gsum = calcCurrIncome(userId);
		model.addAttribute("gsum", gsum);
		// 获取用户当前总投资额
		int isum = userInvestService.isum(
			userId, UserInvest.STATUS_HOLD_ING);
		// 获取用户的投资数量
		Integer inv1 = 0, inv2 = 0, inv3 = 0,inv1_readed = 0, 
				inv2_readed = 0, inv3_readed = 0;
		List<UserInvest> list = null;
		UserInvest inv_cdt = new UserInvest();
		inv_cdt.setUserId(userId);
		inv_cdt.setStatus(UserInvest.STATUS_HOLD_ING);
		list = userInvestService.list(inv_cdt);
		for (int i = 0; i < list.size(); i++) {
			UserInvest invest = list.get(i);
			if (invest.getReaded() == 0) {
				inv2_readed = 1;//代表还有没查看的数据
				break;
			}
		}
		if (list != null) { inv2 = list.size(); }
		inv_cdt.setStatus(UserInvest.STATUS_APPLY_ED);
		list = userInvestService.list(inv_cdt);
		for (int i = 0; i < list.size(); i++) {
			UserInvest invest = list.get(i);
			if (invest.getReaded() == 0) {
				inv1_readed = 1;//代表还有没查看的数据
//				break;
			}
			Order order = invest.getOrder();
			if (order.getStatus() == 1) {
				isum += invest.getInvestMoney();
			}
		}
		model.addAttribute("isum", isum);
		if (list != null) { inv1 = list.size(); }
		inv_cdt.setStatus(UserInvest.STATUS_HAS_OVER);
		list = userInvestService.list(inv_cdt);
		for (int i = 0; i < list.size(); i++) {
			UserInvest invest = list.get(i);
			if (invest.getReaded() == 0) {
				inv3_readed = 1;//代表还有没查看的数据
				break;
			}
		}
		if (list != null) { inv3 = list.size(); }
		model.addAttribute("inv1", inv1);
		model.addAttribute("inv2", inv2);
		model.addAttribute("inv3", inv3);
		model.addAttribute("inv1_readed", inv1_readed);
		model.addAttribute("inv2_readed", inv2_readed);
		model.addAttribute("inv3_readed", inv3_readed);
		// 获取用户最早收益时间
		inv_cdt = new UserInvest();
		inv_cdt.setUserId(userId);
		inv_cdt.setStatus(UserInvest.STATUS_HOLD_ING);
		inv_cdt.addOrderBy("income_start_time");
		inv_cdt = userInvestService.find(inv_cdt);
		if (inv_cdt != null) {
			String dfmt = "yyyy年MM月dd日";
			String time = new SimpleDateFormat(dfmt).
				format(inv_cdt.getIncomeStartTime());
			model.addAttribute("time", time);
		}
		// 获取用户的积分记录
		UserIntegral int_cdt = new UserIntegral();
		int_cdt.setUserId(userId);
		int_cdt.setStatus(UserIntegral.STATUS_UN_READ);
		int_cdt = userIntegralService.find(int_cdt);
//		model.addAttribute("sbot", int_cdt != null);
		// 获取用户代金券记录
		CashCoupon cpo_cdt = new CashCoupon();
		cpo_cdt.setUserId(userId);
		cpo_cdt.setReaded(CashCoupon.READ_NO);
		cpo_cdt = cashCouponService.find(cpo_cdt);
//		model.addAttribute("sbot_cash", cpo_cdt == null);
		boolean sbot = int_cdt != null || cpo_cdt != null;
		model.addAttribute("sbot", sbot);
		//查看绑定银行卡
		/*CardBind cbi_cdt = new CardBind();
		cbi_cdt.setUserId(userId);
		cbi_cdt.addOrderBy("create_time");
		cbi_cdt.setStatus(1);
		cbi_cdt = cardBindService.find(cbi_cdt);
		model.addAttribute("card", cbi_cdt != null);*/
		// 设置风险评测
		model.addAttribute("risk", 
			userRiskEvaluationService.index());
	}
	
	/**
	 * 我的银行卡页面
	 * @param model
	 */
	@RequestMapping("mycard")
	public void mycard(Model model) {
		String userId = UseridTracker.get();
		CardBind object = new CardBind();
		object.setUserId(userId);
		object.addOrderBy("create_time desc");
		object.setStatus(CardBind.BIND_ED);
		//List<CardBind> cards = cardBindService.list(object);
		CardBind card = cardBindService.find(object);
		model.addAttribute("card", card);
	}
	/**
	 * 银行卡解除绑定
	 * @throws IOException 
	 */
	@RequestMapping("unwrap")
	public void unwrap(
			HttpServletResponse response,
			Long cardId) throws IOException {
		CardBind object = new CardBind();
		object.setStatus(CardBind.UN_WRAP);
		object.setId(cardId);
		User user = new User();
		user.setId(UseridTracker.get());
		user.setCards(-1);
		userService.plus(user);
		getResponse(
			cardBindService.mdfy(object)
		).jsonOut(response);
	}
	
	/**
	 * 银行卡详细信息
	 * @throws IOException 
	 */
	@RequestMapping("detail")
	public void detail(Long cardId, Model model) {
		CardBind object = cardBindService.find(cardId);
		model.addAttribute("object", object);
	}
	
	private double calcCurrIncome(String userId) {
		// 获取已结束投资的收益
		Double gsum = userInvestService.gsum(userId, UserInvest.STATUS_HAS_OVER);
		UserInvest inv_cdt = new UserInvest();
		inv_cdt.setUserId(userId);
		inv_cdt.setStatus(UserInvest.STATUS_HOLD_ING);
		List<UserInvest> list = userInvestService.list(inv_cdt);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Long nowtime = 0L;
		Double cisum = 0D;
		try {
			nowtime = sdf.parse(sdf.format(new Date())).getTime();
		} catch (ParseException e) {
			throw new RuntimeException(e);
		}
		for (int i = 0; list != null && i < list.size(); i++) {
			UserInvest cell = list.get(i);
			Long time = nowtime - cell.getIncomeStartTime().getTime();
			int days = (int) ((time) / (24 * 60 * 60 * 1000)) + 1;
			cisum += days * cell.calcDayIncomeMoney();
		}
		return gsum + cisum;
	}

	@RequestMapping(value = "helper", method = RequestMethod.GET)
	public void helper(Model model) {
		String userId = UseridTracker.get();
		User user = userService.find(userId);
		UserHelper object = new UserHelper();
		object.setUserType(user.getType());
		object = userHelperService.find(object);
		model.addAttribute("object", object);
	}
	
	@RequestMapping(value = "invite", method = RequestMethod.GET)
	public void invite(Model model, 
			HttpServletRequest request) {
		String userId = UseridTracker.get();
		User object = new User();
		object.setPid(userId);
		List<User> list = userService.list(object);
		int nums = 0, isum = 0;
		if (list != null && list.size() > 0) {
			isum = userIntegralService.isum(
				userId, UserIntegral.TYPE_GET_INVITES_REG);
			model.addAttribute("list", list);
			nums = list.size();
		}
		String lctx = HttpUtil.getWebAppUrl(request);
		model.addAttribute("lctx", lctx);
		model.addAttribute("nums", nums);
		model.addAttribute("isum", isum);
		// 分享时需要的信息
		model.addAttribute("realname", 
			userService.find(userId).getRealname());
		Const _const = constService.find(new Const());
		if (_const != null && _const.getInviteIntegral() != null) {
			model.addAttribute("integral", 
				_const.getInviteIntegral());
		}
		model.addAttribute("text", 
			introService.find(new Intro()));
	}
	
	@RequestMapping(value = "goldmy", method = RequestMethod.GET)
	public String goldmy(Model model) {
		String userId = UseridTracker.get();
		UserIntegral object = new UserIntegral();
		object.setUserId(userId);
		model.addAttribute("vaildIntegral", userIntegralService.getMyVaildIntegral(userId, null));
		model.addAttribute("integral_1", userIntegralService.getMyVaildIntegral(userId, "(2,5)"));
		model.addAttribute("integral_2", userIntegralService.getMyVaildIntegral(userId, "(0,1,3,4,6,7,8,9,10)"));
		
		CashCoupon coupon = new CashCoupon();
		coupon.setUserId(userId);
		coupon.addCondition("vaild_end_time >= now()", Condition.SEP_AND);
		coupon.setStatus(CashCoupon.STATUS_GET_YES);
		coupon.addOrderBy("money");
		model.addAttribute("list", cashCouponService.list(coupon));
		cashCouponService.read(userId);
		
		return "wap/user/mygold";
	}
	
	@RequestMapping(value = "goldmy/{type}", method = RequestMethod.GET)
	public String goldmy(@PathVariable("type") Integer type, Model model) {
		String userId = UseridTracker.get();
		String types = type == 1 ? "(2,5)" : "(0,1,3,4,6,7,8,9,10)";
		UserIntegral object = new UserIntegral();
		object.addCondition("type", Condition.CDT_IN, types, Condition.SEP_AND);
		object.setUserId(userId);
		object.addOrderBy("create_time", true);
		List<UserIntegral> list = userIntegralService.list(object);
		model.addAttribute("list", list);
		int isum = userIntegralService.isum(userId, null);
		int vaildIntegral = userIntegralService.getMyVaildIntegral(userId, types);
		int soonOverdueIntegral = userIntegralService.getMySoonOverdueIntegral(userId, types);
		int overdueIntegral = userIntegralService.getMyOverdueIntegral(userId, types);
		model.addAttribute("isum", isum);
		model.addAttribute("vaildIntegral", vaildIntegral);
		model.addAttribute("soonOverdueIntegral", soonOverdueIntegral);
		model.addAttribute("overdueIntegral", overdueIntegral);
		userIntegralService.read(userId);
		return "wap/user/goldmy";
	}
	
	@RequestMapping(value = "invest/{status}", method = RequestMethod.GET)
	public String invest(
			@PathVariable("status") Integer status, Model model) {
		String userId = UseridTracker.get();
		UserInvest object = new UserInvest();
		object.setStatus(status);
		object.setUserId(userId);
		object.addOrderBy("create_time", true);
		List<UserInvest> list = userInvestService.list(object);
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).getStatus() == UserInvest.STATUS_HOLD_ING) {
//					cell.setCurrent(userIncomeService.isum(cell.getId()));
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					Long nowtime = 0L;
					Double cisum = 0D;
					try {
						nowtime = sdf.parse(sdf.format(new Date())).getTime();
					} catch (ParseException e) {
						throw new RuntimeException(e);
					}
					Long time = nowtime - list.get(i).getIncomeStartTime().getTime();
					int days = (int) ((time) / (24 * 60 * 60 * 1000)) + 1;
					cisum += days * list.get(i).calcDayIncomeMoney();
					list.get(i).setCurrent(cisum);
				}
				list.get(i).setDoubleIncomeMoney(list.get(i)._calcAllIncomeMoney());
				// 关联抽奖信息
				BuyProductRecord record = new BuyProductRecord();
				record.setUserId(userId);
				record.setOrderId(list.get(i).getOrderId());
				record = buyProductRecordService.find(record);
				if (record != null) {	// 可以抽奖
					if (record.getStatus() == 0) {	// 还未抽奖
						list.get(i).setJackpot(1);
					} else {	// 已经抽奖
						list.get(i).setJackpot(2);
					}
				} else {	// 不可以抽奖
					list.get(i).setJackpot(0);
				}
			}
			model.addAttribute("list", list);
		}
		object.setReaded(1);
		userInvestService.updateReaded(object); // 修改查看状态
		model.addAttribute("specialProductId_1", Constants.get("product_id_1"));
		model.addAttribute("specialProductId_2", Constants.get("product_id_2"));
		model.addAttribute("specialProductId_3", Constants.get("product_id_3"));
		return "wap/user/invest";
	}
	
	@RequestMapping(value = "cancel/{id}", method = RequestMethod.POST)
	public void cancel(@PathVariable("id") Long id, 
			HttpServletResponse response) throws IOException {
		getResponse(userInvestService.lose(id)).jsonOut(response);
	}
	
	@RequestMapping(value = "cashmy", method = RequestMethod.GET)
	public void cashmy(Model model) {
		String userId = UseridTracker.get();
		CashCoupon object = new CashCoupon();
		object.setUserId(userId);
		model.addAttribute("list", cashCouponService.list(object));
		cashCouponService.read(userId);
	}
	
	@RequestMapping("gobank")
	public void gobank() {}
	
	@RequestMapping("giftmy")
	public void giftmy(Model model) {
		String userId = UseridTracker.get();
		GiftsOrder object = new GiftsOrder();
		object.setUserId(userId);
		object.addOrderBy("create_time", true);
		List<GiftsOrder> list = giftsOrderService.list(object);
		model.addAttribute("list", list);
	}
	
	@RequestMapping("delete")
	public void delete(Long orderId, 
			HttpServletResponse response) 
			throws IOException {
		getResponse(
			giftsOrderService.lose(orderId)
		).jsonOut(response);
	}
	
	@RequestMapping("delive")
	public void delive(Long orderId, 
			HttpServletResponse response) 
			throws IOException {
		GiftsOrder order = new GiftsOrder();
		order.setId(orderId);
		order.setStatus(GiftsOrder.RECEIVE_ED);
		getResponse(
			giftsOrderService.mdfy(order)
		).jsonOut(response);
	}
	
	@RequestMapping("iclose")
	public void iclose(Long orderId, 
			HttpServletResponse response) 
			throws IOException {
		getResponse(
			giftsOrderService.icls(orderId)
		).jsonOut(response);
	}
	
	/**
	 * 我的奖品
	 * @param model
	 */
	@RequestMapping("awards")
	public void awards(Model model) {
		String userId = UseridTracker.get();
		WinningRecord object = new WinningRecord();
		object.setUserId(userId);
		object.addOrderBy("create_time", true);
		object.setRelateType(WinningRecord.TYPE_AWARD);
		List<WinningRecord> list = winningRecordService.list(object);
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		for (WinningRecord cell : list) {
			Award award = awardService.find(cell.getRelateId());
			if (award != null) {
				Map<String, Object> map = BeanUtil.bean2Map(cell, true);
				map.put("winningTime", cell.getCreateTime());
				map.put("smallImage", award.getSmallImage());
				map.put("awardIntro", award.getIntro());
				result.add(map);
			}
		}
		model.addAttribute("list", result);
	}
	
	/**
	 * 测评模块
	 */
	@RequestMapping("tester")
	public void tester() {}
	
}
