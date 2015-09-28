package com.alidao.balance.web.control;

import java.io.IOException;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.balance.entity.Balance;
import com.alidao.balance.entity.BalanceRecord;
import com.alidao.balance.entity.Withdrawals;
import com.alidao.balance.service.BalanceService;
import com.alidao.balance.service.WithdrawalsService;
import com.alidao.cnpay.entity.CardBind;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.PageParam;

@Controller
@RequestMapping("withdrawals")
public class WithdrawalsCtrl extends WebCtrl{
	
	@Autowired
	private WithdrawalsService withdrawalsService;
	
	@Autowired
	private BalanceService balanceService;
	
	/**
	 * 确认转账
	 */
	@RequestMapping("sure")
	public void sure(PageParam pageParam, Withdrawals object,
			HttpServletResponse response) throws IOException {
		object = withdrawalsService.find(object);
		
		
		
	}
	

}
