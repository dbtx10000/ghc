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
	//发送验证码
	function sendsm() {
		var mobile = $("#mobile").val();
		if (mobile.isEmpty()) {
			$.pop.tips("没有手机号可不行哦!");
			return;
		}
		if (!mobile.isMobile()) {
			$.pop.tips("厄...识别不了该手机号!");
			return;
		}
		var url = '${ctx}/wap/user/exists?openid=${openid}&mobile=%s';
		$.ios.ajax({
			url : url.format(mobile),
			msg : {
				text : '正在发送', succ : '发送成功',
				fail : '发送失败', warn : '系统繁忙'
			},
			success : function(response) {
				if (response.result != 1) {
					return {
						call : function() { 
							$.pop.hint({
								'text' : '手机号还未注册',
								'note' : '请确认该手机号是不是您之前注册的账号!'
							});
						}
					};
				} else {
					var back = null;
					url = '${ctx}/api/sms/send?mobile=%s&type=%s&cost=1000';
					$.LD.ajax({
						url : url.format(mobile, 2),
						async : false, data : {},
						success : function(response) {
							back = { 
								flag : response.result == 1,
								call : function(flag) {
									if (flag) {
										stimer();
									}
								}
							};
						}
					});
					return back;
				}
			}
		});
	}
	// 验证码按钮倒计时
	function stimer() {
		var send = document.getElementById("send");
		var time = 60;
		send.innerHTML = time + "秒后可重新发送";
		send.setAttribute("class", "gain");
		var timer = setInterval(function() {
			if (time > 1) {
				time--;
				send.innerHTML = time + "秒后可重新发送";
				send.setAttribute("href", "javascript:void(0);");
			} else {
				clearInterval(timer);
				send.setAttribute("class", "send");
				send.setAttribute("href", "javascript:sendsm();");
				send.innerHTML = "发送验证码";
			}
		}, 1000);
	}
	// 注册按钮
	function submit() {
		var mobile = $("#mobile").val();
		if (mobile.isEmpty()) {
			$.pop.tips("没有手机号可不行哦!");
			return;
		}
		if (!mobile.isMobile()) {
			$.pop.tips("厄...识别不了该手机号!");
			return;
		}
		var code = $("#code").val();
		if (code.isEmpty()) {
			$.pop.tips("亲,您的短信验证码呢？");
			return;
		}
		var password = $("#password").val();
		if (password.isEmpty()) {
			$.pop.tips("别忘了填写密码哦!");
			return;
		}
		var repassword = $("#repassword").val();
		if (repassword.isEmpty()) {
			$.pop.tips("请确认您的密码!");
			return;
		}
		if (password !=repassword) {
			$.pop.tips("确认密码不一致!");
			return;
		}
		var url = '${ctx}/api/sms/isok?mobile=%s&type=%s&code=%s';
		$.ios.ajax({
			url : url.format(mobile, 2, code),
			msg : { 
				text : '正在重置', succ : '重置成功', 
				fail : '重置失败', warn : '系统繁忙' 
			},
			success : function(response) {
				if (response.result == 1) {
					var token = response.data;
					var back = null;
					$.LD.ajax({
						url : '${ctx}/wap/user/forget?openid=${openid}',
						async : false, data : {
							'mobile' : mobile, 
							'password' : password, 
							'token' : token
						},
						success : function(response) {
							back = {
								flag : response.result == 1,
								call : function(flag) {
									if (flag) {
										forward(response);
									}
								}
							};
						}
					});
					return back;
				} else {
					return {
						call : function() { 
							$.pop.tips("短信验证码没有被认可!"); 
						}
					};
				}
			}
		});
	}
	function forward(response) {
		if (response.data != null) {
			location.href = '${ctx}' + response.data + '?openid=${openid}';
		} else {
			var redirect_uri = '${redirect_uri}';
			if (redirect_uri.isEmpty()) {
				if ('${mode}' == '1') {
					redirect_uri = '${ctx}/wap/index?openid=${openid}';
				} else {
					redirect_uri = '${ctx}/wap/user/center?openid=${openid}';
				}
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
		}
	}
</script>
</head>

<body>
<header>
	找回密码
<c:if test="${need_back}">
	<a href="javascript:history.go(-1);" class="back">返回</a>
</c:if>
</header>
<section>
	<ul class="text">
    	<li><span>手机号码</span><input id="mobile" name="mobile" type="text" placeholder="请输入您的手机号码"></li>
        <li class="code"><a class="send" id="send" href="javascript:sendsm();">发送验证码</a><input id="code" name="code" type="text" placeholder="请输入收到的验证码"></li><!--不可点击时 class="gain"-->
    	<li><span>设置密码</span><input id="password" name="password" type="password" placeholder="请输入登录密码"></li>
        <li><span>确认密码</span><input id="repassword" type="password" placeholder="请输入确认密码"></li>
    </ul>
    <a class="login greenBg" href="javascript:submit();">下一步</a>
</section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
