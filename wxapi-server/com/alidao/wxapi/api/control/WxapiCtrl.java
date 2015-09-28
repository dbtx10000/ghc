package com.alidao.wxapi.api.control;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.alidao.common.Constants;
import com.alidao.jse.util.StringUtil;
import com.alidao.jse.util.URLDecoder;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.util.HttpUtil;
import com.alidao.wxapi.bean.TicketForJsapi;
import com.alidao.wxapi.bean.TokenForOAuth2;
import com.alidao.wxapi.bean.TokenForWxapis;
import com.alidao.wxapi.bean.WxChatResult;
import com.alidao.wxapi.bean.WxChatResultArticle;
import com.alidao.wxapi.entity.WxapiChats;
import com.alidao.wxapi.entity.WxapiReply;
import com.alidao.wxapi.entity.WxapiReplyNews;
import com.alidao.wxapi.service.WxapiChatsService;
import com.alidao.wxapi.service.WxapiReplyNewsService;
import com.alidao.wxapi.service.WxapiReplyService;
import com.alidao.wxapi.util.WxapiUtil;

/**
 * 微信网关请求
 * @author 胡永伟
 */
@Controller
@RequestMapping("wxapi")
public class WxapiCtrl extends WebCtrl {
	
	private static final String MSG_TYPE_TEXT = "text";
	private static final String MSG_TYPE_LOCATION = "location";
	private static final String MSG_TYPE_EVENT = "event";
	private static final String MSG_TYPE_IMAGE = "image";
	private static final String MSG_TYPE_VOICE = "voice";
	private static final String MSG_TYPE_VIDEO = "video";
	private static final String MSG_TYPE_LINK = "link";
	private static final String MSG_TYPE_SCAN = "scan";
	
	private static final String EVENT_SUBSCRIBE = "subscribe";
//	private static final String EVENT_UNSUBSCRIBE = "unsubscribe";
	private static final String EVENT_CLICK = "CLICK";
//	private static final String EVENT_VIEW = "VIEW";
//	private static final String EVENT_LOCATION = "LOCATION";
	
	
	private static final String MSG_TYPE_NEWS = "news";
	
	@Autowired
	private WxapiChatsService wxapiChatsService;

	@Autowired
	private WxapiReplyNewsService wxapiReplyNewsService;

	@Autowired
	private WxapiReplyService wxapiReplyService;
	
	
	/**
	 * 微信接入
	 * @param signature
	 * @param timestamp
	 * @param nonce
	 * @param echostr
	 * @param out
	 */
	@RequestMapping(value = "gate", method = RequestMethod.GET)
	public void gate(String signature, String timestamp, 
			String nonce, String echostr, PrintWriter out) {
		boolean power = WxapiUtil.
				gatePowerCheck(signature, timestamp, nonce);
		out.print(power ? echostr : "fail");
	}

