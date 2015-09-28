<%@ page language="java" contentType="text/xml; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<xml>
	<ToUserName><![CDATA[${object.toUserName}]]></ToUserName>
	<FromUserName><![CDATA[${object.fromUserName}]]></FromUserName>
	<CreateTime>${object.createTime}</CreateTime>
	<MsgType><![CDATA[news]]></MsgType>
	<ArticleCount><![CDATA[${object.articleCount}]]></ArticleCount>
	<Articles>
		<c:forEach var="cell" items="${object.articles}">
			<item>
				<Title><![CDATA[${cell.title}]]></Title>
				<Description><![CDATA[${cell.description}]]></Description>
				<PicUrl><![CDATA[${cell.picUrl}]]></PicUrl>
				<Url><![CDATA[${cell.url}]]></Url>
			</item>
		</c:forEach></Articles>
	<FuncFlag>1</FuncFlag>
</xml>