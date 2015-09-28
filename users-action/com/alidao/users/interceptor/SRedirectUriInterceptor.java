package com.alidao.users.interceptor;

import javax.servlet.http.HttpServletRequest;

import com.alidao.jse.util.StringUtil;
import com.alidao.jse.util.URLDecoder;
import com.alidao.jse.util.URLEncoder;
import com.alidao.sec.invoke.Interceptor;
import com.alidao.sec.invoke.SecurityRequest;
import com.alidao.sec.invoke.SecurityResponse;

public class SRedirectUriInterceptor implements Interceptor {

	public void invoke(SecurityRequest request, SecurityResponse response)
			throws SecurityException {
		HttpServletRequest httprequest = request.getHttpRequest();
		String redirect_uri = httprequest.getParameter("redirect_uri");
		if (StringUtil.isNotBlank(redirect_uri)) {
			redirect_uri = URLEncoder.encode(URLDecoder.decode(redirect_uri));
			httprequest.setAttribute("redirect_uri", redirect_uri);
		}
	}
}
