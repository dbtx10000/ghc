<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection" content="telephone=no" />
    <meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
    <meta http-equiv="x-dns-prefetch-control" content="on" />
    <title>${snm}<c:if test="${!need_head}"> - 礼品列表</c:if></title>
    <link type="text/css" rel="stylesheet" href="${css}/ghc_gift_1.0.css" />
    <style>
		.giftNull{position:relative;margin-top:100px;width:100%;min-height:150px;background:url(${img}/gift-null.png) top center no-repeat;background-size:100px;text-align:center;}
    	.giftNull p{position:absolute;top:120px;left:0;width:100%;text-align:center;color:#828282}
    </style>
</head>

<body>
	<c:if test="${need_head}">
	    <header>
	       	礼品列表
	        <a href="javascript:history.go(-1);" class="back"></a>
	    </header>
    </c:if>
    <c:if test="${!empty(list)}">
    	<section class="lists">
	        <ul>
	        	<c:forEach var="cell" items="${list}">
	        		<li>
		            	<a href="${ctx}/wap/igift/cell?id=${cell.id}&openid=${openid}">
		            		<div class="img"><img src="${cell.smallImage}" alt=""></div>
		                    <div class="text">
		                        <p class="title overTxt">${cell.name}</p>
		                        <p class="detail overTxt">${cell.intro}</p>
		                        <p class="cont"><span class="fen">${cell.integral}金币</span><span class="sum">剩余${cell.stocknum}</span></p>
		                    </div>
		            	</a>
		            </li>
	        	</c:forEach>
	        </ul>
	     </section> 
    </c:if>
    <c:if test="${empty(list)}">
    	<!-- 没有礼品 -->
	    <section class="giftNull">
	    	<p>礼品还没有上架</p>
	    </section>
	    <!-- 没有礼品 -->
    </c:if>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
