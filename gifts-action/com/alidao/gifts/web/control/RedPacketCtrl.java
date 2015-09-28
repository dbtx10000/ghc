package com.alidao.gifts.web.control;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.gifts.entity.Jackpot;
import com.alidao.gifts.entity.RedPacket;
import com.alidao.gifts.service.JackpotService;
import com.alidao.gifts.service.RedPacketService;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.PageParam;

@Controller
@RequestMapping("redPacket")
public class RedPacketCtrl extends WebCtrl {

	@Autowired
	private RedPacketService redPacketService;
	
	@Autowired
	private JackpotService jackpotService;
	
	@RequestMapping("init")
	public void init() {}

	@RequestMapping("page")
	public void page(PageParam pageParam, 
			RedPacket object, HttpServletResponse response) 
					throws Exception {
		redPacketService.page(pageParam, object).jsonOut(response);
	}


	@RequestMapping("input")
	public void edit(String id, Model model) {
		if (id != null) {
			RedPacket object = redPacketService.find(id);
			model.addAttribute("object", object);
		}
	}

	@RequestMapping("save")
	public void save(
			HttpServletResponse response, 
			RedPacket object)
			throws Exception {
		if (StringUtil.isEmpty(object.getId())) {
			object.setResidueCount(object.getAllCount());
			getResponse(
				redPacketService.save(object)
			).jsonOut(response);
		} else {
			getResponse(
				redPacketService.mdfy(object)
			).jsonOut(response);
		}
	}
	
	@RequestMapping("lose/{id}")
	public void lose(
			@PathVariable("id") String id, 
			HttpServletResponse response)
			throws Exception {
		getResponse(
			redPacketService.lose(id)
		).jsonOut(response);
	}
	
	@RequestMapping("checkWhetherExist")
	public void checkWhetherExist(Integer integral, HttpServletResponse response) throws IOException {
		getResponse(
				redPacketService.checkWhetherExist(integral)
			).jsonOut(response);
	}
	
	/**
	 * 删除红包时检查奖池是否有该红包
	 * @param integral
	 * @param out
	 * @throws IOException
	 */
	@RequestMapping("checkJackpot")
	public void checkJackpot(String relateId,HttpServletResponse response) throws IOException {
		Jackpot jackpot=new Jackpot();
		jackpot.setRelateId(relateId);
		jackpot.setRelateType(Jackpot.TYPE_RED_PACKET);
		jackpot=jackpotService.find(jackpot);
		if(jackpot==null){
			getResponse(1).jsonOut(response);
		}else{
			getResponse(0).jsonOut(response);
		}
	}
}
