package com.alidao.gifts.web.control;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.gifts.entity.Igift;
import com.alidao.gifts.service.IgiftService;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.PageParam;

@Controller
@RequestMapping("gifts/igift")
public class IgiftCtrl extends WebCtrl {

	@Autowired
	private IgiftService igiftService;
	
	@RequestMapping("init")
	public void init() {}

	@RequestMapping("page")
	public void page(PageParam pageParam, 
			Igift object, HttpServletResponse response) 
					throws Exception {
		igiftService.page(
			pageParam, object
		).jsonOut(response);
	}

	@RequestMapping("list")
	public void list(Igift object, 
			HttpServletResponse response)
			throws Exception {
		getQueryResponse(
			igiftService.list(object)
		).jsonOut(response);
	}

	@RequestMapping("edit")
	public void edit(String id, Model model) {
		if (id != null) {
			Igift object = igiftService.find(id);
			model.addAttribute("object", object);
		}
	}

	@RequestMapping("save")
	public void save(
			HttpServletResponse response, 
			Igift object)
			throws Exception {
		if (StringUtil.isEmpty(object.getId())) {
			getResponse(
				igiftService.save(object)
			).jsonOut(response);
		} else {
			getResponse(
				igiftService.mdfy(object)
			).jsonOut(response);
		}
	}

	@RequestMapping("lose/{id}")
	public void lose(
			@PathVariable("id") String id, 
			HttpServletResponse response)
			throws Exception {
		getResponse(
			igiftService.lose(id)
		).jsonOut(response);
	}
	
}
