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
<title>${snm}<c:if test="${!need_head}"> - 我的助手</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<style>
.telphone{margin:0px auto;padding:10px 10px 0 10px;width:88%;font-size:14px;background:#fff;border:1px solid #d7d7d7;line-height:60px;border-radius:4px;-webkit-border-radius:4px;-moz-border-radius:4px;-o-border-radius:4px;-ms-border-radius:4px;}
.telphone li{margin:0 auto;height:60px;width:95%;border-bottom:1px solid #d7d7d7;}
.telphone li:last-child{border:none;}
.telphone .weixin{padding-bottom:10px;text-indent:60px;background:url(${img}/icon_weixin.png) center left no-repeat;background-size:50px auto;}
.telphone .weixin p{padding:0px;line-height:30px;}
.telphone .phone{background:url(${img}/icon_phone.png) center left no-repeat;background-size:50px auto;text-indent:60px;}
.logo{margin:20px 30%;width:40%;height:auto;text-align:center;border-radius:50% 50%;-webkit-border-radius:50% 50%;-o-border-radius:50% 50%;-ms-border-radius:50% 50%;-moz-border-radius:50% 50%;}
</style>
</head>

<body>
<c:if test="${need_head}">
	<header>
		我的助手
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<section class="about">
	<article>
		<%-- ${object.detail} --%>
		<img class="logo" src="${img}/pic_share.jpg" >
		<ul class="telphone">
			<li class="weixin">
				<p>微信客服：GHCgobaby</p>
				<p>微信客服：GHChibaby</p>
			</li>
			<li class="phone">客服热线：<a href='tel:400-6196-805'>400-6196-805</a></li>
			<!-- <li class="phone">投诉专线：021-61362399 </li> -->
			<li style="font-size:12px;text-align:center;">人工服务时间：9:30-17:30（周一至周五）</li>
			
		</ul>
	</article>
	<!-- <div class="top">
    	<a href="#"></a>
    </div> -->
</section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>