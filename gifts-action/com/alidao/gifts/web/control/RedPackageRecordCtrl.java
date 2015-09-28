package com.alidao.gifts.web.control;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alidao.gifts.entity.RedPackageRecord;
import com.alidao.gifts.service.RedPackageRecordService;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.PageParam;

@Controller
@RequestMapping("redPackageRecord")
public class RedPackageRecordCtrl extends WebCtrl {

	@Autowired
	private RedPackageRecordService redPackageRecordService;
	
	@RequestMapping("init")
	public void init() {}

	@RequestMapping("page")
	public void page(PageParam pageParam, 
			RedPackageRecord object, HttpServletResponse response) 
					throws Exception {
		redPackageRecordService.page(pageParam, object).jsonOut(response);
	}
}
