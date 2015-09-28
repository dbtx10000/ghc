<%@ page language="java" contentType="text/xml; charset=utf-8"%>
<xml>
	<ToUserName><![CDATA[${object.toUserName}]]></ToUserName>
	<FromUserName><![CDATA[${object.fromUserName}]]></FromUserName>
	<CreateTime>${object.createTime}</CreateTime>
	<MsgType><![CDATA[text]]></MsgType>
	<Content><![CDATA[${object.content}]]></Content>
	<FuncFlag>1</FuncFlag>
</xml>
