package com.alidao.wxapi.web.contrl;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.PageParam;
import com.alidao.wxapi.entity.WxapiReplyNews;
import com.alidao.wxapi.service.WxapiReplyNewsService;

@Controller
@RequestMapping("wxapi/reply/news")
public class WxapiReplyNewsCtrl extends WebCtrl {

	@Autowired
	private WxapiReplyNewsService wxapiReplyNewsService;

	@RequestMapping("init/{replyId}")
	public String init(
			@PathVariable("replyId") Long replyId, 
			Model model) {
		model.addAttribute("replyId", replyId);
		return "wxapi/reply/news/init";
	}

	@RequestMapping("page")
	public void page(
			PageParam pageParam, 
			WxapiReplyNews object,
			HttpServletResponse response) 
					throws Exception {
		wxapiReplyNewsService.page(
			pageParam, object
		).jsonOut(response);
	}

	@RequestMapping("list")
	public void list(
			WxapiReplyNews object, 
			HttpServletResponse response)
			throws Exception {
		getQueryResponse(
			wxapiReplyNewsService.list(object)
		).jsonOut(response);
	}

	@RequestMapping("edit/{replyId}")
	public String edit(
			@PathVariable("replyId") Long replyId, 
			Long id, 
			Integer mode,
			Integer type,
			Model model) {
		model.addAttribute("replyId", replyId);
		model.addAttribute("mode", mode);
		model.addAttribute("type", type);
		if (id != null) {
			WxapiReplyNews object = wxapiReplyNewsService.find(id);
			model.addAttribute("object", object);
		}
		return "wxapi/reply/news/edit";
	}

	@RequestMapping("save")
	public void save(
			HttpServletResponse response, 
			WxapiReplyNews object)
			throws Exception {
		if (object.getId() == null) {
			getResponse(
				wxapiReplyNewsService.save(object)
			).jsonOut(response);
		} else {
			getResponse(
				wxapiReplyNewsService.mdfy(object)
			).jsonOut(response);
		}
	}

	@RequestMapping("lose/{id}")
	public void lose(
			@PathVariable("id") Long id, 
			HttpServletResponse response)
			throws Exception {
		getResponse(
			wxapiReplyNewsService.lose(id)
		).jsonOut(response);
	}

}
