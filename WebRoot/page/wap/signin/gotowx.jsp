<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta name="version" content="GoHigh v1.1 20150320" />
<meta name="author" content="zalon" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache" />
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>${snm}<c:if test="${!need_head}"></c:if>
</title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<style>
section .text {
	margin: 0px;
}
section img {
	margin: 0 auto;
	width: 76%;
	height: auto;
	display: block;
	text-align: center;
	margin-bottom: 28px;
}
</style>
</head>

<body>
	<section class="suc" style="background: none; padding-top: 80px;">
		<h4 style="text-align: center;">提示</h4>
		<p>长按二维码，在弹出框中选择'二维码识别'，快速关注'高和畅'，进入'我的账号'，开启理财体验旅程。</p>
		<img class="erCode" src="${img}/qrcode.jpg">
	</section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>