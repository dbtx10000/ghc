package com.alidao.balance.web.control;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.balance.entity.CardBindRecordDetail;
import com.alidao.balance.service.CardBindRecordDetailService;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.PageParam;

@Controller
@RequestMapping("cardBindRecordDetail")
public class CardBindRecordDetailCtrl extends WebCtrl {

	@Autowired
	private CardBindRecordDetailService cardBindRecordDetailService;

	@RequestMapping("init")
	public void init() {
	}

	@RequestMapping("page")
	public void page(PageParam pageParam, CardBindRecordDetail object,
			HttpServletResponse response,Date startDate,Date endDate) throws IOException {
		SimpleDateFormat simple=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(startDate != null){
			object.addCondition("create_time >= '" + simple.format(startDate) + "'", Condition.SEP_AND);
		}
		if(endDate != null){
			object.addCondition("create_time <= '" + simple.format(endDate) + "'", Condition.SEP_AND);
		}
		cardBindRecordDetailService.page(pageParam, object).jsonOut(response);
	}
}
