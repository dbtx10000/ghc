<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${snm}管理系统</title>
<script type="text/javascript">
	function jump() {
		var sec = 10, $em = document.getElementById("sec");
		setInterval(function() {
			if (sec == 1) {
				history.go(-1);
			} else {
				$em.innerHTML = (--sec);
			}
		}, 1000);
	}
</script>
<style>
*{ padding:0px; margin:0px;}
.error{ width:438px; margin:10% auto 0px auto; background:url(${img}/pic_error.png) center bottom no-repeat; padding-bottom:220px; }
.error h1{ font-size:36px; color:#ed2222;  line-height:48px; padding-bottom:10px;}
.error p{ font-size:14px; color:#333; font-family:"黑体"; line-height:26px; padding-bottom:10px;}
.error p em{ color:#0073dd; font-style:normal;}
.error p a{ text-decoration:none; color:#0073dd;}
</style>
</head>
<body style="background-color: #f0f2f5;" onload="jump();">
	<div class="error">
    	<h1>抱歉,出现错误了！</h1>
        <p>抱歉，你点击的页面无法前往，页面将在<em id="sec">10</em>秒后跳转上级页面您也可以尝试前往其他页面：</p>
        <p><a href="javascript:history.go(-1);">&gt;&gt;返回上一级目录</a></p>
        <%-- <p><a href="${ctx}/right">&gt;&gt;返回后台首页</a></p> --%>
    </div>
</body>
</html>