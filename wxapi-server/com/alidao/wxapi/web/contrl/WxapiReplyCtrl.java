package com.alidao.wxapi.web.contrl;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.PageParam;
import com.alidao.wxapi.entity.WxapiReply;
import com.alidao.wxapi.service.WxapiReplyService;

@Controller
@RequestMapping("wxapi/reply")
public class WxapiReplyCtrl extends WebCtrl {

	@Autowired
	private WxapiReplyService wxapiReplyService;

	@RequestMapping("init/{mode}")
	public String init(
			@PathVariable("mode") Integer mode, 
			Integer type, 
			Model model) {
		model.addAttribute("mode", mode);
		model.addAttribute("type", type);
		if (mode == WxapiReply.MODE_SUB 
				|| mode == WxapiReply.MODE_NOT) {
			WxapiReply object = new WxapiReply();
			object.setMode(mode);
			object = wxapiReplyService.find(object);
			model.addAttribute("object", object);
			if (type == null) {
				if (object != null) {
					type = object.getType();
				}
			}
			model.addAttribute("type", type == null ? 1 : type);
			if (type == null) {
				return "wxapi/reply/text";
			} else {
				if (type == 1) {
					return "wxapi/reply/text";
				} else {
					return "wxapi/reply/news";
				}
			}
		} else {
			return "wxapi/reply/init";
		}
	}

	@RequestMapping("page")
	public void page(
			PageParam pageParam, 
			WxapiReply object,
			HttpServletResponse response) 
					throws Exception {
		pageParam.setMode(PageParam.MODE_WEB);
		wxapiReplyService.page(
			pageParam, object
		).jsonOut(response);
	}

	@RequestMapping("list")
	public void list(
			WxapiReply object, 
			HttpServletResponse response)
			throws Exception {
		getQueryResponse(
			wxapiReplyService.list(object)
		).jsonOut(response);
	}

	@RequestMapping("edit/{mode}")
	public String edit(
			@PathVariable("mode") Integer mode, 
			Long id, 
			Model model) {
		model.addAttribute("mode", mode);
		if (id != null) {
			WxapiReply object = wxapiReplyService.find(id);
			model.addAttribute("object", object);
		}
		return "wxapi/reply/edit";
	}

	@RequestMapping("save")
	public void save(
			HttpServletResponse response, 
			WxapiReply object)
			throws Exception {
		if (object.getId() == null) {
			getResponse(
				wxapiReplyService.save(object)
			).jsonOut(response);
		} else {
			getResponse(
				wxapiReplyService.mdfy(object)
			).jsonOut(response);
		}
	}

	@RequestMapping("lose/{id}")
	public void lose(
			@PathVariable("id") Long id, 
			HttpServletResponse response)
			throws Exception {
		getResponse(
			wxapiReplyService.lose(id)
		).jsonOut(response);
	}
	
	@RequestMapping("tset/{id}")
	public void tset(
			@PathVariable("id") Long id, 
			Integer type,
			HttpServletResponse response)
			throws Exception {
		WxapiReply object = new WxapiReply();
		object.setId(id);
		object.setType(type);
		getResponse(
			wxapiReplyService.mdfy(object)
		).jsonOut(response);
	}

}
