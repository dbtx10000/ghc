package com.alidao.wxapi.util;

import java.io.IOException;
import java.util.Arrays;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.alidao.common.Constants;
import com.alidao.jse.global.EncodeVar;
import com.alidao.jse.util.Crypto;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.util.SpringUtil;
import com.alidao.wxapi.bean.ConfigForJsapi;
import com.alidao.wxapi.bean.TicketForJsapi;
import com.alidao.wxapi.bean.TokenForOAuth2;
import com.alidao.wxapi.bean.TokenForWxapis;
import com.alidao.wxapi.bean.UserForWxUnion;
import com.alidao.wxapi.service.WxapiUnionService;

/**
 * 微信api工具
 * @author 胡永伟
 */
public class WxapiUtil {
	
	private WxapiUtil() {}
	
	private static Log log = LogFactory.getLog(WxapiUtil.class);
	
	private static TokenForWxapis tokenforwxapis = null;
	
	private static TicketForJsapi ticketforjsapi = null;

	private static Long tokenforwxapis_lasttimes = null;

	private static Long ticketforjsapi_lasttimes = null;
	
	/**
	 * 微信接入权限认证
	 * @param signature
	 * @param timestamp
	 * @param nonce
	 * @return
	 */
	public static boolean gatePowerCheck(
			String signature, String timestamp, String nonce) {
		if (StringUtil.isNotBlank(signature, timestamp, nonce)) {
			String token = Constants.get("wxapi.token");
			String[] strArr = { token, timestamp, nonce };
			Arrays.sort(strArr);
			String ssign = Crypto.SHA1(strArr[0] + strArr[1] + strArr[2]);
			log.debug("times:" + timestamp);
			log.debug("nonce:" + nonce);
			log.debug("token:" + token);
			log.debug("csign:" + signature);
			log.debug("ssign:" + ssign);
			return signature.equals(ssign);
		} else {
			return false;
		}
	}

	/**
	 * 创建微信自定义菜单
	 * @param access_token
	 * @param json_menu
	 * @return
	 * @throws Exception
	 */
	public static boolean addCustomMenus(
			String access_token, String json_menu) throws Exception {
		String url = "https://api.weixin.qq.com/cgi-bin/menu/create";
        HttpPost post = new HttpPost(url + "?access_token=" + access_token);
        post.setEntity(new StringEntity(json_menu, EncodeVar.UTF_8));
        HttpClient client = SSLUtil.createSSLClient();
        HttpResponse response = client.execute(post);
        String data = EntityUtils.toString(response.getEntity());
        return data.equals("{\"errcode\":0,\"errmsg\":\"ok\"}");
	}
	
	/**
	 * 删除微信自定义菜单
	 * @param access_token
	 * @return
	 * @throws Exception
	 */
	public static boolean delCustomMenus(String access_token) 
			throws Exception {
		String url = "https://api.weixin.qq.com/cgi-bin/menu/delete";
		HttpPost post = new HttpPost(url + "?access_token=" + access_token);
		HttpClient client = SSLUtil.createSSLClient();
        HttpResponse response = client.execute(post);
        String data = EntityUtils.toString(response.getEntity());
        return data.equals("{\"errcode\":0,\"errmsg\":\"ok\"}");
	}
	
	/**
	 * 获取微信api调用所需token
	 * @param appid
	 * @param appsecret
	 * @return
	 * @throws Exception
	 */
	public static TokenForWxapis getWxapisToken(
			String appid, String appsecret) throws Exception {
		synchronized (WxapiUtil.class) {
			if (tokenforwxapis_lasttimes == null || tokenforwxapis == null ||
					new Date().getTime() - tokenforwxapis_lasttimes > 6 * 60 * 1000) {
				String url = "https://api.weixin.qq.com/cgi-bin/token";
				url += "?grant_type=client_credential&appid=%s&secret=%s";
				url = String.format(url, appid, appsecret);
				HttpGet get = new HttpGet(url);
				HttpClient client = SSLUtil.createSSLClient();
				HttpResponse response = client.execute(get);
				String data = EntityUtils.toString(response.getEntity());
				tokenforwxapis = JSON.parseObject(data, TokenForWxapis.class);
				tokenforwxapis_lasttimes = new Date().getTime();
			}
			return tokenforwxapis;
		}
	}
	
	/**
	 * 获取微信网页授权token
	 * @param appid
	 * @param appsecret
	 * @param code
	 * @return
	 * @throws IOException
	 */
	public static TokenForOAuth2 getOAuth2Token(
			String appid, String appsecret, String code) 
					throws IOException {
		String url = "https://api.weixin.qq.com/sns/oauth2/access_token";
		url += "?appid=%s&secret=%s&code=%s&grant_type=authorization_code";
		url = String.format(url, appid, appsecret, code);
		HttpClient client = HttpClients.createDefault();
		HttpResponse response = client.execute(new HttpGet(url));
		HttpEntity entity = response.getEntity();
		String content = EntityUtils.toString(entity);
		return JSON.parseObject(content, TokenForOAuth2.class);
	}

