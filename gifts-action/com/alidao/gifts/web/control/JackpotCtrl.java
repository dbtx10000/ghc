package com.alidao.gifts.web.control;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.gifts.entity.Award;
import com.alidao.gifts.entity.Jackpot;
import com.alidao.gifts.entity.RedPacket;
import com.alidao.gifts.service.AwardService;
import com.alidao.gifts.service.JackpotService;
import com.alidao.gifts.service.RedPacketService;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.PageParam;
@Controller
@RequestMapping("jackpot")
public class JackpotCtrl extends WebCtrl {

	@Autowired
	private JackpotService jackpotService;
	
	@Autowired
	private RedPacketService redPacketService;
	
	@Autowired
	private AwardService awardService;
	
	@RequestMapping("init")
	public  void init(Model model,String productId) {
		model.addAttribute("productId", productId);
	}

	@RequestMapping("page")
	public void page(PageParam pageParam, Jackpot object,
			HttpServletResponse response) throws IOException {
		jackpotService.page(
				pageParam, object
			).jsonOut(response);
	}
	
	@RequestMapping("input")
	public void input(Model model, String id) {
		if (StringUtil.isNotBlank(id)) {
			Jackpot jackpot=new Jackpot();
			jackpot.setId(id);
			model.addAttribute("object", jackpotService.find(jackpot));
		}
	}

	@RequestMapping("save")
	public void save(Jackpot object,HttpServletResponse response)
			throws IOException {
		if (StringUtil.isEmpty(object.getId())) {
			getResponse(
					jackpotService.save(object)
				).jsonOut(response);
		} else {
			getResponse(
					jackpotService.mdfy(object)
				).jsonOut(response);
		}
	}
	/**
	 * 推荐/取消推荐
	 * @param id
	 * @param out
	 * @throws IOException
	 */
	@RequestMapping("hot")
	public void hot(Jackpot object,HttpServletResponse response)
			throws IOException {
		getResponse(
				jackpotService.hot(object)
			).jsonOut(response);
	}
	
	@RequestMapping("lose/{id}")
	public void lose(@PathVariable("id") String id, 
			HttpServletResponse response) throws IOException {
		Jackpot jackpot=new Jackpot();
		jackpot.setId(id);
		getResponse(
				jackpotService.lose(jackpot)
			).jsonOut(response);
	}

	/**
	 * 导入红包页面
	 * @return
	 */
	@RequestMapping("redPacketInit")
	public void redPacketInit(String productId,Model model) {
		model.addAttribute("productId", productId);
	}
	
	
	@RequestMapping("redPacketPage")
	public void redPacketPage(PageParam pageParam, RedPacket object,
			HttpServletResponse response,String productId) throws IOException {
		String relateId=jackpotService.getAllJackpotRelateIdByRelateType(Jackpot.TYPE_RED_PACKET,productId);
		if(StringUtil.isNotBlank(relateId)){
			object.addCondition("id not in("+relateId+")", Condition.SEP_AND);
		}
		redPacketService.page(pageParam, object).jsonOut(response);
	}
	/**
	 * 导入红包保存
	 * @param ids
	 * @param count
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("redPacketSave")
	public void redPacketSave(String[] ids,Integer[] integra,Integer[] count,Integer[] basic,HttpServletResponse response,String productId) throws IOException{
		getResponse(
				jackpotService.redPacketSave(ids, integra,count,basic,productId)
			).jsonOut(response);
	}
	
	/**
	 * 导入奖品页面
	 * @return
	 */
	@RequestMapping("awardInit")
	public void awardInit(String productId,Model model) {
		model.addAttribute("productId", productId);
	}
	
	@RequestMapping("awardPage")
	public void awardPage(PageParam pageParam, Award object,
			HttpServletResponse response,String productId) throws IOException {
		String relateId=jackpotService.getAllJackpotRelateIdByRelateType(Jackpot.TYPE_AWARD,productId);
		if(StringUtil.isNotBlank(relateId)){
			object.addCondition("id not in("+relateId+")", Condition.SEP_AND);
		}
		awardService.page(pageParam, object).jsonOut(response);
	}
	/**
	 * 导入红包保存
	 * @param ids
	 * @param count
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("awardSave")
	public void awardSave(String[] ids,Integer[] count,Integer[] basic,HttpServletResponse response,String productId) throws IOException{
		getResponse(
				jackpotService.awardSave(ids,count,basic,productId)
			).jsonOut(response);
	}
	
}
