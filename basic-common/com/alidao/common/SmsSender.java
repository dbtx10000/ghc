package com.alidao.common;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alidao.jse.util.StringUtil;
import com.alidao.jse.util.URLEncoder;
import com.alidao.sst.tool.ClientUtil;

public class SmsSender {
	
	private static Log log = 
			LogFactory.getLog(SmsSender.class);

	public static boolean send(String mob, String msg) {
		try {
			String url = Constants.get("sms.url");
			if (StringUtil.isNotBlank(url)) {
				url = url.replace("#mob#", mob);
				url = url.replace("#msg#", msg);
			}
			log.debug(url);
			log.debug(ClientUtil.sendGet(url));
			return true;
		} catch (Exception e) {
			log.error(e.getMessage(), e);
			return false;
		}
	}
	
	public static void main(String[] args) {
		send("13735503505", URLEncoder.encode(Constants.get("sms.scene_3").replace("#code#", "1111")));
	}
	
}
