package com.alidao.gifts.web.control;
import java.io.IOException;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alidao.gifts.entity.Jackpot;
import com.alidao.gifts.entity.Award;
import com.alidao.gifts.service.JackpotService;
import com.alidao.gifts.service.AwardService;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.PageParam;

@Controller
@RequestMapping("award")
public class AwardCtrl extends WebCtrl {

	@Autowired
	private AwardService awardService;
	
	@Autowired
	private JackpotService jackpotService;
	
	@RequestMapping("init")
	public void init() {}

	@RequestMapping("page")
	public void page(PageParam pageParam, 
			Award object, HttpServletResponse response) 
					throws Exception {
		awardService.page(pageParam, object).jsonOut(response);
	}


	@RequestMapping("input")
	public void edit(String id, Model model) {
		if (id != null) {
			Award object = awardService.find(id);
			model.addAttribute("object", object);
		}
	}

	@RequestMapping("save")
	public void save(
			HttpServletResponse response, 
			Award object)
			throws Exception {
		if (StringUtil.isEmpty(object.getId())) {
			object.setResidueCount(object.getCount());
			getResponse(
				awardService.save(object)
			).jsonOut(response);
		} else {
			getResponse(
				awardService.mdfy(object)
			).jsonOut(response);
		}
	}
	
	@RequestMapping("lose/{id}")
	public void lose(
			@PathVariable("id") String id, 
			HttpServletResponse response)
			throws Exception {
		getResponse(
			awardService.lose(id)
		).jsonOut(response);
	}
	
	/**
	 * 删除奖品时检查奖池是否有该奖品
	 * @param integral
	 * @param out
	 * @throws IOException
	 */
	@RequestMapping("checkJackpot")
	public void checkJackpot(String relateId,HttpServletResponse response) throws IOException {
		Jackpot jackpot=new Jackpot();
		jackpot.setRelateId(relateId);
		jackpot.setRelateType(Jackpot.TYPE_AWARD);
		jackpot=jackpotService.find(jackpot);
		if(jackpot==null){
			getResponse(1).jsonOut(response);
		}else{
			getResponse(0).jsonOut(response);
		}
	}
}
