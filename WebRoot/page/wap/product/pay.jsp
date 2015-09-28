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
<meta name="version" content="GoHigh v1.1 20150320">
<meta name="author" content="zalon" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>${snm}<c:if test="${!need_head}"> - 订购成功</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$.LD.ajax({
			url : '${ctx}/wxapi/tojs',
			data : { 'url' : location.href },
			success : function(response) {
				if (response.result == 1) {
					wx.config({
					    appId		: response.data.appid,	// 必填，公众号的唯一标识
					    timestamp	: response.data.timestamp,	// 必填，生成签名的时间戳
					    nonceStr	: response.data.nonce,	// 必填，生成签名的随机串
					    signature	: response.data.signature,	// 必填，签名，见附录1
					    jsApiList	: ['onMenuShareTimeline', 'onMenuShareAppMessage'],	// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
					    debug		: false	// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
					});
				} else {
					$.pop.tips("js-fail!");
				}
			}
		});
	});
	wx.ready(function () {
		wx.onMenuShareAppMessage({
		    title	: '${product.name}',	// 分享标题
		    desc	: '高和畅投资产品',	// 分享描述
		    link	: '${lctx}/wap/product/detail?id=${product.id}&pid=${user.id}',	// 分享链接
		    imgUrl	: '${lctx}/images/pic_share.jpg',	// 分享图标
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
		    title	: '${product.name}', // 分享标题
		    link	: '${lctx}/wap/product/detail?id=${product.id}&pid=${user.id}', // 分享链接
		    imgUrl	: '${lctx}/images/pic_share.jpg', // 分享图标
		    success	: function () { 
		        // 用户确认分享后执行的回调函数
		    },
		    cancel	: function () { 
		        // 用户取消分享后执行的回调函数
		    }
		});
	});
	function guide(){
		$("#guide").show();
	}
	
</script>
<style>
section .text { margin: 0px; }
.suc { background: url(${img}/icon_suc.png) center 20px no-repeat #fff; background-size: 50px; width:100%; padding-top: 80px; margin-bottom: 60px; }
.suc h3 span{ color: #ef4023; }
.list .name { padding: 10px 15px; border-top: 1px #d7d7d7 solid; }
.list .name h4 { font-size: 17px; line-height: 24px; font-weight: normal; padding-bottom: 10px; }
.list .name  p { font-size: 12px; color: #8e8e8e; padding: 0px; line-height: 22px; }
.list .name  p em { color: #ef4023; font-style: normal; }
#textLi{padding:0 10px;font-size:15px;display:block;}
#guide{position:absolute;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.5) url(${img}/guide.png) center 50px no-repeat;display:none;}
</style>
</head>

<body>
<c:if test="${need_head}">
	<header>
		订购成功
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<section class="suc">
	<h3>已为您预留<span> ${order.investMoney} </span>元份额</h3>
    <div class="list">
    	<div class="name">
        	<h4>${product.name}</h4>
        	<p>高和畅将为您保留订单至<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd" /> 15:00，请您在此之前完成支付。<br/>收到您的缴款后，系统将更新您的订单状态。</p>
        </div>
        <ul class="text">
        	<li><span>应付金额</span><span class="con">${order.investMoney - order.useIntegral - order.cashMoney} 元</span></li>
        	<li><span>开户行</span><span class="con">${product.bankName}</span></li>
        	<li><span>账户名称</span><span class="con">${product.accountName}</span></li>
            <li><span>账号</span><span class="con">${product.account}</span></li>
        </ul>
        <p id="textLi">备注：缴款时请注明'${user.realname}'认购'${product.name}'产品</p>
    </div>
    <a class="login redBg" href="${ctx}/wap/user/center?openid=${openid}">完&nbsp;成</a>
</section>
<footer class="bottom">
	<ul>
    	<li><a class="forward" style="color: black;" href="javascript:guide();">分享给好友</a></li>
        <li><a class="share" style="color: black;" href="javascript:guide();">分享到朋友圈</a></li>
    </ul>
</footer>
<section id="guide" onclick="$('#guide').hide();"></section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
