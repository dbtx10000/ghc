<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${snm}</title>
<link type="text/css" rel="stylesheet" href="${css}/login.css" />
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/jquery.form.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#username,#password").keydown(function(e) {
		    if (e.which == 13) {
		    	login();
		    }
		});
	});
	function login() {
		var username = $("#username").val();
		var password = $("#password").val();
		if (username.isEmpty()) {
			$("#tip").html("用户名不能为空，请输入您的用户名!");
			return;
		}
		if (password.isEmpty()) {
			$("#tip").html("密码不能为空，请输入您的密码!");
			return;
		}
		$("#login").ajaxSubmit({
			type : 'post',
			dataType : 'json',
			success : function(response) {
				if (response.result == 1) {
					location.href = "${ctx}/index";
				} else {
					$("#tip").html(response.message);
				}
			}
		});
	}
</script>
</head>
<body>
<div class="main">
    <div class="login">
    	<span class="bg_left"></span>
        <span class="bg_right"></span>
        <div class="loginBg">
        	<div class="circle">
        		<img src="${img}/pic_logo.jpg" />
        	</div>
	    	<h1>${snm}管理系统</h1>
	    	<form id="login" action="${ctx}/manager/login" method="post">
		        <div class="edit">
            
		             <p><span>用户名：</span><input class="w228"  type="text"  id="username" name="username" /></p>
                     <p><span>密&nbsp;码：</span><input class="w228"  type="password"   id="password" name="password" /></p>
                    <a class="loginBtn"  title="立即登录"   href="javascript:login();">立即登录</a>

		        </div>
	        </form>
	        <p id="tip" class="error"></p>
	     </div>
    </div>
    <div class="footer">
        <p><span class="copy">Copyright&nbsp;&copy;&nbsp;2014&nbsp;&nbsp;&nbsp;${snm}&nbsp;&nbsp;&nbsp;版权所有 </span></p>
 	</div>
</div>
</body>
</html>




               
