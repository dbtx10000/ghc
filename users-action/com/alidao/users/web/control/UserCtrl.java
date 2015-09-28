package com.alidao.users.web.control;

import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.basic.service.CashCouponService;
import com.alidao.jse.util.Crypto;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.jxe.model.ResponseForAjax;
import com.alidao.users.entity.User;
import com.alidao.users.entity.UserInvest;
import com.alidao.users.service.UserIntegralService;
import com.alidao.users.service.UserInvestService;
import com.alidao.users.service.UserService;
import com.alidao.utils.XlsUtil;

@Controller
@RequestMapping("users/user")
public class UserCtrl extends WebCtrl {
	
	@Autowired
	private UserInvestService userInvestService;

	@Autowired
	private UserService userService;
	
	@Autowired
	private UserIntegralService userIntegralService;
	
	@Autowired
	private CashCouponService cashCouponService;
	
	@RequestMapping("init")
	public void init(Model model, String pid) {
		if (StringUtil.isNotBlank(pid)) {
			model.addAttribute("parent", userService.find(pid));
		}
		model.addAttribute("pid", pid);
	}
	
	@RequestMapping("page")
	public void page(PageParam pageParam, User object, 
			HttpServletResponse response,Date startDate,Date endDate) throws Exception {
		SimpleDateFormat simple=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(startDate != null){
			object.addCondition("create_time >= '" + simple.format(startDate) + "'", User.SEP_AND);
		}
		if(endDate != null){
			object.addCondition("create_time <= '" + simple.format(endDate) + "'", User.SEP_AND);
		}
		Page<User> page = userService.page(pageParam, object);
		List<User> list = page.getTableList();
		for (int i = 0; list != null && i < list.size(); i++) {
			String userId = list.get(i).getId();
			list.get(i).setIntegral(userIntegralService.getMyVaildIntegral(userId, null));
			list.get(i).setIncome(calcCurrMoney(userId));
			list.get(i).setCashCoupons(cashCouponService.getCashCoupons(userId));
			if (StringUtil.isNotBlank(list.get(i).getPid())) {
				User parent = userService.find(list.get(i).getPid());
				if (parent != null) {
					list.get(i).setParentName(parent.getRealname());
				}
			}
		}
		page.jsonOut(response);
	}
	
	@RequestMapping("only")
	public void only(HttpServletResponse response,
			String id) throws Exception {
		User user = new User();
		user.setId(id);
		List<User> list = userService.list(user);
		for (int i = 0; list != null && i < list.size(); i++) {
			String userId = list.get(i).getId();
			list.get(i).setIntegral(userIntegralService.getMyVaildIntegral(userId, null));
			list.get(i).setIncome(calcCurrMoney(userId));
			list.get(i).setCashCoupons(cashCouponService.getCashCoupons(userId));
			if (StringUtil.isNotBlank(list.get(i).getPid())) {
				User parent = userService.find(list.get(i).getPid());
				if (parent != null) {
					list.get(i).setParentName(parent.getRealname());
				}
			}
		}
		Page<User> page = Page.getSinglePage(list);
		page.jsonOut(response);
	}
	
