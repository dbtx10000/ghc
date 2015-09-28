<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${snm}<c:if test="${!need_head}"> - 投资产品</c:if></title>
<link type="text/css" rel="stylesheet" href="${css }/list.css" />
<style>
section .text { margin:0px; }
#d { text-align: center; margin-top: 100px; }
#d h3 { margin-top: 20px; color: #ccc; font-size: 15px; }
</style>
</head>
<body class="productlist">
	<c:if test="${!empty(list)}">
	<c:forEach var="cell" items="${list}">
	   <div class="list">
	   <a href="${ctx}/wap/product/detail?id=${cell.id}&openid=${openid}">
	      <div class="title">
	      	<h3>${cell.name}</h3>
        	<c:if test="${cell.buyStatus == 1}">
           		<p class="state sale">进行中</p>
       		</c:if>
       		<c:if test="${cell.buyStatus == 2}">
       			<p class="state waiting">等待中</p>
       		</c:if>
          	<c:if test="${cell.buyStatus == 3}">
           		<p class="state waiting">将上线</p>
       		</c:if>
       		<c:if test="${cell.buyStatus == 4}">
           		<p class="state end">已结束</p>
       		</c:if>
	      </div>
	      <ul>         
	         <li class="liyield"><p class="t1">预期年化</p><p class="yield">${cell.income}<span>%</span></p></li>
	         <li class="liprice"><p class="t1">门槛</p><p class="price">
	         	${cell.type==1?cell.flingMoney:cell.subscribeMoney}
	         <span>${cell.smallProduct==1?'元':'万'}</span></p></li>
	         <li class="lidate"><p class="t2">期限</p><p class="date">${cell.endTime}<!-- <span>天</span> --></p> </li>
	      </ul>
	   </a>
	   </div>
	 </c:forEach>
	</c:if>
   <c:if test="${empty(list)}">
		<div id="d" style="margin-top: 100px;"><font size="+1">暂无产品哦</font></div>
	</c:if>
</body>
</html>
