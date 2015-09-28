package com.alidao.balance.web.control;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alidao.balance.entity.BalanceRecord;
import com.alidao.balance.service.BalanceRecordService;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.PageParam;

@Controller
@RequestMapping("balanceRecord")
public class BalanceRecordCtrl extends WebCtrl {

	@Autowired
	private BalanceRecordService balanceRecordService;

	@RequestMapping("init")
	public void init() {
	}

	@RequestMapping("page")
	public void page(PageParam pageParam, BalanceRecord object,
			HttpServletResponse response,Date startDate,Date endDate) throws IOException {
		SimpleDateFormat simple=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(startDate != null){
			object.addCondition("create_time >= '" + simple.format(startDate) + "'", Condition.SEP_AND);
		}
		if(endDate != null){
			object.addCondition("create_time <= '" + simple.format(endDate) + "'", Condition.SEP_AND);
		}
		balanceRecordService.page(pageParam, object).jsonOut(response);
	}
	
	@RequestMapping("view")
	public void view(Model model, Long id) {
		if (id!=null) {
			model.addAttribute("object", balanceRecordService.find(id));
		}
	}
}
