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
<title>${snm}<c:if test="${!need_head}"> - 礼品详情</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_gift_1.0.css" />
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript">
    $(function(){
        var oPh=$(".info p").height();
        $(".info p").hide().height("40px").show();
        $(".info").click(function(){
            if($(".info span").hasClass("up")){
                $(".info").find("p").css("height","40px");
                $(".down").removeClass("up");
            }else{
                $(".info").find("p").css("height",oPh+"px");
                $(".down").addClass("up");
            }
        });
    });
</script>
</head>

<body>
<c:if test="${need_head}">
	<header> 
		礼品详情 
	</header>
</c:if>
<section class="head">
    <img src="${object.bigImage}" class="banner" />
    <div class="evaluate">
        <div class="clr detail">
        	<h4>${object.name}</h4>
        	<span class="orange">${object.integral}金币</span>
        </div>
        <div class="clr time">
        	<h5>剩余库存：<span class="orange">${object.stocknum}</span></h5>
        	<br>
	       	<span style="color:#666; float: left;">换购开始时间：<span class="orange" style="padding-right:0;"><fmt:formatDate value="${object.startTime}" pattern="yyyy-MM-dd HH:mm:ss" /></span></span>
	       	<br>
	       	<span style="color:#666; float: left;">换购结束时间：<span class="orange" style="padding-right:0;"><fmt:formatDate value="${object.endTime}" pattern="yyyy-MM-dd HH:mm:ss" /></span></span>
        </div>
    </div> 
</section>
<section class="intruce">
    <div class="container">
    	<h4>礼品介绍</h4>
        <div class="info">
            <p class="">${object.intro}</p>
			<span class="down"></span>
        </div>
    </div>
    <div class="container">
    	<h4>使用说明</h4>
        <div class="state">
        	${object.notes}
        </div>
    </div>
</section>
<footer class="changBtn">
	<c:if test="${status == 1}">
		<a class="redBg" href="${ctx}/wap/igift/gthis?id=${object.id}&openid=${openid}&nums=${number}">${button}</a>
	</c:if>
	<c:if test="${status != 1}">
		<a style="background: #ccc;" href="javascript:;">${button}</a>
	</c:if>
</footer>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
