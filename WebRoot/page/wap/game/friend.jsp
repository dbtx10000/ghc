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
	<link rel="stylesheet" href="${css }/gohigh_house.css" />
</head>
<body style="background:#88e2c9">
	<!-- 亲友团 S-->
	<section class="friend" id="friend">
		<h3></h3>
		<c:if test="${object!=null}">
			<ul class="list mine">
				<li>
					<div class="left">
						<div class="num">
							<p>${object.ranking}</p>
						</div>
						<div class="people">
							<p class="head"><c:choose><c:when test="${empty(object.userImage)}"><img src="${img}/game/head.png" alt="" /></c:when><c:otherwise><img src="${object.userImage}" alt="" /></c:otherwise></c:choose></p>
							<p class="name">${object.userName}</p>
						</div>
					</div>
					<div class="right">
						<p><span class='score'>&nbsp;x&nbsp;${object.score}</span><span class="icon"></span></p>
					</div>
				</li>
			</ul>
		</c:if>
		<ul class="list more">
			<c:forEach var="cell" items="${friendRecordList}">
				<li>
					<div class="left">
						<div class="people">
							<p class="head"><c:choose><c:when test="${empty(cell.headImage)}"><img src="${img}/game/head.png" alt="" /></c:when><c:otherwise><img src="${cell.headImage}" alt="" /></c:otherwise></c:choose></p>
							<p class="name">${empty(cell.wxnickname) ? '匿名好友' : cell.wxnickname}</p>
						</div>
					</div>
					<div class="right">
						<p><span class='score'>&nbsp;x&nbsp;<c:if test="${cell.score<10}">&nbsp;&nbsp;</c:if>${cell.score}</span><span class="icon"></span></p>
					</div>
				</li>
			</c:forEach>
		</ul>
		<!-- <section class="footer">
			<a class="btn " href="javascript:friendHide();">返 回</a>
		</section> -->
	</section>
	<!-- 排行榜 E-->
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