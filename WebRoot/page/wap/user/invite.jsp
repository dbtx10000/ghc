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
<title>${snm}<c:if test="${!need_head}"> - 我的邀请</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<style>
.gold{ background: none; }
.list01{ padding: 0px; margin-bottom: 10px; border-top: 1px #d7d7d7 solid; }
.list01 .left{ background:url(${img}/bg_line.png) right repeat-y; background-size: 1px auto; }
.list01 .price,.list01 .date{  padding: 0px 15px; display: block; overflow: hidden; }
.list01 .left,.list01 .right{ padding: 10px 0px; }
.list01 .right span,.list01 .right h4{ padding-left: 10px; }
.list01 .left h4,.list01 .right h4 { font-size: 18px; }
.gold .desc{ background: #fff;}
.gold .desc h3 { height: 44px; line-height: 44px;text-indent:25px; padding: 0px;background:url(${img}/user_red.png) center left no-repeat;background-size:18px auto; }
.desc h3 span{ font-size: 12px; color: #8e8e8e;}
footer a{ height: 49px; line-height: 49px; width: 100%; display: block; overflow: hidden; background: #ef4023; color: #fff; font-size: 17px; }
#guide{position:absolute;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.5) url(${img}/guide.png) center 50px  no-repeat;display:none;}
.gold article{padding:0px 0 5px 0;width:100%;background:#fff;display:block;overflow:hidden;}
.gold article img{max-width:100%;}
</style>
<script type="text/javascript">
	function guide(){
		$("#guide").show();
	}
</script>
</head>

<body>
<c:if test="${need_head}">
	<header> 
		我的邀请
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<section class="gold" style="margin-bottom:70px">
	<article>
		${text.invite}
	</article>
	<div class="list01">
		<div class="price">
			<div class="left" style="border-bottom:none;">
				<span>邀请人数</span>
				<h4 class="colorRed">${nums}</h4>
			</div>
			<div class="right">
				<span>获得金币</span>
				<h4 class="colorRed">${isum}</h4>
			</div>
		</div>
    </div>
    <c:forEach var="cell" items="${list}" varStatus="p">
    	<c:if test="${p.index == 0}">
    		<div class="desc" style="border-top:1px #d7d7d7 solid;">
		    	<h3><span><fmt:formatDate value="${cell.createTime}" 
		    		pattern="yyyy-MM-dd HH:mm:ss" /></span>${cell.realname}</h3>
		    </div>
    	</c:if>
    	<c:if test="${p.index != 0}">
    		<div class="desc">
		    	<h3><span><fmt:formatDate value="${cell.createTime}" 
		    		pattern="yyyy-MM-dd HH:mm:ss" /></span>${cell.realname}</h3>
		    </div>
    	</c:if>
    </c:forEach>
    <c:if test="${empty(list)}">
    	<div style="margin-top:100px;font-size: 12px; color: #8e8e8e; 
    		text-align: center;">/(ㄒoㄒ)/~~还没有邀请到朋友呢~~</div>
    </c:if>
</section>
<footer class="bottom">
	<ul>
    	<li><a class="forward" style="color: black;" href="javascript:guide();" >我要邀请</a></li>
        <li><a class="share" style="color: black;" href="javascript:guide();">朋友圈邀请</a></li>
    </ul>
</footer>
<section id="guide" onclick="$('#guide').hide()"></section>
</body>
<%@ include file="/jsp/shared.jsp"%>
<script type="text/javascript">
	wx.ready(function () {
		wx.onMenuShareAppMessage({
			title	: '\'${realname}\'邀你加入高和畅!',	// 分享标题
			desc	: '在城市播种，让财富成长。',	// 分享描述
			link	: '${lctx}/wap/user/regist?pid=${uid}',	// 分享链接
			imgUrl	: '${lctx}/images/invite_share.jpg',	// 分享图标
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
			title	: '\'${realname}\'邀你加入高和畅!', // 分享标题
			link	: '${lctx}/wap/user/regist?pid=${uid}', // 分享链接
			imgUrl	: '${lctx}/images/invite_share.jpg', // 分享图标
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