<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta name="version" content="GoHigh v1.1 20150320" />
<meta name="author" content="zalon" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache" />
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>${snm}</title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script>
	function login() {
		var username = $("#username").val();
		var password = $("#password").val();
		if (username.isNotBlank()) {
			if (password.isNotBlank()) {
				$.ios.ajax({
					url : '${ctx}/wap/user/slogin?openid=${openid}',
					msg : { text : '正在登录', succ : '登录成功' },
					data : { 'username' : username, 'password' : password },
					success : function(response) {
						return {
							flag : response.result == 1 ? true : null,
							call : function(flag) {
								if (flag) {
									var redirect_uri = '${redirect_uri}';
									if (redirect_uri.isEmpty()) {
										redirect_uri = '${ctx}/wap/index?openid=${openid}';
									} else {
										redirect_uri = '${redirect_uri}'.decode();
										if (redirect_uri.indexOf('openid=') == -1) {
											if (redirect_uri.indexOf('?') > -1) {
												redirect_uri += '&openid=${openid}';
											} else {
												redirect_uri += '?openid=${openid}';
											}
										}
									}
									location.href = redirect_uri;
								} else {
									$.pop.tips(response.message);
								}
							}
						};
					}
				});
			} else {
				$.pop.tips("别忘了填写密码哦!");
			}
		} else {
			$.pop.tips("没有手机号可不行哦!");
		}
	}
</script>
</head>

<body>
<header>
	登录注册
<c:if test="${need_back}">
	<a href="javascript:history.go(-1);" class="back">返回</a>
</c:if>
<c:if test="${touchs}">
	<a href="${ctx}/wap/user/touchs?openid=${openid}&redirect_uri=${redirect_uri}" 
		style="width:auto; font-size: 14px; left: auto; right: 10px; color: #d22">手势密码登录</a>
</c:if>
</header>
<section>
	<ul class="text">
    	<li><span>手机号</span><input id="username" name="username" type="text" placeholder="请输入手机号"></li>
        <li><span>密　码</span><input id="password" name="password" type="password" placeholder="请输入密码"></li>
    </ul>
	<a id="login" class="login redBg" href="javascript:login();">登录</a>
    <a class="reg" style="float: left; margin-left: 2%;" href="${ctx}/wap/user/forget?openid=${openid}&redirect_uri=${redirect_uri}">忘记密码?</a>
    <a class="reg" href="${ctx}/wap/user/regist?openid=${openid}&pid=${pid}&redirect_uri=${redirect_uri}">立即注册!</a>
</section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
