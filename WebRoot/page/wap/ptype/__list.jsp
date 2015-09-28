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
<meta name="version" content="GoHigh v1.1 20150320">
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>${snm}<c:if test="${!need_head}"> - 产品分类</c:if></title>
<link rel="stylesheet" href="${js }/slick/slick-theme.css" />
<link rel="stylesheet" href="${js }/slick/slick.css" />
<script type="text/javascript" src="${js }/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${js }/slick/slick.min.js"></script>
<style type="text/css">
ul, li { list-style-type: none; }
footer { position: fixed; bottom: 0px; left: 0px; width: 100%; text-align: center; font-size: 14px;z-index:5555; }
footer.bottom,footer.menu{ background:#fff; height:49px; line-height:49px; border-top:1px #d7d7d7 solid;}
footer.bottom ul li,footer.menu ul li{ width:50%; float:left; }
footer.bottom ul li a,footer.menu ul li a{ font-size:17px; width:99%; border-right:1px #d7d7d7 solid; display:block; height:49px; line-height:49px;}
footer.bottom ul li:last-child a{ border-right:0px;}
footer.bottom ul li a.forward{ background:url(${img}/icon_forward.png) 20% center no-repeat; background-size:24px auto; text-indent:34px;}
footer.bottom ul li a.share{ background:url(${img}/icon_share.png) 13% center no-repeat; background-size:24px auto; text-indent:34px;}
/*产品*/
footer.menu{ background:#f9f9f9;border-top:1px #b2b2b2 solid;}
footer.menu ul li a{ font-size:12px; color:#8e8e8e; line-height:12px; text-decoration: none;padding-top:32px; border-right:0px;}
footer.menu ul li a.product{ background:url(${img}/icon_many.png) center 5px no-repeat; background-size:24px; }
footer.menu ul li a.productSel{ background:url(${img}/icon_manySel.png) center 5px no-repeat; background-size:24px; color:#ef4023; }
footer.menu ul li a.account{ background:url(${img}/icon_user.png) center 5px no-repeat; background-size:24px; }
footer.menu ul li a.accountSel{ background:url(${img}/icon_userSel.png) center 5px no-repeat; background-size:24px; color:#ef4023; }
	body {
		margin: 0;
		padding: 0;	
		background: #f0f0f0;
	}
	#list {
		width: 100%;
		margin: 0;
		padding: 0;
		list-style: none;
		margin-bottom: 55px;
	}
	#list li {
		border: 1px solid #ddd;
		width: 96%;
		height: 105px;
		margin: 0 auto;
		background: #fff;
		margin-top: 5px;
		font-weight: bold;
		color: #333;
		cursor: pointer;
		border-radius: 1px;
	}
	#list div.name {
		width: 100%;
		font-size: 18px;
		height: 32px;
		text-indent: 10px;
		line-height: 32px;
		border-bottom: 1px solid #ddd;
	}
	#list div.name div {
		border-radius: 50%;
		background: #ff6147;
		font-size: 10px;
		color: #fff;
		width: 18px;
		height: 18px;
		line-height: 18px;
		float: right;
		font-weight: normal;
		text-align: center;
		text-indent: 1px;
		margin-top: 7px;
		margin-right: 7px;
	}
	#list div.info {
		width: 100%;
		height: 62px;
		background: #fff url('${img}/icon_more_2.png') no-repeat scroll right 18px / 36px auto;
	}
	#list div.img {
		width: 52px;
		height: 52px;
		margin-top: 10px;
		margin-left: 10px;
		float: left;
	}
	#list div.img img {
		width: 52px;
		height: 52px;
		border: none;
	}
	#list div.txt {
		height: 56px;
		max-height: 56px;
		font-size: 14px;
		color: #666;
		font-weight: normal;
		padding: 8px 25px 0px 9px;
		overflow: hidden;
	}
    .banner{width:100%;height:auto;display:block;}
     *{margin:0;padding:0;font-family: Microsoft YaHei, Helvitica, Verdana, Tohoma, Arial, san-serif;}
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
			 <div><a href="${cell.type==1?cell.url: 'javascript:;;'}"><img style="height:220px;" class="banner" src="${cell.image }" /></a></div>
		</c:forEach>
    </div>
	<ul id="list">
		<c:forEach var="cell" items="${list}">
			<li onclick="location.href='${ctx}/wap/product/list?openid=${openid}&type=${cell.id}'">
				<div class="name">
					<span>${cell.name}</span>
					<c:if test="${cell.productCount > 0}">
						<div>${cell.productCount}</div>
					</c:if>
				</div>
				<div class="info">
					<div class="img">
						<img src="${cell.logo}">
					</div>
					<div class="txt">${cell.note}</div>
				</div>
			</li>
		</c:forEach>
	</ul>
	<footer class="menu">
		<ul>
	    	<li><a class="productSel" href="javascript:;">产品</a></li>
	        <li><a class="account" href="${ctx}/wap/user/center?openid=${openid}">账户</a></li>
	    </ul>
	</footer>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