	private double calcCurrMoney(String userId) {
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
	
	@RequestMapping("list")
	public void list(
			User object, 
			HttpServletResponse response) 
					throws Exception {
		getQueryResponse(
			userService.list(object)
		).jsonOut(response);
	}
	
	@RequestMapping("edit")
	public void edit(String id, Model model) {
		if (StringUtil.isNotBlank(id)) {
			User object = userService.find(id);
			model.addAttribute("object", object);
		}
	}
	
	@RequestMapping("save")
	public void save(User object, 
			HttpServletResponse response) 
					throws Exception {
		String password = object.getPassword();
		if (StringUtil.isNotBlank(password)) {
			// 密码进行加密
			password = Crypto.MD5(password);
			object.setPassword(password);	
		}
		if (StringUtil.isEmpty(object.getId())) {
			object.setUsername(object.getMobile());
			object.setSource(User.SOURCE_PC);
			object.setStatus(User.STATUS_NEWREG);
			getResponse(
				userService.save(object)
			).jsonOut(response);
		} else {
			getResponse(
				userService.mdfy(object)
			).jsonOut(response);
		}
	}
	
	@RequestMapping("lose/{id}")
	public void lose(
			@PathVariable("id") String id, 
			HttpServletResponse response) 
					throws Exception {
		getResponse(
			userService.lose(id)
		).jsonOut(response);
	}
	
	@RequestMapping("show/{id}")
	public String show(
			@PathVariable("id") String id, 
			Model model) {
		User object = userService.find(id);
		model.addAttribute("object", object);
		return "users/user/show";
	}
	
	/**
	 * 判断后台输入的手机号是否存在
	 * @param object
	 * @param out
	 */
	@RequestMapping("find")
	public void find(
			String mobile, String id, 
			HttpServletResponse response) 
					throws Exception {
		User condition = new User();
		condition.setMobile(mobile);
		User user = userService.find(condition);
		ResponseForAjax resp = new ResponseForAjax();
		if (user == null) {
			resp.setResult(0);	
		} else {
			if (StringUtil.isEmpty(id)) {
				resp.setResult(1);	
			} else {
				if (user.getId().equals(id)) {
					resp.setResult(0);	
				} else {
					resp.setResult(1);	
				}
			}
		}
		resp.jsonOut(response);
	}
	
	@RequestMapping("exam/{id}")
	public String exam(
			@PathVariable("id") String id, 
			Model model) {
		model.addAttribute("id", id);
		return "users/user/exam";
	}
	
	
	@RequestMapping("give")
	public void give(String id,Model model) {
		model.addAttribute("object",userService.find(id));
	}
	
	
	@RequestMapping("give/save")
	public void giveSave(
			User object,HttpServletResponse response)
					throws Exception {
		ResponseForAjax resp = new ResponseForAjax();
		resp.setResult(userService.give(object));
		resp.jsonOut(response);
	}
	
	
	/**
	 * 导出
	 * @param request
	 * @param pageParam
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("export")
	public void export(HttpServletRequest request, PageParam pageParam,Date startDate,Date endDate, User object, HttpServletResponse response) throws Exception {
		SimpleDateFormat simple=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(startDate != null){
			object.addCondition("create_time >= '" + simple.format(startDate) + "'", Condition.SEP_AND);
		}
		if(endDate != null){
			object.addCondition("create_time <= '" + simple.format(endDate) + "'", Condition.SEP_AND);
		}
		OutputStream os = response.getOutputStream();
		
		pageParam.setPageSize(60000L);// 统计的最大数量
		Page<User> page = userService.page(pageParam, object);
		String[] statOfLine = new String[1];// 统计结果行
		statOfLine[0] = "用户总计：" + page.getPageParam().getTotalCount() + "个";
		
		String[] srr = null;
		String[] heads = new String[17];
		List res = new ArrayList();
		int count = 0;
		if (page.getTableList() != null) {
			for (User user : page.getTableList()) {
				srr = new String[17];// 显示17个用户的字段
				setData(srr, user);// 数据赋值
				if (count == 0) {
					// 第一行中文备注只需赋值一次即可
					setHead(heads);
				}
				res.add(srr);
				count ++;
			}
		}
		res.add(statOfLine);// 加入统计结果
		XlsUtil.setHead("用户导出结果.xls", response);
		try {
			XlsUtil.downXlsData(heads,res,os);
		} finally {
			if (null != os) {
				os.flush();
				os.close();
				os = null;
			}
		}
	}
	
	public void setData(String[] srr, User user) {
		// 用户类型
		if (user.getType() == 1) {
			srr[0] = "VIP用户";
		} else if (user.getType() == 2) {
			srr[0] = "普通用户";
		} else {
			srr[0] = "销售人员";
		}
		srr[1] = user.getRealname();// 姓名
		User puser = userService.find(user.getPid());
		if (puser != null) {
			srr[2] = puser.getRealname();// 邀请人
		}
		srr[3] = user.getMobile();// 手机
		srr[4] = user.getCards() + "";// 银行卡数
		srr[5] = user.getAssets() + "元";// 总资产
		double inconme = calcCurrMoney(user.getId());
		if (inconme > 0) {
			BigDecimal b = new BigDecimal(inconme);
			srr[6] = b.setScale(2,   BigDecimal.ROUND_HALF_UP).doubleValue() + "元";// 总收益
		} else {
			srr[6] = "0元";// 总收益
		}
		srr[7] = userIntegralService.getMyVaildIntegral(user.getId(), null) + "";// 金币数
		srr[8] = cashCouponService.getCashCoupons(user.getId()) + "";// 代金券数
		srr[9] = user.getOrders() + "";// 订单数
		srr[10] = user.getFriend() + "";// 好友数
		// 用户状态
		if (user.getStatus() == User.STATUS_NEWREG) {
			srr[11] = "未激活";
		} else if (user.getStatus() == User.STATUS_WAITED) {
			srr[11] = "待审核";
		} else if (user.getStatus() == User.STATUS_NORMAL) {
			srr[11] = "使用中";
		} else {
			srr[11] = "已禁用";
		}
		// 证件类型
		if ("01".equals(user.getCredentialsType())) {
			srr[12] = "身份证";
		} else if ("02".equals(user.getCredentialsType())) {
			srr[12] = "军官证";
		} else if ("03".equals(user.getCredentialsType())) {
			srr[12] = "护照";
		} else if ("04".equals(user.getCredentialsType())) {
			srr[12] = "户口簿";
		} else if ("05".equals(user.getCredentialsType())) {
			srr[12] = "回乡证";
		} else {
			srr[12] = "其他";
		}
		srr[13] = user.getCredentialsCode();// 证件号码
		srr[14] = user.getEmail();// 邮箱
		srr[15] = user.getAddress();// 地址
		srr[16] = user.getIntro();// 个人简介
	}
	
	public void setHead(String[] srr) {
		srr[0] = "用户类型";
		srr[1] = "姓名";
		srr[2] = "邀请者";
		srr[3] = "手机";
		srr[4] = "银行卡数";
		srr[5] = "总资产";
		srr[6] = "总收益";
		srr[7] = "金币数";
		srr[8] = "代金券数";
		srr[9] = "订单数";
		srr[10] = "好友数";
		srr[11] = "状态";
		srr[12] = "证件类型";
		srr[13] = "证件号码";
		srr[14] = "邮箱";
		srr[15] = "地址";
		srr[16] = "个人简介";
	}
	
}
