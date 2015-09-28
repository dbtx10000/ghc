<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp" %>
</head>

<body>
	<form id="save_form" action="${ctx}/users/user/save" method="post">
		<input type="hidden" id="id" name="id" value="${object.id}" /> 
		<div id="content">
			<div class="flag bt10"> 
				<div class="location">用户详情</div>
				<div class="rightBtn">
					<a href="javascript:history.go(-1);">返回</a>
				</div>
			</div>
			<!-- 开始 -->
			<div class="data">
				<div class="form">
					<div class="item h43">
						<div class="fir">用户类型：</div>
						<div class="fir" style="width: 360px;">
							<c:if test="${object.type == 1}">VIP用户</c:if>
							<c:if test="${object.type == 2}">普通用户</c:if>
							<c:if test="${object.type == 3}">销售员</c:if>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">姓名：</div>
						<div class="fir" style="width: 360px;">
							${object.realname}
						</div>
					</div>
					<div class="item h43">
						<div class="fir">手机号码：</div>
						<div class="fir" style="width: 360px;">
							${object.mobile}
						</div>
					</div>
					<div class="item h43">
						<div class="fir">证件类型：</div>
						<div class="fir" style="width: 360px;">
							<c:if test="${object.credentialsType == 1}">身份证</c:if>
							<c:if test="${object.credentialsType == 2}">军官证</c:if>
							<c:if test="${object.credentialsType == 3}">护照</c:if>
							<c:if test="${object.credentialsType == 4}">户口簿</c:if>
							<c:if test="${object.credentialsType == 5}">回乡证</c:if>
							<c:if test="${object.credentialsType == 6}">其他</c:if>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">证件号码：</div>
						<div class="fir" style="width: 360px;">
							${object.credentialsCode}
						</div>
					</div>
					<div class="item h43">
						<div class="fir">邮箱：</div>
						<div class="fir" style="width: 360px;">
							${object.email}
						</div>
					</div>
					<div class="item h43">
						<div class="fir">地址：</div>
						<div class="fir" style="width: 360px;">
							${object.address}
						</div>
					</div>
					<div class="item h125">
						<div class="fir">简介：</div>
						<div class="fir" style="width: 360px;">
							${object.intro}
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>
