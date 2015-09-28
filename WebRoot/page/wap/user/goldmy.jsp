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
<title>${snm}<c:if test="${!need_head}"> - 我的金币</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<style>
section .text { margin:0px; }
.icon_gold{background:url(${img}/icon_jinbi.png)  center left no-repeat;background-size:22px auto;background-position:15px 9px;}
</style>
</head>

<body>
<c:if test="${need_head}">
	<header>
		我的金币
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<section class="gold">
	<div class="num">
    	<%-- <h3><span>${isum}个</span>金币总数</h3> --%>
    	<h3><span>${vaildIntegral}个</span>可用金币数</h3>
    	<h3><span>${soonOverdueIntegral}个</span>即将过期金币数</h3>
    	<h3><span>${overdueIntegral}个</span>已过期金币数</h3>
        <p>注：1金币 = 1元人民币</p>
    </div>
    <c:forEach var="cell" items="${list}">
    	<div class="desc icon_gold">
	    	<h3><span>
	    	<c:if test="${cell.integral > 0}">+</c:if>
	    	<c:if test="${cell.integral < 0}">-</c:if>
	    	${cell.integral}</span>${cell.note}</h3>
	        <p>获取时间：<fmt:formatDate value="${cell.createTime}" 
	        	pattern="yyyy-MM-dd HH:mm:ss" /></p>
	        <p>有效时间：<fmt:formatDate value="${cell.vaildEndTime}" 
	        	pattern="yyyy-MM-dd HH:mm:ss" /></p>
	    </div>
    </c:forEach>
</section>
<c:if test="${empty(list)}">
	<div style="font-size: 12px; color: #8e8e8e; 
		text-align: center; margin-top: 100px;">
		/(ㄒoㄒ)/~~还没有获取到金币呢~~</div>
</c:if>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>