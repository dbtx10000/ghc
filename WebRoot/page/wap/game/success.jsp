<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<meta name="format-detection" content="telephone=no" />
	<meta http-equiv="Cache-Control" content="must-revalidate">
	<meta http-equiv="x-dns-prefetch-control" content="on" />
	<title>高和畅 - 搭房子</title>
	<link rel="stylesheet" href="${css}/gohigh_house.css" />
</head>
<body style="background:#88e2c9">
	<section id="success">
		<h3 class="title"></h3>
		<p class="history"><span class="text"><i>总 成 绩</i><em>${totalScore}</em></span><span class="icon-small"></span></p>
		<h1 class="score"><span class="icon-big"></span><em class="text" id="result">${score}</em></h1>
		<p class="slogn">在城市播种，让财富成长</p>
		<p class="tips">长按二维码关注高和畅</p>
		<img src="${img}/game/ercode.png" alt="高和畅二维码" />
	</section>
</body>
<%@ include file="/jsp/shared.jsp"%>
<script type="text/javascript">
	wx.ready(function () {
		wx.onMenuShareAppMessage({
			title	: '‘${union.nickname}’邀你参加【畅享杯锦标赛】',	// 分享标题
			desc	: '为城市加油，为好友助力！帮好友赢取最高20%预期年化收益率。',	// 分享描述
			link	: '${lctx}/wap/game/index?id=${id}${shareSn}',	// 分享链接
			imgUrl	: '${lctx}/images/game/house.png',	// 分享图标
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
			title	: '‘${union.nickname}’邀你参加【畅享杯锦标赛】', // 分享标题
			link	: '${lctx}/wap/game/index?id=${id}${shareSn}', // 分享链接
			imgUrl	: '${lctx}/images/game/house.png', // 分享图标
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