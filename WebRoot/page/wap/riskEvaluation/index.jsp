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
	<title>高和资本</title>
	<link type="text/css" rel="stylesheet" href="${css}/evalue.css" />
	<script type="text/javascript" src="${js}/jquery.js"></script>
	<script type="text/javascript" src="${js}/jquery.form.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
</head>
<body>
	<section class="evalue">
		<h3>您的风险承受能力为：</h3>
		<c:choose>
			<c:when test="${map!=null&&map.result!=null}">
				<p class="evalue_type"><span>${map.result}</span></p>
			</c:when>
			<c:otherwise>
				<p class="evalue_type"><span>无</span></p>
			</c:otherwise>
		</c:choose>
		
		<p class="text grey">您的抗风险指数：${map==null?'未评测':map.score==null?'未评测':map.score*2}</p>
		<c:choose>
			<c:when test="${map!=null&&map.date!=null}">
				<p class="time orange">最新测评时间：<fmt:formatDate pattern='yyyy-MM-dd' value="${map.date}"/></p>
			</c:when>
			<c:otherwise>
				<p class="time orange">最新测评时间：无</p>
			</c:otherwise>
		</c:choose>
	</section>
	<c:if test="${map==null}">
		<a class="login redBg"  href="${ctx}/wap/riskEvaluation/part1?openid=${openid}&score=0">开始测评</a>
	</c:if>
	<c:if test="${map!=null}">
		<a class="login redBg"  href="${ctx}/wap/riskEvaluation/part1?openid=${openid}&score=0">重新测评</a>
	</c:if>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>