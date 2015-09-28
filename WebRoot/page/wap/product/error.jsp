<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" href="${css }/ghc_beta_1.0.css">
<title>${snm}<c:if test="${!need_head}"> - 认购失败</c:if></title>
<style>
	
body {
	font-family: serif;
	background: #e1e0dd;
}
.suc{width: 100%;padding-top: 110px;background:url(${img}/icon_fail.png) center 40px no-repeat;background-size: 60px;}
.suc h5{padding-bottom:20px;font-size:16px;text-align:center;line-height:30px;font-weight:bold}
.suc h3{line-height:60px;color:#fe4023;}
.suc a{margin:10px auto;width:92%;text-align:center; color:#fff; font-size:17px; line-height:37px; height:37px; display:block;background:#ef4023; border-radius:4px; -moz-border-radius:4px; -ms-border-radius:4px; -o-border-radius:4px; -webkit-border-radius:4px;}

</style>
</head>
<body>
<c:if test="${need_head}">
	<header>
		
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
	<section class="suc">
		<h5>认购失败：${error}</h5>
		<a href="${ctx}/wap/product/detail?id=${productId}&openid=${openid}">返回</a>
	</section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>