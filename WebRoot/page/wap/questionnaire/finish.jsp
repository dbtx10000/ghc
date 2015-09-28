<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>问卷调查</title>
<link type="text/css" rel="stylesheet" href="${css}/style.css" />
</head>
<body>
	<div class="bg" style="height: 100%;"></div>
	<div class="contain">
		<c:if test="${integral == null }">
			<p class="finish">您已参与该问卷调查!</p>
		</c:if>
		<c:if test="${integral != null }">
		<p class="finish">谢谢您的参与</p>
		<p class="finish">小畅会送给您${integral}金币的奖励</p>
		</c:if>
		<footer>
			<a class="login redBg"  href="${ctx}/wap/user/center?openid=${openid}">确认返回</a>
		</footer>
	</div>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>