package com.alidao.wxapi.web.contrl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSON;
import com.alidao.common.Constants;
import com.alidao.jse.util.ListUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.AsyncResponse;
import com.alidao.jxe.model.Page;
import com.alidao.wxapi.bean.ButtonOfWxMenu;
import com.alidao.wxapi.bean.TokenForWxapis;
import com.alidao.wxapi.bean.CustomMenuOfWx;
import com.alidao.wxapi.entity.WxapiMenus;
import com.alidao.wxapi.entity.WxapiReply;
import com.alidao.wxapi.service.WxapiMenusService;
import com.alidao.wxapi.service.WxapiReplyService;
import com.alidao.wxapi.util.WxapiUtil;

@Controller
@RequestMapping("wxapi/menus")
public class WxapiMenusCtrl extends WebCtrl {

	@Autowired
	private WxapiMenusService wxapiMenusService;
	
	@Autowired
	private WxapiReplyService wxapiReplyService;

	@RequestMapping("init")
	public void init() {}

	@RequestMapping("page")
	public void page(
			HttpServletResponse response)
			throws Exception {
		WxapiMenus object = new WxapiMenus();
		object.addOrderBy("weight", false);
		object.setLevel(1);
		List<WxapiMenus> tablelist = null;
		List<WxapiMenus> listOfLv1 = wxapiMenusService.list(object);
		if (ListUtil.isNotBlank(listOfLv1)) {
			tablelist = new ArrayList<WxapiMenus>();
			for (WxapiMenus cellOfLv1 : listOfLv1) {
				tablelist.add(cellOfLv1);
				object = new WxapiMenus();
				object.addOrderBy("weight", false);
				object.setPid(cellOfLv1.getId());
				List<WxapiMenus> listOfLv2 = wxapiMenusService.list(object);
				if (ListUtil.isNotBlank(listOfLv2)) {
					tablelist.addAll(listOfLv2);
				}
			}
		}
		Page.getSinglePage(tablelist).jsonOut(response);
	}

	@RequestMapping("list")
	public void list(
			WxapiMenus object, 
			HttpServletResponse response)
			throws Exception {
		getQueryResponse(
			wxapiMenusService.list(object)
		).jsonOut(response);
	}

	@RequestMapping("edit/{level}")
	public String edit(
			@PathVariable("level") Integer level, 
			Long pid,
			Long id, 
			Model model) {
		model.addAttribute("level", level);
		model.addAttribute("pid", pid);
		WxapiReply reply = new WxapiReply();
		reply.setMode(3);
		List<WxapiReply> replies = wxapiReplyService.list(reply);
		model.addAttribute("replies", replies);
		if (id != null) {
			WxapiMenus object = wxapiMenusService.find(id);
			model.addAttribute("object", object);
		}
		return "wxapi/menus/edit";
	}

	@RequestMapping("save")
	public void save(
			HttpServletResponse response, 
			WxapiMenus object)
			throws Exception {
		if (object.getId() == null) {
			getResponse(
				wxapiMenusService.save(object)
			).jsonOut(response);
		} else {
			getResponse(
				wxapiMenusService.mdfy(object)
			).jsonOut(response);
		}
	}

	@RequestMapping("lose/{id}")
	public void lose(
			@PathVariable("id") Long id, 
			HttpServletResponse response)
			throws Exception {
		getResponse(
			wxapiMenusService.lose(id)
		).jsonOut(response);
	}
	
	@RequestMapping("gnrt")
	public void gnrt(HttpServletResponse response)
			throws Exception {
		String appid = Constants.get("wxapi.appid");
		String appsecret = Constants.get("wxapi.appsecret");
		TokenForWxapis tokenAndExpires =
				WxapiUtil.getWxapisToken(appid, appsecret);
		String token = tokenAndExpires.getAccess_token();
		if (WxapiUtil.delCustomMenus(token)) {
			CustomMenuOfWx wxMenu = generateWxMenu();
			if (wxMenu != null) {
				String menu = JSON.toJSONString(wxMenu);
				if (WxapiUtil.addCustomMenus(token, menu)) {
					getResponse(AsyncResponse.SUCC).jsonOut(response);
				} else {
					getResponse(AsyncResponse.FAIL).jsonOut(response);
				}
			} else {
				getResponse(AsyncResponse.SUCC).jsonOut(response);
			}
		} else {
			getResponse(AsyncResponse.FAIL).jsonOut(response);
		}
	}

	private CustomMenuOfWx generateWxMenu() {
		List<ButtonOfWxMenu> button = null;
		WxapiMenus object = new WxapiMenus();
		object.addOrderBy("weight", false);
		object.setLevel(1);
		List<WxapiMenus> listOfLv1 = wxapiMenusService.list(object);
		if (ListUtil.isNotBlank(listOfLv1)) {
			button = new ArrayList<ButtonOfWxMenu>();
			for (WxapiMenus cellOfLv1 : listOfLv1) {
				object = new WxapiMenus();
				object.addOrderBy("weight", false);
				object.setPid(cellOfLv1.getId());
				List<WxapiMenus> listOfLv2 = wxapiMenusService.list(object);
				ButtonOfWxMenu buttonOfLv1 = null;
				if (ListUtil.isNotBlank(listOfLv2)) {
					List<ButtonOfWxMenu> sub_button = 
							new ArrayList<ButtonOfWxMenu>();
					for (WxapiMenus cellOfLv2 : listOfLv2) {
						String type = cellOfLv2.getType();
						String name = cellOfLv2.getName();
						String key = cellOfLv2.getKey();
						String url = cellOfLv2.getUrl();
						ButtonOfWxMenu buttonOfLv2 = 
								new ButtonOfWxMenu(type, name, key, url);
						sub_button.add(buttonOfLv2);
					}
					buttonOfLv1 = new ButtonOfWxMenu(
							cellOfLv1.getName(), sub_button);
				} else {
					String type = cellOfLv1.getType();
					String name = cellOfLv1.getName();
					String key = cellOfLv1.getKey();
					String url = cellOfLv1.getUrl();
					buttonOfLv1 = new ButtonOfWxMenu(type, name, key, url);
				}
				button.add(buttonOfLv1);
			}
		}
		if (button != null) {
			return new CustomMenuOfWx(button);
		} else {
			return null;
		}
	}
	
}
