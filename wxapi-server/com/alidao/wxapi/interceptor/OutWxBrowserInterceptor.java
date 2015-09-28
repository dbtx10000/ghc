package com.alidao.wxapi.interceptor;

import javax.servlet.http.HttpServletRequest;

import com.alidao.jxe.util.HttpUtil;
import com.alidao.sec.invoke.Interceptor;
import com.alidao.sec.invoke.SecurityException;
import com.alidao.sec.invoke.SecurityRequest;
import com.alidao.sec.invoke.SecurityResponse;
import com.alidao.wxapi.util.WxapiUtil;

public class OutWxBrowserInterceptor implements Interceptor {

	public void invoke(SecurityRequest request, SecurityResponse response)
			throws SecurityException {
		HttpServletRequest httprequest = request.getHttpRequest();
		if (!WxapiUtil.fromMicBrowser(httprequest)) {
			response.setIsSecurity(Boolean.FALSE);
			response.setResultType(SecurityResponse.TYPE_PAGE);
			String url = HttpUtil.getWebAppUrl(httprequest) + "/wxapi/warn";
			response.setResultData(url);
		}
	}

}
