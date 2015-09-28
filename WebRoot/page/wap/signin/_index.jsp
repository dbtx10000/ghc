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
<title>高和畅 - 摇钱树</title>
<link type="text/css" rel="stylesheet" href="${css}/mtree.css" />
<script type="text/javascript" src="${js}/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${js}/mTree.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var status = '${status}';
		if (status == '1') {
			$("#can").show();
			$("#cannot").hide();
		} else {
			$("#can").hide();
			$("#cannot").show();
		}
	});
	function water() {
		$("#ele_animate").addClass('ele_animate');//大象移动
		$("#elephant").removeClass("slideInRight").addClass('fly');//按钮隐藏
		$("#waterImg").addClass('water');//水移动
		setTimeout(function() {
			document.getElementById("water_music").play();
		}, 500);
		var timer;
		setTimeout(function() {
			$("#bring").show();
			document.getElementById("bring_music").play();
			timer = setInterval(function() {
				document.getElementById("bring_music").play();
			}, 1000);
			if ('${userId}' == '') {
				var integral = parseInt(Math.random() * 10);
				$("#integral").html("浇水成功,领取" + integral + "个金币");
				$("#forward").attr('href', '${ctx}/page/wap/signin/gotowx.jsp');
				$("#prise").show().addClass('slideInUp');//奖品显示
			} else {
				$.LD.ajax({
					url : '${ctx}/wap/signin/signin?openid=${openid}&userId=${userId}',
					success : function(response) {
						clearInterval(timer);
						if (response.result == 1) {
							$("#integral").html("浇水成功,领取" + response.data + "个金币");
							$("#prise").show().addClass('slideInUp');//奖品显示
						} else if (response.result == -1) {
							$("#ele_animate").removeClass('ele_animate');
							$("#can").hide();
							$("#cannot").html("您本周已经浇过水了哦！");
							$("#cannot").show();
						} else if (response.result == -2) {
							$("#ele_animate").removeClass('ele_animate');
							$("#can").hide();
							$("#cannot").html("请在每周二20:30-24:00 浇水哦！");
							$("#cannot").show();
						} else if (response.result == 0) {
							$.pop.tips("系统异常，请重试!");
						}
					}
				});
			}
		}, 1500);
	}
</script>
</head>
<body>
	<div class="wrap">
		<section
			style="position:absolute;top:10px;left:10px;width:40%;z-index:28">
			<img style="margin:0 auto;width:76%" src="${img}/logo_tree.png"
				alt="" />
		</section>
		<section class="content">
			<section class="middle">
				<section class="left">
					<img src="${img}/tree.png" alt="" /> <img id="bring"
						class="bring_animated bring infinite" src="${img}/bling.png"
						alt="" />
				</section>
				<section class="right">
					<h4>本周投资箴言</h4>
					<p>${proverb}</p>
				</section>
				<section id="elephant" class="elephant animated slideInRight ">
					<!-- 浇水 start -->
					<a id="can" style="display:none" href="javascript:;"
						onclick="water()"><span>点我<br />浇水</span>
					</a>
					<!-- 浇水 end -->
					<!-- 不浇水 start -->
					<p id="cannot" style="display:none" class="nowater">每周二晚记得准时浇水哦~</p>
					<!-- 不浇水 end -->
					<img id="ele_animate" class="animated_ele" src="${img}/elephant.png" alt="" /> 
					<img id="waterImg" class="animated_ele animate_delay" src="${img}/water.png" alt="" />
				</section>
			</section>
			<section id="rules" class="foot animated">
				<footer class="rules animated slideInUp">
					<span id="icon" class="icon"></span>
					<ol>
						<li>活动时间：每周二20：3 0- 24：00</li>
						<li>活动为高和畅平台客户专享活动，参与用户可抽得金币，金币数目由系统随机分配</li>
						<li>中奖的金币将即时计入用户账户；新用户可通过注册账户激活金币；金币可用于抵扣高和畅投资款或兑换高和畅商城精美礼品，1金币=1元人民币</li>
						<li>本活动由高和畅举办，最终解释权归高和畅所有</li>
					</ol>
				</footer>
			</section>
		</section>
		<section id="prise" class="prise animated ">
			<article>
				<p id=integral></p>
			</article>
			<a id="forward" href="${ctx}/wap/user/center?openid=${openid}">确定</a>
		</section>
	</div>
	<section class="music">
		<audio id="water_music" src="${img}/water.mp3"></audio>
		<audio id="bring_music" src="${img}/bring.mp3"></audio>
	</section>
</body>
<%@ include file="/jsp/shared.jsp"%>
<script type="text/javascript">
	wx.ready(function () {
		wx.onMenuShareAppMessage({
			title	: '高和畅 - 我的本周投资箴言',	// 分享标题
			desc	: '${proverb}',	// 分享描述
			link	: '${lctx}/wap/signin/index',	// 分享链接
			imgUrl	: '${lctx}/images/signin_logo.png',	// 分享图标
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
			title	: '高和畅 - 我的本周投资箴言', // 分享标题
			link	: '${lctx}/wap/signin/index', // 分享链接
			imgUrl	: '${lctx}/images/signin_logo.png', // 分享图标
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