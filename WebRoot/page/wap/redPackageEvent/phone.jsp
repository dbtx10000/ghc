<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width , initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>高和畅 - 发金币</title>
<link type="text/css" rel="stylesheet" href="${css}/red.css" />
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script>
	$(document).ready(function() {
		listensms();
		listenred();
		document.getElementById("mobile").addEventListener('input', function() {
			listensms();
		}, false);
		document.getElementById("code").addEventListener('input', function() {
			listenred();
		}, false);
	});
	function listensms() {
		if ($("#mobile").val().isMobile()) {
			$("#sender").attr('href', 'javascript:sendsms();');
			$("#sender").css({ background : '#ff4f41' });
		} else {
			$("#sender").attr('href', 'javascript:;');
			$("#sender").css({ background : '#cccccc' });
		}
		listenred();
	}
	function listenred() {
		if ($("#mobile").val().isMobile() && $("#code").val().length == 6) {
			$("#getter").attr('href', 'javascript:redpack();');
			$("#getter").css({ background : '#ff4f41' });
		} else {
			$("#getter").attr('href', 'javascript:;');
			$("#getter").css({ background : '#cccccc' });
		}
	}
	function sendsms() {
		var mobile = $("#mobile").val();
		if (mobile.isEmpty()) {
			$.pop.tips("请输入手机号码!");
			return;
		}
		if (!mobile.isMobile()) {
			$.pop.tips("手机号码不正确!");
			return;
		}
		var url = '${ctx}/api/sms/send?mobile=%s&type=%s';
		$.ios.ajax({
			url : url.format(mobile, 6),
			msg : {
				text : '正在发送', succ : '发送成功',
				fail : '发送失败', warn : '系统繁忙'
			},
			success : function(response) {
				return { 
					flag : response.result == 1,
					call : function(flag) {
						if (flag) { stimer(); }
					}
				};
			}
		});
	}
	//验证码按钮倒计时
	function stimer() {
		var send = $("#sender");
		var time = 60;
		send.html(time + "秒");
		send.attr('href', 'javascript:;');
		send.css({ background : '#cccccc' });
		var timer = setInterval(function() {
			if (time > 1) {
				time--;
				send.html(time + "秒");
			} else {
				clearInterval(timer);
				send.css({ background : '#ff4f41'});
				send.attr('href', 'javascript:sendsms();');
				send.html("获取验证码");
			}
		}, 1000);
	}
	function redpack() {
		var mobile = $("#mobile").val();
		var code  = $("#code").val();
		if (mobile.isEmpty()) {
			$.pop.tips("请输入手机号码!");
			return;
		}
		if (!mobile.isMobile()) {
			$.pop.tips("手机号码不正确!");
			return;
		}
		if (code.isEmpty()) {
			$.pop.tips("请输入短信验证码!");
			return;
		}
		if (code.length != 6) {
			$.pop.tips("短信验证码不正确!");
			return;
		}
		var url = '${ctx}/api/sms/isok?mobile=%s&type=%s&code=%s';
		$.ios.ajax({
			url : url.format(mobile, 6, code),
			msg : { 
				text : '正在领取', succ : '领取成功', 
				fail : '领取失败', warn : '系统繁忙' 
			},
			success : function(response) {
				return {
					flag : response.result == 1 ? true : null,
					call : function(flag) {
						if (flag) {
							url = '${ctx}/wap/redPackageEvent/bindAndGet?redPackageEventId=%s&mobile=%s&token=%s&openid=%s';
							location.href = url.format('${redPackageEventId}', mobile, response.data, '${openid}');
						} else {
							$.pop.tips("短信验证码不正确!"); 
						}
					}
				};
			}
		});
	}
