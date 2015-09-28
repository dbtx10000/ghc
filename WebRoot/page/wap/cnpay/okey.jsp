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
<title>${snm}<c:if test="${!need_head}"> - 绑定成功</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<style>
section .text{ margin:0px;}
section img{margin:0 auto;width:76%;height:auto;display:block;text-align:center;margin-bottom:28px;}
</style>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript">
	function setpay() {
		var url = '${ctx}/wap/user/payset/1?openid=${openid}&redirect_uri=%s';
		url = url.format('${ctx}/wap/user/gotowx?openid=${openid}&from=bindcard'.encode().encode());
		location.href = url;
	}
</script>
</head>

<body>
<c:if test="${need_head}">
	<header>
		绑定成功
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<section class="suc">
	<h3>恭喜绑定银行卡成功</h3>
	<c:if test="${!hasPayPassword}">
		<a class="login greenBg" href="javascript:setpay();">设置支付密码</a>
	</c:if>
    <a class="login greenBg" href="${ctx}/wap/user/gotowx?openid=${openid}&from=bindcard">进入我的账号</a>
</section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>