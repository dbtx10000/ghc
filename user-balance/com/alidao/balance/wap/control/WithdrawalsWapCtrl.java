package com.alidao.balance.wap.control;

import java.util.List;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alidao.balance.entity.Balance;
import com.alidao.balance.entity.BalanceRecord;
import com.alidao.balance.entity.Withdrawals;
import com.alidao.balance.service.BalanceRecordService;
import com.alidao.balance.service.BalanceService;
import com.alidao.balance.service.WithdrawalsService;
import com.alidao.cnpay.entity.CardBind;
import com.alidao.cnpay.service.CardBindService;
import com.alidao.cnpay.util.FundPayForm;
import com.alidao.cnpay.wap.control.CnpayCtrl;
import com.alidao.common.Constants;
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
@RequestMapping("wap/withdrawals")
public class WithdrawalsWapCtrl extends WebCtrl{

	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CardBindService cardBindService;
	
	@Autowired
	private BalanceService balanceService;
	
	
	@Autowired
	private WithdrawalsService withdrawalsService;
	
	@Autowired
	private BalanceRecordService balanceRecordService;
	
	/**
	 * 跳转到提现页面
	 * @param userId
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping("withdrawals")
	public void toWithdrawals(String userId,Model model) throws Exception{
		User user=userService.find(userId);
		CardBind card=new CardBind();
		card.setUserId(userId);
		card.setStatus(CardBind.BIND_ED);
		card=cardBindService.find(card);
		model.addAttribute("card", card);
		model.addAttribute("withdrawalsNumber", getWithdrawalsNumberToday(userId));
		Balance balance=new Balance();
		balance = balanceService.find(balance);
		if(balance != null) {
			model.addAttribute("totalBalance", balance.getTotalBalance());
			model.addAttribute("surplusBalance", balance.getSurplusBalance());
		}
		model.addAttribute("hasPayPassword", !StringUtil.isEmpty(user.getPayPassword()));
		model.addAttribute("mobile", user.getMobile());
		model.addAttribute("userId", userId);
	}
	
	
	public int getWithdrawalsNumberToday(String userId){
		BalanceRecord balanceRecord = new BalanceRecord();
		balanceRecord.setUserId(userId);
		balanceRecord.setType(BalanceRecord.TYPE_WITHDRAWALS);
		balanceRecord.addCondition("TO_DAYS(create_time) = TO_DAYS(NOW())",Balance.SEP_AND);
		balanceRecord.addCondition("status!=4", Balance.SEP_AND);
		List<BalanceRecord> list = balanceRecordService.list(balanceRecord);//查询今天提现了多少次
		int withdrawalsNumber = Integer.parseInt(Constants.get("withdrawals_number"));
		if(list != null && list.size() > 0) {
			if(withdrawalsNumber - list.size() > 0) {
				return  withdrawalsNumber - list.size();
			} else {
				return  0;
			}
		} else {
			return withdrawalsNumber;
		}
	}
	@RequestMapping("sure")
	public void sure(FundPayForm pForm, String payPassword, 
			 HttpServletResponse response, 
			String userId,Double money) throws Exception {
		ResponseForAjax resp = new ResponseForAjax();
		Balance balance = new Balance();
		balance.setUserId(userId);
		balance = balanceService.find(balance);//查询余额表
		
		int withdrawalsNumber=getWithdrawalsNumberToday(userId);
		if(withdrawalsNumber<=0){
			resp.setMessage("今日提现次数已超过限制！");
			resp.setResult(-4);
		}else if(money>balance.getSurplusBalance()){
			resp.setMessage("余额不足！");
			resp.setResult(-5);
		}else{
			synchronized (CnpayCtrl.class) {
				User user = userService.find(userId);
				if (StringUtil.isNotBlank(user.getPayPassword())) {
					if (user.getPayPassword().equals(Crypto.MD5(payPassword))) {
						//提现
							CardBind cardBind = new CardBind();
							cardBind.setUserId(userId);
							cardBind.setCardNo(pForm.getCardNo());
							cardBind = cardBindService.find(cardBind);//查询银行卡绑定信息
							BalanceRecord balanceRecord = new BalanceRecord();
							balanceRecord.setUserId(userId);
							balanceRecord.setUsername(user.getUsername());
							balanceRecord.setRealname(user.getRealname());
							balanceRecord.setType(BalanceRecord.TYPE_WITHDRAWALS);
							balanceRecord.setMoney(money);
							balanceRecord.setStatus(BalanceRecord.STATUS_SUBMIT_APPLY);
							balanceRecord.setNote("");
							balanceRecord.setBeforeBalance(balance.getSurplusBalance());
							balanceRecord.setAfterBalance(balance.getSurplusBalance()-money);
							
							Withdrawals withdrawals = new Withdrawals();
							withdrawals.setUserId(userId);
							withdrawals.setUsername(user.getUsername());
							withdrawals.setRealname(user.getRealname());
							withdrawals.setMoney(money);
							withdrawals.setStatus(Withdrawals.STATUS_SUBMIT_APPLY);
							withdrawals.setBeforeBalance(balance.getSurplusBalance());
							withdrawals.setAfterBalance(balance.getSurplusBalance());
							withdrawals.setSerial(StringUtil.genMsecSerial().substring(2) + new Random().nextInt(10));
							withdrawals.setOpenBankId(cardBind.getOpenBankId());
							withdrawals.setOpenBankName(cardBind.getOpenBankName());
							withdrawals.setBankCardNo(cardBind.getCardNo());
							withdrawals.setBankCertId(cardBind.getCertId());
							withdrawals.setBankUserName(cardBind.getUserName());
							withdrawals.setBankCertType(cardBind.getCertType());
							withdrawals.setBankUserProv("");//开户人地址(省)
							withdrawals.setBankUserCity("");//开户人地址(市)
							withdrawals.setNote("");
							int result=withdrawalsService.saveBussiness(balanceRecord, withdrawals);
							resp.setResult(result);
					} else {
						resp.setMessage("支付密码不正确");
						resp.setResult(2);
					}
				} else {
					resp.setMessage("还未设置支付密码");
					resp.setResult(3);
				}
			}
		}
		resp.jsonOut(response);
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

