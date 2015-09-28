package com.alidao.balance.wap.control;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.balance.entity.Balance;
import com.alidao.balance.entity.BalanceRecord;
import com.alidao.balance.service.BalanceRecordService;
import com.alidao.balance.service.BalanceService;
import com.alidao.cnpay.entity.CardBind;
import com.alidao.cnpay.service.CardBindService;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.help.PowerHelper;
import com.alidao.users.authorizing.UseridTracker;
import com.alidao.users.entity.User;
import com.alidao.users.service.UserService;
import com.alidao.wxapi.util.OpenidTracker;
import com.alidao.wxapi.util.WxapiUtil;

@Controller
@RequestMapping("wap/balance")
public class BalanceWapCtrl extends WebCtrl{
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private BalanceService balanceService;
	
	@Autowired
	private BalanceRecordService balanceRecordService;
	
	@Autowired
	private CardBindService cardBindService;
	@RequestMapping("index")
	public void index(Model model,HttpServletRequest request){
		String userId = isSecurity(request) ? UseridTracker.get() : null;
		if(!StringUtil.isEmpty(userId)){
			Balance balance=new Balance();
			balance.setUserId(userId);
			balance=balanceService.find(balance);
			
			BalanceRecord balanceRecord=new BalanceRecord();
			balanceRecord.setUserId(userId);
			balanceRecord.setStatus(BalanceRecord.STATUS_DISPOSE_SUCCESS);
			List<BalanceRecord> recordList=balanceRecordService.list(balanceRecord);
			
			
			CardBind card=new CardBind();
			card.setUserId(userId);
			card.setStatus(CardBind.BIND_ED);
			card=cardBindService.find(card);
			model.addAttribute("cardFlag",card==null);
			model.addAttribute("balance", balance);
			model.addAttribute("recordList", recordList);
		}
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
