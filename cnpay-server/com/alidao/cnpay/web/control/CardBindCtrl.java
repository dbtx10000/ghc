package com.alidao.cnpay.web.control;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.cnpay.entity.CardBind;
import com.alidao.cnpay.service.CardBindService;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.PageParam;
import com.alidao.jxe.model.ParamException;

@Controller
@RequestMapping("cardBind")
public class CardBindCtrl extends WebCtrl {

	@Autowired
	private CardBindService cardBindService;

	@RequestMapping("init")
	public void init(Model model, String userId) {
		model.addAttribute("userId", userId);
	}

	@RequestMapping("list")
	public void list(PageParam pageParam, CardBind object,
			HttpServletResponse response) throws IOException {
		object.setStatus(1);
		cardBindService.page(pageParam, object).jsonOut(response);
	}

	@RequestMapping("edit")
	public void edit(Model model, Long id) {
		if (id != null) {
			model.addAttribute("object", cardBindService.find(id));
		}
	}

	@RequestMapping("save")
	public void save(CardBind object, Integer nums, HttpServletResponse response)
			throws IOException, ParamException {
		if (object.getId() == null) {
			getResponse(cardBindService.save(object)).jsonOut(response);
		} else {
			getResponse(cardBindService.mdfy(object)).jsonOut(response);
		}
	}
	
	@RequestMapping("lose/{id}")
	public void lose(@PathVariable("id") Long id, 
			HttpServletResponse response) throws IOException {
		getResponse(cardBindService.lose(id)).jsonOut(response);
	}
}
