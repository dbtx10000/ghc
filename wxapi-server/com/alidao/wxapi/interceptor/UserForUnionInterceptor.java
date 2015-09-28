package com.alidao.wxapi.interceptor;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alidao.common.Constants;
import com.alidao.sec.invoke.Interceptor;
import com.alidao.sec.invoke.SecurityException;
import com.alidao.sec.invoke.SecurityRequest;
import com.alidao.sec.invoke.SecurityResponse;
import com.alidao.wxapi.bean.TokenForWxapis;
import com.alidao.wxapi.bean.UserForWxUnion;
import com.alidao.wxapi.util.OpenidTracker;
import com.alidao.wxapi.util.WxapiUtil;

public class UserForUnionInterceptor implements Interceptor {

	private Log log = LogFactory.getLog(this.getClass());
	
	public void invoke(SecurityRequest request, SecurityResponse response)
			throws SecurityException {
		HttpServletRequest httprequest = request.getHttpRequest();
		if (WxapiUtil.fromMicBrowser(httprequest)) {
			String appid = Constants.get("wxapi.appid");
			String appsecret = Constants.get("wxapi.appsecret");
			String openid = OpenidTracker.get();
			try {
				TokenForWxapis token = WxapiUtil.
					getWxapisToken(appid, appsecret);
				String access_token = token.getAccess_token();
				UserForWxUnion union = WxapiUtil.
					getWxUnionUser(access_token, openid);
				httprequest.setAttribute("union", union);
			} catch (Exception e) {
				log.error(e.getMessage(), e);
			}
		}
	}

}
