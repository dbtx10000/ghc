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
	<script>
		function invited(){
			document.getElementById("tipPid").style.display="block";
		}
		function invitedHide(){
			document.getElementById("tipPid").style.display="none";
		}

  	</script>
</head>
<body style="background:#88e2c9">
	<!-- 排行榜 S-->
	<section class="charts" id="charts" >
		<h3></h3>
		<c:if test="${object!=null}">
		<ul class="list">
			<li>
				<div class="num">
					<p>${object.ranking}</p>
				</div>
				<div class="user">
					<p class="name">${object.userName }</p>
					<p class="head"><c:choose><c:when test="${empty(object.userImage)}"><img src="${img}/game/head.png" alt="" /></c:when><c:otherwise><img src="${object.userImage}" alt="" /></c:otherwise></c:choose></p>
				</div>
				<div class="user">
					<p class="name">预计年化</p>
					<p class="percent">${object.income}%</p>
				</div>
				<div class="score">
					<p>${object.score+object.friendScore}&nbsp;x&nbsp;<span class="icon house"></span></p>
					<p>${object.friendCount}&nbsp;x&nbsp;<span class="icon people"></span></p>
				</div>	
			</li>
		</ul>
		</c:if>
		<ul class="list more">
			<c:forEach var="cell" items="${gameRecordList}" varStatus="status">
				<li class="ranking${cell.ranking}">
					<div class="num">
						<p>${cell.ranking}</p>
					</div>
					<div class="user">
						<p class="name">${cell.userName}</p>
						<p class="head"><c:choose><c:when test="${empty(cell.userImage)}"><img src="${img}/game/head.png" alt="" /></c:when><c:otherwise><img src="${cell.userImage}" alt="" /></c:otherwise></c:choose></p>
					</div>
					<div class="user">
						<p class="name">预计年化</p>
						<p class="percent">${cell.income}%</p>
					</div>
					<div class="score">
						<p>${cell.score+cell.friendScore}&nbsp;x&nbsp;<span class="icon house"></span></p>
						<p>${cell.friendCount}&nbsp;x&nbsp;<span class="icon people"></span></p>
					</div>
				</li>
			</c:forEach>
		</ul>
		<section class="footer">
			<a class="btn invited" href="javascript:invited();"></a>
			<a class="btn  again" href="${ctx}/wap/game/index?id=${id}${shareSn}"></a>
		</section>
	</section>
	<!-- 排行榜 E-->
	<div id="tipPid" style="display: none" class="tip" onclick="invitedHide()" >
	      <div class="point">
	        <!-- <p><span>1</span>点击右上角图标</p>
	        <p><span>2</span>在弹出菜单中选择分享到朋友圈</p>
	        <p><span>3</span>领取金币</p> -->
	        <p>分享给我的好友！</p>
	      </div>
	</div>
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