</script>
</head>
<body>
	<header class="logo">
		<img src="${img}/logo.png" alt="高和畅" />
	</header>
	<section class="content">
		<div class="elephant">
			<ul>
				<li class="e_left"><img src="${img}/elephant_left.png" alt="左边大象"/></li>
				<li class="e_right"><img src="${img}/elephant_right.png" alt="右边大象"/></li>
			</ul>
		</div>
		<div class="text">
			<h4>输入手机号领红包<br />预计年化收益率最高可达136.49%</h4>
			<input class="borderR5" placeholder="请输入您的手机号码" style="padding: 0px;" type="tel" id="mobile" maxlength="11" />
			<div style="width: 100%; height: 64px;">
				<input class="borderR5" style="width: 40%; float: left; margin-left: 10%; padding: 0px;" type="tel" id="code" maxlength="6" />
				<a class="borderR5" id="sender" href='javascript:;' style="width: 35%; float: right; margin-right: 10%; background: #ff4f41; color: #fff; cursor: pointer;">获取验证码</a>
			</div>
			<a id="getter" class="borderR5" href="javascript:;">马上领取</a>
		</div>
		<div class="rules">
			<div class="content">
				<div class="title">
					<span class="line"></span>
					<h4>活动规则</h4>
					<span class="line"></span>
				</div>
				<div class="rule">
					<ul>
						<li><span>1</span>活动时间：${eventDate}</li>
						<li><span>2</span>活动奖励将于分享朋友圈或分享给朋友后以高和畅金币方式发放到参与活动的客户账户内；</li>
						<li><span>3</span>请确保已注册高和畅平台，否则将导致金币无法发送至个人账户；</li>
						<li><span>4</span>本次活动红包所得金币有效期为48小时，过期自动失效；</li>
						<li><span>5</span>本次活动由高和畅平台举办，最终解释权归高和畅平台所有。</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="his">
			<div class="content">
				<div class="histories">
					<span class="line"></span>
					<h4 class="history borderR25">看看朋友们的手气如何</h4>
					<span class="line"></span>
				</div>
				<div class="history_list">
					<ul>
					<c:forEach items="${recordList}" var="object" varStatus="p">
						<li>
							<div class="pic">
								<c:choose>
									<c:when test="${empty(object.userImage)}">
										<img src="${img}/red_pack.png" alt="" />
									</c:when>
									<c:otherwise>
										<img src="${object.userImage}" alt="" />
									</c:otherwise>
								</c:choose>
							</div>
							<div class="text_content">
								<div class="left">
									<p>${object.userName }<span><fmt:formatDate value="${object.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></span></p>
									<p>${object.remark }</p>
								</div>
								<div class="right">
									<p>${object.integral }金币</p>
								</div>
							</div>
						</li>
					</c:forEach>
						<li>
							<a class="more" href="javascript:;">已经有999+人领取红包</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</section>
</body>
<%@ include file="/jsp/shared.jsp"%>
<script type="text/javascript">
	wx.ready(function () {
		wx.onMenuShareAppMessage({
			title	: '领取畅享季金币，预期年化收益率最高可达136.49%！',	// 分享标题
			desc	: '${shareEventDate}高和畅金币大放送！',	// 分享描述
			link	: '${lctx}/wap/redPackageEvent/index?id=${redPackageEventId}',	// 分享链接
			imgUrl	: '${lctx}/images/red_pack.png',	// 分享图标
			type	: 'link',	// 分享类型,music、video或link，不填默认为link
			dataUrl	: '',	// 如果type是music或video，则要提供数据链接，默认为空
			success	: function () { 
				// 用户确认分享后执行的回调函数
			},
			cancel	: function () { 
				// 用户取消分享后执行的回调函数
			}
		});
		wx.onMenuShareTimeline({
			title	: '领取畅享季金币，预期年化收益率最高可达136.49%！',	// 分享标题
			link	: '${lctx}/wap/redPackageEvent/index?id=${redPackageEventId}',	// 分享链接
			imgUrl	: '${lctx}/images/red_pack.png', // 分享图标
			success	: function () { 
				// 用户确认分享后执行的回调函数
	
			},
			cancel	: function () { 
				// 用户取消分享后执行的回调函数
			}
		});
	});
</script>
</html>