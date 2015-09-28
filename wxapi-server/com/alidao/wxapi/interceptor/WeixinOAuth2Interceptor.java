package com.alidao.wxapi.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.alidao.common.Constants;
import com.alidao.jse.util.StringUtil;
import com.alidao.jse.util.URLEncoder;
import com.alidao.jxe.util.HttpUtil;
import com.alidao.sec.invoke.Interceptor;
import com.alidao.sec.invoke.SecurityException;
import com.alidao.sec.invoke.SecurityRequest;
import com.alidao.sec.invoke.SecurityResponse;
import com.alidao.wxapi.util.OpenidTracker;
import com.alidao.wxapi.util.WxapiUtil;

public class WeixinOAuth2Interceptor implements Interceptor {

	public void invoke(SecurityRequest request, SecurityResponse response)
			throws SecurityException {
		HttpServletRequest httprequest = request.getHttpRequest();
		if (WxapiUtil.fromMicBrowser(httprequest)) {
			String openid = getOpenidFromHttp(httprequest);
			if (StringUtil.isEmpty(openid)) {
				String redirect = HttpUtil.getWebAppUrl(httprequest);
				redirect += "/wxapi/auth?redirect_uri=";
				redirect +=	HttpUtil.getRedirectUri(httprequest);
				redirect = URLEncoder.encode(redirect);
				String url = "https://open.weixin.qq.com/connect/oauth2/authorize";
				url += "?appid=%s&redirect_uri=%s&response_type=code&scope=snsapi_base";
				url += "&state=%s#wechat_redirect";
				url = String.format(url, Constants.get("wxapi.appid"), redirect, null);
				response.setIsSecurity(Boolean.FALSE);
				response.setResultType(SecurityResponse.TYPE_PAGE);
				response.setResultData(url);
			} else {
				httprequest.setAttribute("openid", openid);
				OpenidTracker.set(openid);
			}
		}
	}
	
	/**
	 * 从Http参数中获取openid
	 * @param request
	 * @return
	 */
	private String getOpenidFromHttp(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		Object attribute = session.getAttribute("openid");
		if (attribute != null) {
			return (String) attribute;
		}
		return null;
	}

}
