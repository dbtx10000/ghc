package com.alidao.users.interceptor;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alidao.jse.util.StringUtil;
import com.alidao.jse.util.URLEncoder;
import com.alidao.jxe.help.PowerHelper;
import com.alidao.jxe.util.HttpUtil;
import com.alidao.jxe.util.SpringUtil;
import com.alidao.sec.invoke.Interceptor;
import com.alidao.sec.invoke.SecurityRequest;
import com.alidao.sec.invoke.SecurityResponse;
import com.alidao.users.authorizing.UseridTracker;
import com.alidao.users.entity.User;
import com.alidao.users.service.UserService;
import com.alidao.wxapi.util.OpenidTracker;
import com.alidao.wxapi.util.WxapiUtil;

public class WapUserPowerInterceptor implements Interceptor {
	
	private Log log = LogFactory.getLog(this.getClass());
	
	private UserService userService;
	
	public void invoke(SecurityRequest request, SecurityResponse response)
			throws SecurityException {
		userService = (UserService) SpringUtil.getBean("userServiceImpl");
		HttpServletRequest httprequest = request.getHttpRequest();
		if (!isSecurity(httprequest)) {
			if (isRequestFromAjax(httprequest)) {
				response.setResultType(SecurityResponse.TYPE_JSON);
				response.setResultData("{\"result\":401,\"message\":\"请先登录!\"}");
				response.setIsSecurity(Boolean.FALSE);
			} else {
				response.setResultType(SecurityResponse.TYPE_PAGE);
				response.setResultData(getUserLoginUrlAndRedirectUri(httprequest));
				response.setIsSecurity(Boolean.FALSE);
			}
		}
	}
	
	private String getUserLoginUrlAndRedirectUri(HttpServletRequest request) {
		String webapp = HttpUtil.getWebAppUrl(request);
		String rUrl = HttpUtil.getRedirectUri(request);
		rUrl = URLEncoder.encode(webapp + rUrl);
		return webapp + "/wap/user/slogin?redirect_uri=" + rUrl;
	}
	
	private boolean isRequestFromAjax(HttpServletRequest request) {
		return "XMLHttpRequest".equals(request.getHeader("x-requested-with"));
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
		log.info("power:{openid:" + openid + "}");
		User user = userService.find(openid, User.BINDED_WECHAT);
		if (user != null && StringUtil.isNotBlank(user.getSessionKey())) {
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
