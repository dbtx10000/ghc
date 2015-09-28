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
    <title>${snm}<c:if test="${!need_head}"> - 我的奖品</c:if></title>
    <link type="text/css" rel="stylesheet" href="${css}/ghc_gift_1.0.css" />
    <script type="text/javascript" src="${js}/jquery.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
    <style type="text/css">
    	#orders {
    		width: 100%; font-size: 14px; margin-bottom: 54px;
    	}
    	#orders li {
    		border: 1px solid #f5f5f5; height: 90px; margin-top: 10px; background: #fff; text-indent: 10px;
    	}
    	#orders li div.body {
    		margin-top: 10px;
    	}
    	#orders li div.body .img {
    		height: 70px; width: 70px; float: left;
    	}
    	#orders li div.body .img img {
    		height: 70px; width: 70px; border: none;
    	}
    	#orders li div.body .txt {
    		height: 70px; color: #666; text-indent: 20px; margin-right: 10px; overflow: hidden;
    	}
    	#orders li div.body .txt p {
    		color: #111; margin-top: 4px;
    	}
    	.giftNull{position:relative;margin-top:100px;width:100%;min-height:150px;background:url(${img}/gift-null.png) top center no-repeat;background-size:100px;text-align:center;}
    	.giftNull p{position:absolute;top:120px;left:0;width:100%;text-align:center;color:#828282}
    	.changBtn{display:block;overflow:hidden;zoom:1;}
    	.changBtn a{float:left;width:45%;margin:4px 2.5%;}
    </style>
    <script type="text/javascript">
    </script>
</head>

<body>
	<c:if test="${need_head}">
	    <header>
	       	我的奖品
	        <a href="javascript:history.go(-1);" class="back"></a>
	    </header>
    </c:if>
    <c:if test="${!empty(list)}">
    	<section>
	        <ul id="orders">
	        	<c:forEach var="cell" items="${list}">
	        		<li id="item_${cell.id}" >
		            	<div class="body">
		            		<div class="img"><img src="${cell.smallImage}" /></div>
			            	<div class="txt">
			            		<p style="font-weight: bold; font-size: 15px;">${cell.relateName} * 1</p>
			            		<p style="font-weight: normal; font-size: 13px;">${cell.awardIntro}</p>
			            		<p style="font-weight: normal; font-size: 13px;"><fmt:formatDate value="${cell.winningTime}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
			            	</div>
		            	</div>
		            </li>
	        	</c:forEach>
	        </ul>
	    </section> 
    </c:if>
    <c:if test="${empty(list)}">
	    <section class="giftNull">
	    	<p>你还没有奖品哦！</p>
	    </section>
	</c:if>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
