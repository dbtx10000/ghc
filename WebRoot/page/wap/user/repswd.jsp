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
<style>
section .text{ margin:0px;}
</style>
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script type="text/javascript">
	// 提交按钮
	function submit() {
		var oldPswd = $("#oldPswd").val();
		if (oldPswd.isEmpty()) {
			$.pop.tips("请填写你的旧密码!");
			return;
		}
		var newPswd = $("#newPswd").val();
		if (newPswd.isEmpty()) {
			$.pop.tips("请填写你的新密码!");
			return;
		}
		if ('${mode}' == '2') {
			if (!newPswd.match(/^\d{6}$/gi)) {
				$.pop.tips("请输入6位纯数字密码!");
				return;
			}
		}
		var conPswd = $("#conPswd").val();
		if (conPswd.isEmpty()) {
			$.pop.tips("请确认您的密码!");
			return;
		}
		if (newPswd != conPswd) {
			$.pop.tips("确认密码不一致!");
			return;
		}
		$.ios.ajax({
			url : '${ctx}/wap/user/repswd?openid=${openid}',
			data : { 'mode' : '${mode}', 'oldPswd' : oldPswd, 'newPswd' : newPswd },
			msg : { 
				text : '正在修改', succ : '修改成功', 
				fail : '修改失败', warn : '系统繁忙' 
			},
			success : function(response) {
				return {
					flag : response.result == 1 ? true : null,
					call : function(flag) {
						if (flag) {
							location.href = '${ctx}/wap/user/center?openid=${openid}';
						} else {
							$.pop.tips(response.message);
						}
					}
				};
			}
		});
	}
</script>
</head>

<body>
<header>
	修改${mode == 2 ? '支付' : '登录'}密码
<c:if test="${need_back}">
	<a href="javascript:history.go(-1);" class="back">返回</a>
</c:if>
</header>
<section>
	<ul class="text">
    	<li><span>旧${mode == 2 ? '支付' : '登录'}密码</span><input id="oldPswd" name="oldPswd" type="password" placeholder="请输入旧${mode == 2 ? '支付' : '登录'}密码"></li>
    	<li><span>新${mode == 2 ? '支付' : '登录'}密码</span><input id="newPswd" name="newPswd" type="password" placeholder="请输入新${mode == 2 ? '支付' : '登录'}密码"></li>
        <li><span>确认密码</span><input id="conPswd" type="password" placeholder="请输入确认密码"></li>
    </ul>
    <a class="login greenBg" href="javascript:submit();">确认修改</a>
</section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
