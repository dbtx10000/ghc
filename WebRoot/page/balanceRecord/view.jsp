<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<script type="text/javascript">

</script>
</head>

<body>
    	<div class="content">
		<!-- 内容区域 开始 -->
		<div class="editPage">
			<div class="receipt">
				<p>
				<span>类型：</span>
				<c:choose>
					<c:when test="${object.type==1}">充值</c:when>
					<c:when test="${object.type==2}">提现</c:when>
					<c:when test="${object.type==3}">收益回款</c:when>
					<c:when test="${object.type==4}">本金回款</c:when>
					<c:when test="${object.type==5}">购买产品</c:when>
				</c:choose>
				</p>
				<p><span>备注：</span>${object.note }</p>
				<p><span>状态：</span><c:choose>
					<c:when test="${object.status==1}">提交申请</c:when>
					<c:when test="${object.status==2}">处理中</c:when>
					<c:when test="${object.status==3}">处理成功</c:when>
					<c:when test="${object.status==4}">处理失败</c:when>
				</c:choose></p>
				<p><span>交易金额：</span>${object.money }</p>
			    <p><span>交易时间：</span><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${object.createTime }"/></p>
			</div>
		</div>
		<!-- 内容区域 结束 -->
	</div>
</body>
</html>