	/**
	 * 获取微信jsapi调用票据
	 * @param access_token
	 * @return
	 * @throws Exception
	 */
	public static TicketForJsapi getJsapiTicket(
			String access_token) throws Exception {
		synchronized (WxapiUtil.class) {
			if (ticketforjsapi_lasttimes == null || ticketforjsapi == null || 
					new Date().getTime() - ticketforjsapi_lasttimes > 6 * 60 * 1000) {
				String url = "?access_token=" + access_token + "&type=jsapi";
				url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket" + url;
				HttpGet get = new HttpGet(url);
				HttpClient client = SSLUtil.createSSLClient();
		        HttpResponse response = client.execute(get);
		        String data = EntityUtils.toString(response.getEntity());
		        ticketforjsapi = JSON.parseObject(data, TicketForJsapi.class);
		        ticketforjsapi_lasttimes = new Date().getTime();
			}
			return ticketforjsapi;
		}
	}
	
	/**
	 * 获取微信jsapi调用配置
	 * @param appid
	 * @param jsapi_ticket
	 * @param url
	 * @return
	 * @throws Exception
	 */
	public static ConfigForJsapi getJsapiConfig(
			String appid, String jsapi_ticket, String url) 
					throws Exception {
		String nonce = Crypto.MD5(UUID.randomUUID().toString());
		String timestamp = String.valueOf(new Date().getTime() / 1000);
		String src = "jsapi_ticket=%s&noncestr=%s&timestamp=%s&url=%s";
		src = String.format(src, jsapi_ticket, nonce, timestamp, url);
		String signature = Crypto.SHA1(src);
		ConfigForJsapi config = new ConfigForJsapi();
		config.setAppid(appid);
		config.setNonce(nonce);
		config.setTimestamp(timestamp);
		config.setSignature(signature);
		return config;
	}

	private static WxapiUnionService wxapiUnionService;
	
	/**
	 * 获取微信用户信息
	 * @param access_token
	 * @param openid
	 * @return
	 * @throws Exception
	 */
	public static UserForWxUnion getWxUnionUser(
			String access_token, String openid) throws Exception {
		// 搜索数据库
		if (wxapiUnionService == null) {
			wxapiUnionService = (WxapiUnionService) 
					SpringUtil.getBean("wxapiUnionServiceImpl");
		}
		UserForWxUnion union=new UserForWxUnion();
		union.setOpenid(openid);
		union=wxapiUnionService.find(union);
		if(union==null){
			String url = "?access_token=%s&openid=%s&lang=zh_CN";
			url = "https://api.weixin.qq.com/cgi-bin/user/info" + url;
			url = String.format(url, access_token, openid);
			HttpGet get = new HttpGet(url);
			HttpClient client = SSLUtil.createSSLClient();
			HttpResponse response = client.execute(get);
			String data = EntityUtils.toString(response.getEntity());
			union = JSON.parseObject(data, UserForWxUnion.class);
			String nickname = union.getNickname();
			if (StringUtil.isNotBlank(nickname)) {
				nickname = new String(nickname.getBytes("iso-8859-1"), "utf-8");
				union.setNickname(nickname);
			}
			wxapiUnionService.save(union);
		}
		return union;
	}
	
	public static boolean fromMicBrowser(HttpServletRequest request) {
		String agent = request.getHeader("User-Agent").toLowerCase();
		if (agent.indexOf("micromessenger") > -1) {
			return true;
		}
		return false;
	}
	
	/**
	 * 推送消息模版
	 * @param access_token
	 * @param openid
	 * @param templateID
	 * @param detailUrl
	 * @param json_data
	 * @return
	 * @throws Exception
	 */
	public static boolean sendTM2WxUser(
			String access_token, String openid, String templateID, 
			String detailUrl, String json_data) throws Exception {
		String url = "https://api.weixin.qq.com/cgi-bin/message/template/send";
		HttpPost post = new HttpPost(url + "?access_token=" + access_token);
		String postParam = "{\"touser\":\"%s\",\"template_id\":\"%s\",\"url\":\"%s\",\"topcolor\":\"#FF0000\",\"data\":%s}";
		postParam = String.format(postParam, openid, templateID, detailUrl, json_data);
		post.setEntity(new StringEntity(postParam, EncodeVar.UTF_8));
		HttpClient client = SSLUtil.createSSLClient();
		HttpResponse response = client.execute(post);
		String data = EntityUtils.toString(response.getEntity());
		System.out.println(data);
		return data.startsWith("{\"errcode\":0,\"errmsg\":\"ok\"");
	}
	
}
