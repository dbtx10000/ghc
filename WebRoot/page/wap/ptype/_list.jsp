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
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<style type="text/css">
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
</style>
</head>
  
<body>
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
