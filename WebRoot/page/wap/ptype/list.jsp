<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection" content="telephone=no" />
    <meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
    <meta http-equiv="x-dns-prefetch-control" content="on" />
    <link rel="stylesheet" href="${js}/slick/slick-theme.css" />
    <link rel="stylesheet" href="${js}/slick/slick.css" />
    <script type="text/javascript" src="${js}/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="${js}/slick/slick.min.js"></script>
    <title>${snm} - 产品分类</title>
    <style>
        *{margin:0;padding:0;font-family:Arial, Helvetica, sans-serif;}
        a{text-decoration:none;}
        li{list-style:none;}
        body{background-color:#f0f0f0;}
        .banner{width:100%;height:auto;display:block;}
        .list{position:relative;margin-top:10px;}
        .list a{display:block;}
        .list:last-child{margin-bottom:10px}
        .card{width:100%;}
        .circle{position:absolute;top:6%;right:10px;text-align:center;color:#fff;font-size:14px;line-height:20px;width:20px;height:20px;border-radius:10px;display:inline-block;}
        .yellow{background:#ff7b10;}
        .red{background:#f85a5a;}
        
        footer { position: fixed; bottom: 0px; left: 0px; width: 100%; text-align: center; font-size: 14px;z-index:5555; }
		footer.bottom,footer.menu{ background:#fff; height:49px; line-height:49px; border-top:1px #d7d7d7 solid;}
		footer.bottom ul li,footer.menu ul li{ width:50%; float:left; }
		footer.bottom ul li a,footer.menu ul li a{ font-size:17px; width:99%; border-right:1px #d7d7d7 solid; display:block; height:49px; line-height:49px;}
		footer.bottom ul li:last-child a{ border-right:0px;}
		footer.bottom ul li a.forward{ background:url(${img}/icon_forward.png) 20% center no-repeat; background-size:24px auto; text-indent:34px;}
		footer.bottom ul li a.share{ background:url(${img}/icon_share.png) 13% center no-repeat; background-size:24px auto; text-indent:34px;}
        
        footer.menu{ background:#f9f9f9;border-top:1px #b2b2b2 solid;}
		footer.menu ul li a{ font-size:12px; color:#8e8e8e; line-height:12px; text-decoration: none;padding-top:32px; border-right:0px;}
		footer.menu ul li a.product{ background:url(${img}/icon_many.png) center 5px no-repeat; background-size:24px; }
		footer.menu ul li a.productSel{ background:url(${img}/icon_manySel.png) center 5px no-repeat; background-size:24px; color:#ef4023; }
		footer.menu ul li a.account{ background:url(${img}/icon_user.png) center 5px no-repeat; background-size:24px; }
		footer.menu ul li a.accountSel{ background:url(${img}/icon_userSel.png) center 5px no-repeat; background-size:24px; color:#ef4023; }
    </style>
    <script>
    $(function(){
        $('#banner').slick({
            lazyLoad: 'ondemand',
            dots: true,
            autoplay:true,
            autoplaySpeed:3000,
            cssEase:"ease",
            arrows:false,
        });

    })
    </script>
</head>

<body>
    <div class="banners" id="banner">
    	<c:forEach var="cell" items="${advertList}">
        	<div><a href="${cell.type == 1 ? cell.url : 'javascript:;'}"><img class="banner" src="${cell.image}" /></a></div>
    	</c:forEach>
    </div>
    <section style="margin-bottom: 60px;">
    	<ul>
    		<c:forEach var="cell" items="${list}">
    			<li class="list">
    				<c:choose>
    					<c:when test="${cell.productCount > 0}">
		            		<a href="${ctx}/wap/product/list?openid=${openid}&type=${cell.id}"><img class="card" src="${cell.logo}" /><p class="circle red">${cell.productCount}</p></a>	
    					</c:when>
    					<c:otherwise>
		            		<a href="${ctx}/wap/product/list?openid=${openid}&type=${cell.id}"><img class="card" src="${cell.note}" /></a>	
    					</c:otherwise>
    				</c:choose>
	            </li>
    		</c:forEach>
        </ul>
    </section>
    <footer class="menu">
		<ul>
	    	<li><a class="productSel" href="javascript:;">产品</a></li>
	        <li><a class="account" href="${ctx}/wap/user/center?openid=${openid}">账户</a></li>
	    </ul>
	</footer>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
