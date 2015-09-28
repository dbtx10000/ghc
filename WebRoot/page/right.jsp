<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link type="text/css" rel="stylesheet" href="${css}/index.css" />
<style>
a {
	text-align: center;
}

h2 {
	font-family: "微软雅黑";
	line-height: 351px;
	color: #a9cd03;
	margin-top: 12%;
	margin-left: 9% \9;
	letter-spacing: 1px;
	/*background: url(${ctx}/images/bg_main.png) center center no-repeat;*/
	width: 760px;
	height: 351px;
}

.content {
	text-align: center;
}

@media screen and (max-width: 1024px) {
	h2 {
		margin-left: 9%;
		_margin-left: 4%;
		+margin-left: 4%;
		font-size: 26px;
	}
}

@media screen and (min-width: 1025px) {
	h2 {
		margin-left: 18%;
		_margin-left: 6%;
		+margin-left: 6%;
		font-size: 38px;
	}
}
</style>
</head>
<body style="background:#f0f2f5;">
	<div class="container">
		<div style=" z-index:-99; position:absolute; top:20%; left:20%"></div>
		<div class="content">
			<h2>欢迎您，使用${snm}管理系统</h2>
		</div>
	</div>
</body>
</html>
