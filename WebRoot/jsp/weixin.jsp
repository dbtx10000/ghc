<%@ page language="java" import="com.alidao.wxapi.bean.*"%>
<%@ page language="java" import="com.alidao.wxapi.util.*"%>
<%@ page import="org.springframework.web.util.UrlPathHelper" %>
<%
	String serverurl = request.getScheme() + "://" + request.getServerName();
	serverurl = (request.getServerPort() == 80) ? serverurl : (serverurl + ":" + request.getServerPort());
	String qrystring = request.getQueryString(), accessurl = serverurl + new UrlPathHelper().getOriginatingRequestUri(request);
	accessurl = (qrystring == null || qrystring == "") ? accessurl : (accessurl + '?' + qrystring);
	TokenForWxapis tokenforwxapis = WxapiUtil.getWxapisToken(WxapiSets.appid, WxapiSets.appsecret);
	TicketForJsapi ticketforjsapi = WxapiUtil.getJsapiTicket(tokenforwxapis.getAccess_token());
	ConfigForJsapi configforjsapi = WxapiUtil.getJsapiConfig(WxapiSets.appid, ticketforjsapi.getTicket(), accessurl);
	request.setAttribute("configforjsapi", configforjsapi);
%>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
(function() {
	var jsapis = [
		'onMenuShareTimeline', 
		'onMenuShareAppMessage', 
		'onMenuShareQQ', 
		'onMenuShareWeibo',
		'onMenuShareQZone', 
		'startRecord', 
		'stopRecord', 
		'onVoiceRecordEnd', 
		'playVoice', 
		'pauseVoice', 
		'stopVoice', 
		'onVoicePlayEnd', 
		'uploadVoice', 
		'downloadVoice', 
		'chooseImage', 
		'previewImage', 
		'uploadImage', 
		'downloadImage', 
		'translateVoice',
		'getNetworkType', 
		'openLocation', 
		'getLocation', 
		'hideOptionMenu', 
		'showOptionMenu',
		'hideMenuItems', 
		'showMenuItems', 
		'hideAllNonBaseMenuItem', 
		'showAllNonBaseMenuItem',
		'closeWindow', 
		'scanQRCode', 
		'chooseWXPay', 
		'openProductSpecificView', 
		'addCard',
		'chooseCard', 
		'openCard'
	];
	wx.config({
		appId : '${configforjsapi.appid}', 
		timestamp : '${configforjsapi.timestamp}',
	    nonceStr : '${configforjsapi.nonce}', 
	    signature : '${configforjsapi.signature}', 
		jsApiList : jsapis, debug : false
	});
})();
</script>