package com.alidao.gifts.wap.control;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alidao.basic.service.SmsService;
import com.alidao.gifts.entity.RedPackageEvent;
import com.alidao.gifts.entity.RedPackageRecord;
import com.alidao.gifts.service.RedPackageEventService;
import com.alidao.gifts.service.RedPackageRecordService;
import com.alidao.jse.util.DateUtil;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.help.PowerHelper;
import com.alidao.jxe.model.Condition;
import com.alidao.jxe.model.PageParam;
import com.alidao.jxe.util.HttpUtil;
import com.alidao.users.authorizing.UseridTracker;
import com.alidao.users.entity.User;
import com.alidao.users.service.UserService;
import com.alidao.wxapi.util.OpenidTracker;
import com.alidao.wxapi.util.WxapiUtil;

@Controller
@RequestMapping("wap/redPackageEvent")
public class RedPackageEventWapCtrl extends WebCtrl {
	
	private static final Object LOCK = new Object();
	
	@Autowired
	private RedPackageEventService redPackageEventService;
	
	@Autowired
	private RedPackageRecordService redPackageRecordService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private SmsService smsService;
	
	/**
	 * 进入领红包首页面
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("index")
	public String index(Model model, String id, HttpServletRequest request) throws IOException {
		RedPackageEvent redPackageEvent=redPackageEventService.find(id);
		model.addAttribute("shareEventDate", DateUtil.getDateSampleString(redPackageEvent.getStartTime(), "MM.dd")+"-"+DateUtil.getDateSampleString(redPackageEvent.getEndTime(), "MM.dd"));
		model.addAttribute("eventDate", DateUtil.getDateSampleString(redPackageEvent.getStartTime(), "yyyy年MM月dd日")+"-"+DateUtil.getDateSampleString(redPackageEvent.getEndTime(), "MM月dd日"));
		Date date = new Date();
		boolean flag = date.before(redPackageEvent.getEndTime()) && date.after(redPackageEvent.getStartTime());
		if (redPackageEvent != null && redPackageEvent.getStatus() == RedPackageEvent.STATUS_EVENT_BEGIN && flag) {
			String _user = isSecurity(request) ? UseridTracker.get() : null;
			if(!StringUtil.isEmpty(_user)){
				RedPackageRecord redPackageRecord=new RedPackageRecord();
				redPackageRecord.setUserId(_user);
				redPackageRecord.setSourceId(id);
				redPackageRecord=redPackageRecordService.find(redPackageRecord);
				if (redPackageRecord!=null) {
					model.addAttribute("recordList",getRecordList(id));
					model.addAttribute("redPackageEventId", id);
					model.addAttribute("integral", redPackageRecord.getIntegral());
					model.addAttribute("minIntegral", redPackageEvent.getMinIntegral());
					model.addAttribute("lctx", HttpUtil.getWebAppUrl(request));
					return "wap/redPackageEvent/red_open";
				}
			}
			model.addAttribute("lctx", HttpUtil.getWebAppUrl(request));
			model.addAttribute("redPackageEventId", id);
			return "wap/redPackageEvent/index";
		}else{
			model.addAttribute("lctx", HttpUtil.getWebAppUrl(request));
			model.addAttribute("recordList",getRecordList(id));
			model.addAttribute("redPackageEventId", id);
			return "wap/redPackageEvent/red_close";
		}
		
	}

	/**
	 * 分享后领红包操作
	 * @throws IOException
	 */
	@RequestMapping("getRedPackage")
	public String getRedPackage(Model model, String redPackageEventId, HttpServletRequest request) throws IOException {
		RedPackageEvent redPackageEvent=redPackageEventService.find(redPackageEventId);
		model.addAttribute("shareEventDate", DateUtil.getDateSampleString(redPackageEvent.getStartTime(), "MM.dd")+"-"+DateUtil.getDateSampleString(redPackageEvent.getEndTime(), "MM.dd"));
		model.addAttribute("eventDate", DateUtil.getDateSampleString(redPackageEvent.getStartTime(), "yyyy年MM月dd日")+"-"+DateUtil.getDateSampleString(redPackageEvent.getEndTime(), "MM月dd日"));
		String _user = isSecurity(request) ? UseridTracker.get() : null;
		if (StringUtil.isEmpty(_user)) {
			model.addAttribute("redPackageEventId", redPackageEventId);
			model.addAttribute("recordList",getRecordList(redPackageEventId));
			model.addAttribute("lctx", HttpUtil.getWebAppUrl(request));
			return "wap/redPackageEvent/phone";//输入手机号码页面
		} else {
			RedPackageRecord redPackageRecord=new RedPackageRecord();
			redPackageRecord.setUserId(_user);
			redPackageRecord.setSourceId(redPackageEventId);
			redPackageRecord = redPackageRecordService.find(redPackageRecord);
			if (redPackageRecord==null) {
				redPackageRecord=redPackageRecordService.save(redPackageEventId, _user, redPackageEvent.getMinIntegral());//老用户
			}
			model.addAttribute("recordList",getRecordList(redPackageEventId));
			model.addAttribute("integral", redPackageRecord.getIntegral());
			model.addAttribute("redPackageEventId", redPackageEventId);
			model.addAttribute("minIntegral", redPackageEvent.getMinIntegral());
			model.addAttribute("lctx", HttpUtil.getWebAppUrl(request));
			return "wap/redPackageEvent/red_open";
		}
		
	}
	
