<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta name="version" content="GoHigh v1.1 20150320" />
<meta name="author" content="zalon" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache" />
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>${snm}<c:if test="${!need_head}"> - 注册成功</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<style>
section .text{ margin:0px;}
</style>
</head>

<body>
<c:if test="${need_head}">
	<header>
		注册成功
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<section class="suc">
	<h3>恭喜注册成功</h3>
    <p>因金融产品需核对用户信息，固我们将对您的信息进行审核，二个工作日内审核完毕。</p>
    <a class="login greenBg" href="${ctx}/wap/index?openid=${openid}">进入首页</a>
</section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>