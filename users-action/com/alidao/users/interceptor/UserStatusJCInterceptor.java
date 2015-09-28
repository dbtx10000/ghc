package com.alidao.users.interceptor;

import javax.servlet.http.HttpServletRequest;

import com.alidao.jxe.util.HttpUtil;
import com.alidao.sec.invoke.Interceptor;
import com.alidao.sec.invoke.SecurityRequest;
import com.alidao.sec.invoke.SecurityResponse;
import com.alidao.users.entity.User;

public class UserStatusJCInterceptor implements Interceptor {
	
	public void invoke(SecurityRequest request, SecurityResponse response)
			throws SecurityException {
		HttpServletRequest httprequest = request.getHttpRequest();
		if (!isSecurity(httprequest)) {
			if (isRuquestFromAjax(httprequest)) {
				response.setResultType(SecurityResponse.TYPE_JSON);
				response.setResultData("{\"result\":403,\"message\":\"账号异常!\"}");
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
		return webapp + "/wap/user/slogin?redirect_uri=" + rUrl;
	}
	
	private boolean isRuquestFromAjax(HttpServletRequest request){
		return "XMLHttpRequest".equals(request.getHeader("x-requested-with"));
	}

	/**
	 * 判断是否安全
	 * @param request
	 * @return
	 */
	private Boolean isSecurity(HttpServletRequest request) {
		Integer status = (Integer) request.getAttribute("u.status");
		return User.STATUS_NORMAL == status;
	}
	
}
