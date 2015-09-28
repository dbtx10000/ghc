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
<link type="text/css" rel="stylesheet" href="${css}/red.css" />
<title>高和畅 - 发金币</title>
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
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
		<div class="bag bag_open">
			<div class="bag_top open"></div>
			<div class="bag_content">
				<p class="get">恭喜你获得</p>
				<div class="gift">
					<ul>
						<!-- 10金币 start -->
						<!-- <li class="coin coin10">10</li> -->
						
						<!-- 50金币 start -->
						<li class="coin coin50">${integral}</li>
						<!-- 50金币 end -->
						<li class="coin_text">
							<p>畅享周专享</p>
							<p>金币</p>
							<p>48小时有效</p>
						</li>
					</ul>
				</div>
				<!-- 50金币时32.66% 改为 136.49% -->
				<p class="clear tips">可特别抵扣<br />[金钥匙畅享周专享]投资款<br />预期年化收益率可达<br /><span><c:if test="${integral == minIntegral}">32.66%</c:if><c:if test="${integral != minIntegral}">136.49%</c:if></span></p>
			</div>	
			<div class="bag_bottom"></div>
		</div>
		<div class="ercode">
			<div>
				<p>长按二维码关注高和畅 了解更多信息</p>
				<img src="${img}/ercode.png" alt="" />
			</div>
			<div class="fill"></div>
		</div>
		<div class="rules mar">
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