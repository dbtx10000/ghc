package com.alidao.users.wap.control;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.jxe.control.WebCtrl;
import com.alidao.users.entity.UserRiskEvaluation;
import com.alidao.users.service.UserRiskEvaluationService;
@Controller
@RequestMapping("wap/riskEvaluation")
public class UserRiskEvaluationWapCtrl extends WebCtrl {
	@Autowired
	private UserRiskEvaluationService userRiskEvaluationService;
	/**
	 * 评测页面
	 * 
	 */
	@RequestMapping("index")
	public void index(Model model){
		model.addAttribute("map", userRiskEvaluationService.index());
	}
	
	@RequestMapping("part{id}")
	public void part(Integer score,Model model){
		model.addAttribute("score", score);
	}
	
	@RequestMapping("finish")
	public void finish(Integer score,Model model){
		model.addAttribute("score", score);
	}
	
	
/**
 * 评测
 * @param answer
 * @param response
 * @throws IOException
 */
	@RequestMapping("riskEvaluation")
	public void riskEvaluation(UserRiskEvaluation object,
			HttpServletResponse response) 
			throws IOException {
		getResponse(
				userRiskEvaluationService.save(object)
		).jsonOut(response);
	}
}
