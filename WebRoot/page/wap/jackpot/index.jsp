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
<title>抽奖</title>
<link type="text/css" rel="stylesheet" href="${css}/prise.css" />
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script type="text/javascript">
	$(function() {
		$(".box").click(function(){
			$(this).css({
				"background":"url(${img}/chest_open.png) center center no-repeat",
				"backgroundSize":"100% auto"
			});
			
			//弹窗show
			$("#windilog").show().addClass("slideInUp");

			//loading
			$("#windilog").bind("webkitAnimationEnd", function() {
			    $(".load").show().addClass("zoomIn");
			});
			setTimeout(function(){
				$.LD.ajax({
        			url : '${ctx}/wap/jackpot/shake?openid=${openid}&id=${id}',
        			success : function(response) {
        				$(".load").removeClass("zoomIn").addClass("zoomOut");
        				if (response.result == 1) {
        					$("#data").html('获得' + response.data.data);
							$(".prise").show().addClass("slideInDown");
        				} else if (response.result == -1 || response.result == -2) {
        					if (response.result == -1) {
        						$.pop.chio({
	        						text : '没有抽奖机会', 
	        						note : '购买产品可以获得抽奖机会哦，是否前往购买？',
	        						left : {
	        							text : '否',
	        							call : function() {
	        								location.href = '${ctx}/wap/user/center?openid=${openid}';//跳转至个人中心
	        							}
	        						},
	        						rite : {
	        							text : '是',
	        							call : function() {
	        								location.href = '${ctx}/wap/ptype/list?openid=${openid}';//跳转至产品列表页面
	        							}
	        						}
	        					});
        					} else {
        						$.pop.hint({
	        						text : '抱歉哟',
	        						note : '您只有一次抽奖机会!',
        							call : function() {
        								location.href = '${ctx}/wap/user/center?openid=${openid}';//跳转至个人中心
	        						}
	        					});
        					}
        				} else {
       						$.pop.hint({
        						text : response.message,
       							call : function() {
									$("#windilog").hide();//关闭弹窗
									$(".box").attr('background', 'url(${img}/images/chest_close.png) center center no-repeat').removeAttr('style');
        							$(".load").removeClass("zoomOut").addClass("zoomIn");
        						}
        					});
       					}
        			}
        		});
			},3000);
		});
	});
</script>
</head>
<body>
	<div class="boxs">
		<div class="box box1"><span class="animated03 translate10 alternate infinite"></span></div>
		<div class="box box2"><span class="animated03 translate10 alternate infinite"></span></div>
		<div class="box box3"><span class="animated03 translate10 alternate infinite"></span></div>
		<div class="box box4"><span class="animated03 translate10 alternate infinite"></span></div>
	</div>
	<div id="windilog" class="windilog animated">
		<div class="load animated"><p class="animated flash infinite">探索宝箱中。。。</p></div>
		<div class="prise animated">
			<div class="notice">
				<p id="data"></p>
			</div>
			<div class="btn">
				<a href="${ctx}/wap/user/center?openid=${openid}">确定</a>
			</div>
		</div>
	</div>
</body>
<%@ include file="/jsp/shared.jsp"%>
<script type="text/javascript">
	wx.ready(function () {
		wx.onMenuShareAppMessage({
			title	: '【小畅有礼】百分百有礼，大奖是你吗？',	// 分享标题
			desc	: '奖品包括金币、代金券、以及神秘大奖',	// 分享描述
			link	: '${lctx}/wap/jackpot/index?id=${id}',	// 分享链接
			imgUrl	: '${lctx}/images/jackpot.jpg',	// 分享图标
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
			title	: '【小畅有礼】百分百有礼，大奖是你吗？', // 分享标题
			link	: '${lctx}/wap/jackpot/index?id=${id}', // 分享链接
			imgUrl	: '${lctx}/images/jackpot.jpg', // 分享图标
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