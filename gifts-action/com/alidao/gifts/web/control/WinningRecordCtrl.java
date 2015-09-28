package com.alidao.gifts.web.control;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.gifts.entity.WinningRecord;
import com.alidao.gifts.service.WinningRecordService;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.PageParam;

@Controller
@RequestMapping("winningRecord")
public class WinningRecordCtrl extends WebCtrl {

	@Autowired
	private WinningRecordService winningRecordService;

	@RequestMapping("init")
	public void init() {
	}

	@RequestMapping("page")
	public void page(PageParam pageParam, WinningRecord object,
			HttpServletResponse response) throws IOException {
		winningRecordService.page(pageParam, object).jsonOut(response);
	}
	
	@RequestMapping("input")
	public void input(Model model, String id) {
		if (StringUtil.isNotBlank(id)) {
			model.addAttribute("object", winningRecordService.find(id));
		}
	}

	@RequestMapping("save")
	public void save(WinningRecord object, HttpServletResponse response)
			throws IOException {
		if (StringUtil.isEmpty(object.getId())) {
			getResponse(winningRecordService.save(object)).jsonOut(response);
		} else {
			getResponse(winningRecordService.mdfy(object)).jsonOut(response);
		}
	}

	@RequestMapping("lose/{id}")
	public void lose(@PathVariable("id") String id, 
			HttpServletResponse response) throws IOException {
		getResponse(winningRecordService.lose(id)).jsonOut(response);
	}

}
