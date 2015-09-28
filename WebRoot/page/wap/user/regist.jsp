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
.agreem{margin:0px auto;width:100%;display:block;line-height:24px;font-size:13px;}
.agreem a{color:#ff6147;/* text-decoration: underline; */}
.regist{position:relative;top:-10px;left:14%;display:inline-block;text-align:center;width:76%;}
.flat{position:absolute;top:1px;left:-20px;width:20px;height:20px;display:inline-block;background-image: url(${img}/flat@2x.png);-webkit-background-size: 176px 22px;background-size: 176px 22px;}
.pos{position:absolute;top:0px;left:0;} 
.checked{background-position: -22px 0;}
.hasLogin{margin:50px auto 10px auto;width:100px;border:1px solid #fe4023;text-align:center;font-size:13px;line-height:36px;display:block;border-radius:4px; -moz-border-radius:4px; -ms-border-radius:4px; -o-border-radius:4px; -webkit-border-radius:4px;}
.hasLogin a{color:#fe4023;}
</style>

<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script type="text/javascript">

	$(function(){
		checkBox();
	});
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
				if (response.result == 1) {
					return {
						call : function() { 
							$.pop.hint({
								'text' : '手机号已被注册',
								'note' : '如果该手机号是您之前注册的账号,您可以先尝试登录或找回密码操作!'
							});
						}
					};
				} else {
					var back = null;
					url = '${ctx}/api/sms/send?mobile=%s&type=%s';
					$.LD.ajax({
						url : url.format(mobile, 1),
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
		
		/* var safe=$("#safe").attr("checked");
		var safeTip="<p style='line-height:30px;'>请阅读并同意<br/>《风险提示承诺函》</p>";
		if(safe!="checked"){
			$.pop.tips(safeTip);
			return;
		} 
		*/
		var resgreem = $("#resgreem").attr("checked");
		var resgreemTip = "<p style='line-height:30px;'>请阅读并同意<br/>《高和畅会员注册协议》</p>";
		if (resgreem != "checked") {
			$.pop.tips(resgreemTip);
			return;
		}
		
	    var url = '${ctx}/api/sms/isok?mobile=%s&type=%s&code=%s';
		$.ios.ajax({
			url : url.format(mobile, 1, code),
			msg : { 
				text : '正在校验', succ : '校验成功', 
				fail : '校验失败', warn : '系统繁忙' 
			},
			success : function(response) {
				return {
					flag : response.result == 1 ? true : null,
					call : function(flag) {
						if (flag) {
							url = '${ctx}/wap/user/makeup?openid=${openid}&pid=%s&salerId=%s&mobile=%s&password=%s&token=%s&redirect_uri=${redirect_uri}';
							location.href = url.format('${parent.id}','${salerId}', mobile, password, response.data);
						} else {
							$.pop.tips("短信验证码没有被认可!"); 
						}
					}
				};
			}
		});
		
	}
	
	function checkBox(){
		$(".flat").each(function(){
			$(this).click(function(){
				if($(this).hasClass("checked")){//取消
					$(this).removeClass("checked").parent().parent().find("input[type='checkbox']").removeAttr("checked");
				}else{//选中
					$(this).addClass("checked").parent().parent().find("input[type='checkbox']").attr("checked","checked");
				}
			});
		});
	}
</script>
</head>

<body>
<header>
	用户注册
<c:if test="${need_back}">
	<a href="javascript:history.go(-1);" class="back">返回</a>
</c:if>
</header>
<section>
    <article>
    	<img width="100%" src="${img}/regist.jpg">
    </article>
	<ul class="text" style="border-top:none;">
		<c:if test="${!empty(parent)}">
	    	<li><span>邀请者</span><span class="con">${parent.realname}（${parent.mobile}）</span></li>
		</c:if>
    	<li><span>手机号码</span><input id="mobile" name="mobile" type="text" placeholder="请输入您的手机号码"></li>
        <li class="code"><a class="send" id="send" href="javascript:sendsm();">发送验证码</a><input id="code" name="code" type="text" placeholder="请输入收到的验证码"></li><!--不可点击时 class="gain"-->
        <li><span>设置密码</span><input id="password" name="password" type="password" placeholder="请输入登录密码"></li>
        <li><span>确认密码</span><input id="repassword" type="password"  placeholder="请输入确认密码"></li>
    </ul>
 
    <!-- <p><a class="agreem" style="font-size:12px" href="javascript:;">《风险提示承诺函》</a></p> -->
    <a class="login greenBg"  href="javascript:submit();">下一步</a>
    
    <p class="regist ">
    	
    	<input type="checkbox" id="resgreem" checked="checked" style="display:none;">
    	<span class="agreem pos"><i class="flat checked"></i>我已阅读并同意<a  style="text-align:left;" href="${ctx}/res/agree.html">《高和畅会员注册协议》</a><br>&<a style="text-align:left;" href="${ctx }/res/commitment.html">《风险提示承诺函》</a></span>
    </p>
    <p class="hasLogin" onclick="location.href='${ctx}/wap/user/slogin?openid=${openid}&pid=${pid}&redirect_uri=${redirect_uri}'"><a href="javascript:;">已有账号</a></p>
</section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
