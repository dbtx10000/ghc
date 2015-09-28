package com.alidao.balance.wap.control;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.balance.entity.Balance;
import com.alidao.balance.service.BalanceService;
import com.alidao.balance.service.RechargeService;
import com.alidao.cnpay.entity.CardBind;
import com.alidao.cnpay.service.CardBindService;
import com.alidao.jse.util.Crypto;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.help.PowerHelper;
import com.alidao.jxe.model.ResponseForAjax;
import com.alidao.users.authorizing.UseridTracker;
import com.alidao.users.entity.User;
import com.alidao.users.service.UserService;
import com.alidao.wxapi.util.OpenidTracker;
import com.alidao.wxapi.util.WxapiUtil;

@Controller
@RequestMapping("wap/recharge")
public class RechargeWapCtrl extends WebCtrl{
	private static final Object LOCK = new Object();
	@Autowired
	private UserService userService;
	
	@Autowired
	private CardBindService cardBindService;
	
	@Autowired
	private RechargeService rechargeService;
	
	@Autowired
	private BalanceService balanceService;
	
	@RequestMapping("index")
	public void index(Model model,HttpServletRequest request){
		String userId = isSecurity(request) ? UseridTracker.get() : null;
		if(!StringUtil.isEmpty(userId)){
			User user=userService.find(userId);
			CardBind card=new CardBind();
			card.setUserId(userId);
			card.setStatus(CardBind.BIND_ED);
			card=cardBindService.find(card);
			
			Balance balance=new Balance();
			balance.setUserId(userId);
			balance=balanceService.find(balance);
			
			model.addAttribute("card", card);
			model.addAttribute("balance", balance);
			model.addAttribute("userId", userId);
			model.addAttribute("hasPayPassword", !StringUtil.isEmpty(user.getPayPassword()));
			model.addAttribute("mobile", user.getMobile());
		}
	}
	
	@RequestMapping("submitRecharge")
	public void recharge(HttpServletResponse response,String payPassword,
			Long cardId,Double money,String userId) throws Exception{
		synchronized (LOCK) {
			ResponseForAjax resp = new ResponseForAjax();
			User user = userService.find(userId);
			if (StringUtil.isNotBlank(user.getPayPassword())) {
				if (user.getPayPassword().equals(Crypto.MD5(payPassword))) {
					//开始充值
						int result=rechargeService.recharge(cardId,money, userId);
						if(result==0){
							resp.setMessage("支付已提交银行，请等待银行处理.");
						}
						resp.setResult(result);
				} else {
					resp.setMessage("支付密码不正确");
					resp.setResult(2);
				}
			} else {
				resp.setMessage("还未设置支付密码");
				resp.setResult(3);
			}
			resp.jsonOut(response);
		}
	}
	
	@RequestMapping("success")
	public void success(Model model,Double money){
			model.addAttribute("money", money);
	}
	
	@RequestMapping("fail")
	public void fail(){
	}
	
	/**
	 * 判断是否安全
	 * @param request
	 * @return
	 */
	private Boolean isSecurity(
			HttpServletRequest request) {
		if (WxapiUtil.fromMicBrowser(request)) {
			return hasBinding(request);
		} else {
			return hasLogined(request);
		}
	}
	
	/**
	 * 判断微信用户是否绑定
	 * @param request 
	 * @return
	 */
	private boolean hasBinding(HttpServletRequest request) {
		String openid = OpenidTracker.get();
		User user = userService.find(openid, User.BINDED_WECHAT);
		if (user != null && StringUtil.isNotBlank(user.getSessionKey())) {
			UseridTracker.set(user.getId());
			request.setAttribute("uid", user.getId());
			request.setAttribute("u.status", user.getStatus());
			return true;
		}
		return false;
	}
	
	/**
	 * 判断用户的会话时否已经丢失或失效
	 * @param request 
	 * @return
	 */
	private boolean hasLogined(HttpServletRequest request) {
		String power = PowerHelper.get();
		if (StringUtil.isNotBlank(power)) {
			User user = userService.find(power);
			if (user != null) {
				UseridTracker.set(power);
				request.setAttribute("uid", power);
				int status = user.getStatus();
				request.setAttribute("u.status", status);
				return true;
			}
		}
		return false;
	}
}
