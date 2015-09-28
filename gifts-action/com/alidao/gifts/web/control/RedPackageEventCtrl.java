package com.alidao.gifts.web.control;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alidao.gifts.entity.RedPackageEvent;
import com.alidao.gifts.service.RedPackageEventService;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.PageParam;
import com.alidao.jxe.util.HttpUtil;

@Controller
@RequestMapping("redPackageEvent")
public class RedPackageEventCtrl extends WebCtrl {

	@Autowired
	private RedPackageEventService redPackageEventService;
	
	@RequestMapping("init")
	public void init(Model model,HttpServletRequest request) {
		model.addAttribute("webapp", HttpUtil.getWebAppUrl(request));
	}

	@RequestMapping("page")
	public void page(PageParam pageParam, 
			RedPackageEvent object, HttpServletResponse response) 
					throws Exception {
		redPackageEventService.page(pageParam, object).jsonOut(response);
	}


	@RequestMapping("input")
	public void edit(String id, Model model) {
		if (id != null) {
			RedPackageEvent object = redPackageEventService.find(id);
			model.addAttribute("object", object);
		}
	}

	@RequestMapping("save")
	public void save(
			HttpServletResponse response, 
			RedPackageEvent object)
			throws Exception {
		if (StringUtil.isEmpty(object.getId())) {
			getResponse(
				redPackageEventService.save(object)
			).jsonOut(response);
		} else {
			getResponse(
				redPackageEventService.mdfy(object)
			).jsonOut(response);
		}
	}
	
	@RequestMapping("lose/{id}")
	public void lose(
			@PathVariable("id") String id, 
			HttpServletResponse response)
			throws Exception {
		getResponse(
			redPackageEventService.lose(id)
		).jsonOut(response);
	}
	@RequestMapping("publish")
	public void publish(
			RedPackageEvent object,HttpServletResponse response)
			throws Exception {
		getResponse(
			redPackageEventService.mdfy(object)
		).jsonOut(response);
	}
}