	/**
	 * 输入手机号码绑定并领取红包
	 * @throws Exception
	 */
	@RequestMapping("bindAndGet")
	public String bindAndGet(Model model, String redPackageEventId, String mobile, String token, HttpServletRequest request) throws Exception {
		synchronized (LOCK) {
			if (smsService.isok(mobile, token)) {
				RedPackageEvent redPackageEvent = redPackageEventService.find(redPackageEventId);
				model.addAttribute("shareEventDate", DateUtil.getDateSampleString(redPackageEvent.getStartTime(), "MM.dd")+"-"+DateUtil.getDateSampleString(redPackageEvent.getEndTime(), "MM.dd"));
				model.addAttribute("eventDate", DateUtil.getDateSampleString(redPackageEvent.getStartTime(), "yyyy年MM月dd日")+"-"+DateUtil.getDateSampleString(redPackageEvent.getEndTime(), "MM月dd日"));
				RedPackageRecord record = new RedPackageRecord();
				record = redPackageRecordService.bindAndGet(redPackageEventId, mobile, OpenidTracker.get());
				model.addAttribute("integral", record.getIntegral());
				model.addAttribute("recordList",getRecordList(redPackageEventId));
				model.addAttribute("redPackageEventId", redPackageEventId);
				model.addAttribute("minIntegral", redPackageEvent.getMinIntegral());
				model.addAttribute("lctx", HttpUtil.getWebAppUrl(request));
				smsService.used(token);
				return "wap/redPackageEvent/red_open";
			} else {
				return "redirect:".concat("/wap/redPackageEvent/index?id=" + redPackageEventId);
			}
		}
	}
	
	/**
	 * 根据红包活动Id 查询该活动领红包记录
	 * @param redPackageEventId
	 * @return
	 */
	public List<RedPackageRecord> getRecordList(String redPackageEventId) {
		RedPackageRecord object = new RedPackageRecord();
		object.setSourceId(redPackageEventId);
		object.addCondition("user_image is not null", Condition.SEP_AND);
		PageParam params = new PageParam();
		params.setPageNo(1L);
		params.setPageSize(50L);
		params.setSortWay("create_time desc");
		return redPackageRecordService.page(params, object).getTableList();
	}
	
	/**
	 * 判断是否安全
	 * @param request
	 * @return
	 */
	private Boolean isSecurity(
			HttpServletRequest request) {
		if (WxapiUtil.fromMicBrowser(request)) {
			return hasBinding(request);
		} else {
			return hasLogined(request);
		}
	}
	
	/**
	 * 判断微信用户是否绑定
	 * @param request 
	 * @return
	 */
	private boolean hasBinding(HttpServletRequest request) {
		String openid = OpenidTracker.get();
		User user = userService.find(openid, User.BINDED_WECHAT);
		if (user != null) {
			UseridTracker.set(user.getId());
			request.setAttribute("uid", user.getId());
			request.setAttribute("u.status", user.getStatus());
			return true;
		}
		return false;
	}
	
	/**
	 * 判断用户的会话时否已经丢失或失效
	 * @param request 
	 * @return
	 */
	private boolean hasLogined(HttpServletRequest request) {
		String power = PowerHelper.get();
		if (StringUtil.isNotBlank(power)) {
			User user = userService.find(power);
			if (user != null) {
				UseridTracker.set(power);
				request.setAttribute("uid", power);
				int status = user.getStatus();
				request.setAttribute("u.status", status);
				return true;
			}
		}
		return false;
	}
	
}
