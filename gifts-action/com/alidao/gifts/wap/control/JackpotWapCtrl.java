package com.alidao.gifts.wap.control;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.gifts.service.JackpotService;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.ResponseForAjax;
import com.alidao.jxe.util.HttpUtil;
import com.alidao.users.authorizing.UseridTracker;
@Controller
@RequestMapping("wap/jackpot")
public class JackpotWapCtrl extends WebCtrl {
	private static final Object LOCK = new Object();
	@Autowired
	private JackpotService jackpotService;
	/**
	 * 抽奖页面
	 * 
	 */
	@RequestMapping("index")
	public void index(HttpServletRequest request,
			String id, Model model) {
		String lctx = HttpUtil.getWebAppUrl(request);
		model.addAttribute("lctx", lctx);
		model.addAttribute("id", id);
	}
	/**
	 * 抽奖
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping("shake")
	public void shake(HttpServletRequest request,
			HttpServletResponse response,String id) throws IOException {
		String uid = UseridTracker.get();
		ResponseForAjax resp = new ResponseForAjax();
		Map<String,Object> map=null;
		try {
			//调用抽奖方法
			synchronized (LOCK) {
				map = jackpotService.luckyDraw(uid, id);
				if (map==null) {
					resp.setResult(0);
					resp.setMessage("没有抽到奖品，不要灰心哦");
				} else {
					if (map.get("result") == Integer.valueOf(-1)) {
						resp.setResult(-1);
						resp.setMessage("没有抽奖机会");
					} else if (map.get("result") == Integer.valueOf(-2)) {
						resp.setResult(-2);
						resp.setMessage("对不起，您已使用该抽奖资格");
					} else {
						resp=getQueryResponse(map);
					}
				}
			}
		} catch (Exception e) {
			resp = getErrResponse(e);
		}
		resp.jsonOut(response);
	}
	
}
