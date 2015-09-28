<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<%@ include file="/jsp/script.jsp"%>
</head>
<style>
body{ background:#f0f2f5;}
a{ text-align:center;}
</style>
<body>
<div id="content">
    <div class="flag"> 
	    <div class="location">查看订单</div>
	    <div class="rightBtn">
			<a href="javascript:history.go(-1)">返回</a>
	    </div>		    		
	</div>
	<div class="content">
		<!-- 内容区域 开始 -->
		<div class="editPage">
			<div class="receipt">
				<p><span>订单编号：</span>${object.orderNo}</p>
			    <p>
			    	<span>订单状态：</span>
			    	<i style="padding-left:0px;">
			    		<c:if test="${object.gifttype == 1}">
			    			<c:if test="${object.status == 0}">已关闭</c:if>
				    		<c:if test="${object.status == 1}">未发货</c:if>
				    		<c:if test="${object.status == 2}">已发货</c:if>
				    		<c:if test="${object.status == 3}">已支付</c:if>
			    		</c:if>
			    		<c:if test="${object.gifttype == 2}">
			    			<c:if test="${object.status == 0}">已关闭</c:if>
				    		<c:if test="${object.status == 1}">未使用</c:if>
				    		<c:if test="${object.status == 2}">已使用</c:if>
			    		</c:if>
			    	</i>
			    </p>
			    <p><span>下单时间：</span><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${object.createTime}"/></p>
			</div>
			<div class="receipt">
				<h3>下单用户</h3>
				<p><span>姓名：</span>${object.realname}</p>
				<p><span>手机：</span>${object.username}</p>
				<p><span>地址：</span>${object.address}</p>
				<p><span>备注：</span>${object.note}</p>
			</div>
			<div class="receipt">
				<h3>礼品信息</h3>
				<p><span>礼品名称：</span>${object.giftname}</p>
				<p><span>礼品数量：</span>${object.nums}</p>
				<p><span>兑换金币：</span>${object.integral}</p>
			</div>
		</div>
		<!-- 内容区域 结束 -->
	</div>
</div>	
</body>
</html>
