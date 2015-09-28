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
				<p><span>订单编号：</span>${object.id }</p>
			    <p>
			    	<span>订单状态：</span>
			    	<i style="padding-left:0px;">
			    		<c:if test="${object.status == -1 }">等待支付</c:if>
			    		<c:if test="${object.status == 0 }">支付定金</c:if>
			    		<c:if test="${object.status == 1 }">支付成功</c:if>
			    		<c:if test="${object.status == 2 }">已关闭</c:if>
			    	</i>
			    	（
			    	<c:if test="${object.payType == 1 }">支付宝WAP支付</c:if>
			    	<c:if test="${object.payType == 2 }">支付宝快捷支付</c:if>
			    	<c:if test="${object.payType == 3 }">微信支付</c:if>
			    	<c:if test="${object.payType == 4 }">银联支付</c:if>
			    	<c:if test="${object.payType == 5 }">金币支付</c:if>
			    	<c:if test="${object.payType == 6 }">线下支付</c:if>
			    	 交易号${object.serialNo }）
			    </p>
			    <p><span>下单时间：</span><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${object.createTime }"/></p>
			</div>
			<div class="receipt">
				<h3>购买者</h3>
				<p><span>姓名：</span>${object.user.realname }</p>
				<p><span>手机：</span>${object.user.mobile }</p>
				<p>
					<span>银行：</span>
					<c:if test="${object.openBankId == '0308' }">招商银行</c:if>
					<c:if test="${object.openBankId == '0105' }">中国建设银行</c:if>
					<c:if test="${object.openBankId == '0302' }">中信银行</c:if>
					<c:if test="${object.openBankId == '0303' }">中国光大银行</c:if>
					<c:if test="${object.openBankId == '0306' }">广东发展银行</c:if>
					<c:if test="${object.openBankId == '0305' }">中国民生银行</c:if>
					<c:if test="${object.openBankId == '0410' }">中国平安银行</c:if>
					
					<c:if test="${object.openBankId == '0100' }">邮储银行</c:if>
					<c:if test="${object.openBankId == '0102' }">中国工商银行</c:if>
					<c:if test="${object.openBankId == '0103' }">中国农业银行</c:if>
					<c:if test="${object.openBankId == '0104' }">中国银行</c:if>
					<c:if test="${object.openBankId == '0301' }">交通银行</c:if>
					<c:if test="${object.openBankId == '0307' }">深发展银行</c:if>
					<c:if test="${object.openBankId == '0309' }">兴业银行</c:if>
					
					<c:if test="${object.openBankId == '9000' }">浦发银行</c:if>
					<c:if test="${object.openBankId == '9001' }">北京银行</c:if>
					<c:if test="${object.openBankId == '9002' }">杭州银行</c:if>
					<c:if test="${object.openBankId == '9003' }">华夏银行</c:if>
					<c:if test="${object.openBankId == '9004' }">上海银行</c:if>
					<c:if test="${object.openBankId == '9005' }">城市商业银行</c:if>
				</p>
				<p><span>卡号：</span>${object.cardNo }</p>
			</div>
		   <div class="receipt">
			   <h3>产品信息</h3>
	           <p><span>产品名称：</span>${object.product.name }</p>
	           <p><span>产品购买方式：</span>${object.product.buyType == 1 ? '开放购买' : 'F码购买'}</p>
	           <p><span>投资额：</span>${object.investMoney } 元</p>
		   </div>
		</div>
		<!-- 内容区域 结束 -->
	</div>
</div>	
</body>
</html>