	/**
	 * 微信回复
	 * @param signature
	 * @param timestamp
	 * @param nonce
	 * @param echostr
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "gate", method = RequestMethod.POST)
	public String gate(String signature, String timestamp, 
			String nonce, Model model, PrintWriter out, 
			HttpServletRequest request) throws Exception {
		if (WxapiUtil.gatePowerCheck(signature, timestamp, nonce)) {
			Map<String, String> wxchat = getDataFromWxChat(request);
			WxapiChats object = new WxapiChats();
			WxChatResult result = new WxChatResult();
			RecordWxChatDataAndSetResult(wxchat, object, result);
			String msgType = object.getMsgType();
			String key = null;
			Integer mode = WxapiReply.MODE_NOT; 
			if (MSG_TYPE_EVENT.equals(msgType)) {
				if (EVENT_SUBSCRIBE.equals(object.getEvent())) {
					mode = WxapiReply.MODE_SUB;
				} else if (EVENT_CLICK.equals(object.getEvent())) {
					mode = WxapiReply.MODE_KEY;
					key = object.getEventKey();
				} else {
					return "wxapi/reply/teml/fail";
				}
			} else if (MSG_TYPE_TEXT.equals(msgType)) {	// 文本
				mode = WxapiReply.MODE_KEY;
				key = object.getContent();
			} else if (MSG_TYPE_VOICE.equals(msgType)) {// 语音
				key = object.getRecognition();
				if (StringUtil.isNotBlank(key)) {
					mode = WxapiReply.MODE_KEY;
				}
			}
			WxapiReply wxapiReply = new WxapiReply();
			wxapiReply.setMode(mode);
			if (mode == WxapiReply.MODE_SUB	// 关注时回复|无应答回复
					|| mode == WxapiReply.MODE_NOT) {	
				wxapiReply = wxapiReplyService.find(wxapiReply);
			} else {
				wxapiReply.setTags(key);
				wxapiReply = wxapiReplyService.find(wxapiReply);
				if (wxapiReply == null) {
					wxapiReply = new WxapiReply();
					wxapiReply.setMode(WxapiReply.MODE_KEY);
					wxapiReply.addCondition(
						"tags", WxapiReply.CDT_LIKE, 
						"'" + totalFuzzy(object.getContent()) + "'", 
						WxapiReply.SEP_AND
					);
					wxapiReply = wxapiReplyService.find(wxapiReply);
					if (wxapiReply == null) {
						wxapiReply = new WxapiReply();
						wxapiReply.setMode(WxapiReply.MODE_NOT);
						wxapiReply = wxapiReplyService.find(wxapiReply);
					}
				}
			}
			if (wxapiReply != null) {
				if (wxapiReply.getType() == 1) {
					result.setMsgType(MSG_TYPE_TEXT);
					result.setContent(wxapiReply.getTxt());
				} else if (wxapiReply.getType() == 6) {
					WxapiReplyNews wxapiReplyNews = new WxapiReplyNews();
					wxapiReplyNews.setReplyId(wxapiReply.getId());
					List<WxapiReplyNews> newslist = 
							wxapiReplyNewsService.list(wxapiReplyNews);
					if (newslist != null && newslist.size() > 0) {
						result.setMsgType(MSG_TYPE_NEWS);
						List<WxChatResultArticle> articles =
								new ArrayList<WxChatResultArticle>();
						for (WxapiReplyNews news : newslist) {
							WxChatResultArticle article = 
									new WxChatResultArticle();
							article.setTitle(news.getTitle());
							article.setPicUrl(news.getPicUrl());
							article.setDescription(news.getDescription());
							String url = news.getUrl();
							if (news.getType() == 2) {
								url = HttpUtil.getWebAppUrl(request);
								url += "/wxapi/news/" + news.getId();
							}
							if (url.indexOf('?') > -1) {
								url += "&openid=" + object.getFromUserName();
							} else {
								url += "?openid=" + object.getFromUserName();
							}
							article.setUrl(url);
							articles.add(article);
						}
						result.setArticleCount(newslist.size());
						result.setArticles(articles);
					}
				}
				Integer qNum = wxapiReply.getQueryCount();
				wxapiReply.setQueryCount(qNum + 1);
				wxapiReplyService.mdfy(wxapiReply);
				model.addAttribute("object", result);
				msgType = result.getMsgType();
				if (MSG_TYPE_TEXT.equals(msgType)) {
					return "wxapi/reply/teml/text";
				} else if (MSG_TYPE_NEWS.equals(msgType)) {
					return "wxapi/reply/teml/news";
				}
			}
		}
		return "wxapi/reply/teml/fail";
	}
	
	private void RecordWxChatDataAndSetResult(
			Map<String, String> wxchat, WxapiChats object, 
			WxChatResult result) {
		object.setFromUserName(wxchat.get("FromUserName"));
		result.setToUserName(wxchat.get("FromUserName"));
		object.setToUserName(wxchat.get("ToUserName"));
		result.setFromUserName(wxchat.get("ToUserName"));
		String type = wxchat.get("MsgType");
		object.setMsgType(type);
		object.setMsgId(wxchat.get("MsgId"));
		if (MSG_TYPE_TEXT.equals(type)) {			// 文本
			object.setContent(wxchat.get("Content"));
		} else if (MSG_TYPE_IMAGE.equals(type)) {	// 图片
			object.setPicUrl(wxchat.get("PicUrl"));
			object.setMediaId(wxchat.get("MediaId"));
		} else if (MSG_TYPE_VOICE.equals(type)) {	// 语音
			object.setMediaId(wxchat.get("MediaId"));
			object.setFormat(wxchat.get("Format"));
			object.setRecognition(wxchat.get("Recognition"));
		} else if (MSG_TYPE_VIDEO.equals(type)) {	// 视频
			object.setMediaId(wxchat.get("MediaId"));
			object.setThumbMediaId(wxchat.get("ThumbMediaId"));
		} else if (MSG_TYPE_LOCATION.equals(type)) {// 地理位置
			object.setLocationX(wxchat.get("Location_X"));
			object.setLocationY(wxchat.get("Location_Y"));
			object.setScale(wxchat.get("Scale"));
			object.setLabel(wxchat.get("Label"));
		} else if (MSG_TYPE_LINK.equals(type)) {	// 链接消息
			object.setTitle(wxchat.get("Title"));
			object.setDescription(wxchat.get("Description"));
			object.setUrl(wxchat.get("Url"));
		} else if (MSG_TYPE_EVENT.equals(type)) {	// 事件推送
			object.setEvent(wxchat.get("Event"));
			// 关注/取消关注事件	event = subscribe|unsubscribe
			// 用户已关注时的事件推送	event = scan
			object.setEventKey(wxchat.get("EventKey"));
			object.setTicket(wxchat.get("Ticket"));
			// 上报地理位置事件		event = location
			object.setLocationX(wxchat.get("Latitude"));
			object.setLocationY(wxchat.get("Longitude"));
			object.setScale(wxchat.get("Precision"));
			// 自定义菜单事件		event = click|view
			object.setEventKey(wxchat.get("EventKey"));
		} else if (MSG_TYPE_SCAN.equals(type)) {	// 已关注时
			object.setEvent(wxchat.get("Event"));
			object.setEventKey(wxchat.get("EventKey"));
			object.setTicket(wxchat.get("Ticket"));
		}
		object.setWxCreateTime(Long.valueOf(wxchat.get("CreateTime")));
		wxapiChatsService.save(object);
		Long createTime = object.getCreateTime().getTime();
		result.setCreateTime(createTime / 1000);
	}

	/**
	 * 获取微信聊天数据
	 * @param request
	 * @return
	 * @throws Exception
	 */
	private Map<String, String> getDataFromWxChat(
			HttpServletRequest request) throws Exception {
		InputStream in = request.getInputStream();
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document document = builder.parse(in);
		Element root = document.getDocumentElement();
		Map<String, String> data = new HashMap<String, String>();
		NodeList nodes = root.getChildNodes();
		for (int i = 0; i < nodes.getLength(); i++) {
			Node node = nodes.item(i);
			String key = node.getNodeName();
			if (!"#text".equals(key)) {
				String value = node.getTextContent();
				data.put(key, value);
			}
		}
		return data;
	}

