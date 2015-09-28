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
<meta name="author" content="zalon" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>${snm}<c:if test="${!need_head}"> - 投资产品</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<style>
section .text { margin:0px; }
#d { text-align: center; margin-top: 100px; }
#d h3 { margin-top: 20px; color: #ccc; font-size: 15px; }
.gameOver { position: absolute; top: 0px; left: 0px; z-index: 999; width: 80px; height: 80px; }
.gameOver img { width: 90%; height: auto; }
</style>
</head>

<body>
<c:if test="${need_head}">
	<header>
		投资产品
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<section class="productList" id="product_list">
	<c:if test="${!empty(list)}">
		<c:forEach var="cell" items="${list}">
			<div class="list" style="position:relative;">
		       	<a href="${ctx}/wap/product/detail?id=${cell.id}&openid=${openid}">
		        	<div class="img">
		        		<c:if test="${cell.logo != null}">
		            		<img src="${cell.logo}" />
		        		</c:if>
		        		<c:if test="${cell.logo == null}">
		            		<img src="${img}/pic_default.png" />
		        		</c:if>
		            	<%-- <p>${cell.productType.name}</p> --%>
		            </div>
		            <div class="introduce">
		            	<h4 style="font-size: 14px;">${cell.name}</h4>
		            	<c:if test="${cell.type ==1 }">
		            		<c:if test="${cell.buyStatus == 4}">
								<div class="progress"><em class="scale">100%</em><span><i style="width:100%;"></i></span></div>
							</c:if>
			           		<c:if test="${cell.buyStatus != 4}">
								<div class="progress"><em class="scale">${cell.progress}</em><span><i style="width:${cell.progress};"></i></span></div>
							</c:if>
						</c:if>
		           		<div class="texts" style="font-size: 12px; min-height: 48px; max-height: 48px; margin-top: -1px;">${cell.intro}</div>
		            </div>
		           	<div class="gameOver">
	           			<c:if test="${cell.buyStatus == 1}">
		            		<img src="${img}/icon_situation_in.png" />
		        		</c:if>
		        		<c:if test="${cell.buyStatus == 2}">
		            		<img src="${img}/icon_situation_wait.png" />
		        		</c:if>
		           		<c:if test="${cell.buyStatus == 3}">
		            		<img src="${img}/icon_situation_unbegin.png" />
		        		</c:if>
		        		<c:if test="${cell.buyStatus == 4}">
		            		<img src="${img}/icon_situation_end.png" />
		        		</c:if>
		          	</div>
				</a>
			</div>
		</c:forEach>
	</c:if>
	<c:if test="${empty(list)}">
		<div id="d" style="margin-top: 100px;"><font size="+1">暂无产品哦</font></div>
	</c:if>
</section>
<%-- <footer class="menu">
	<ul>
    	<li><a class="productSel" href="javascript:;">产品</a></li>
        <li><a class="account" href="${ctx}/wap/user/center?openid=${openid}">账户</a></li>
    </ul>
</footer> --%>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>