	/**
	 * 微信网页授权网关
	 * @param code
	 * @param state
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("auth")
	public String auth(String code, String state, 
			String redirect_uri, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String appid = Constants.get("wxapi.appid");
		String appsecret = Constants.get("wxapi.appsecret");
		TokenForOAuth2 token = WxapiUtil.
				getOAuth2Token(appid, appsecret, code);
		String openid = token.getOpenid();
		if (StringUtil.isNotBlank(openid)) {
			setOpenidToSession(request, openid);
			setOpenidToCookie(openid, response);
		}
		redirect_uri = URLDecoder.decode(redirect_uri);
		if (redirect_uri.indexOf("?") > -1) {
			redirect_uri += "&openid=" + openid;
		} else {
			redirect_uri += "?openid=" + openid;
		}
		log.info("wxapi:{openid:" + openid + "}");
		return "redirect:".concat(redirect_uri);
	}
	
	/**
	 * 微信错误警告提示
	 */
	@RequestMapping("warn")
	public String warn() {
		return "wxapi/error";
	}
	
	/**
	 * 微信网页授权网关
	 * @param code
	 * @param state
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("tojs")
	public void tojs(
			HttpServletResponse response,
			String url) throws Exception {
		String appid = Constants.get("wxapi.appid");
		String appsecret = Constants.get("wxapi.appsecret");
		TokenForWxapis token = WxapiUtil.
				getWxapisToken(appid, appsecret);
		TicketForJsapi jsapi = WxapiUtil.
				getJsapiTicket(token.getAccess_token());
		getQueryResponse(
			WxapiUtil.getJsapiConfig(
					appid, jsapi.getTicket(), url)
		).jsonOut(response);
	}
	
	@RequestMapping(value = "news/{id}")
	public String news(Model model,
			@PathVariable("id") Long id) {
		WxapiReplyNews object = 
				wxapiReplyNewsService.find(id);
		model.addAttribute("object", object);
		return "wxapi/reply/news/html";
	}
	
	private void setOpenidToSession(
			HttpServletRequest request, String openid) {
		HttpSession session = request.getSession(true);
		session.setAttribute("openid", openid);
	}
	
	/**
	 * 将openid设置到cookie中
	 * @param response
	 * @param openid
	 */
	private void setOpenidToCookie(
			String openid, HttpServletResponse response) {
		int C_MAXAGE = 3600;
		Cookie cookie = new Cookie("openid", openid);
		cookie.setPath("/");
		cookie.setMaxAge(C_MAXAGE);
		response.addCookie(cookie);
	}

}
