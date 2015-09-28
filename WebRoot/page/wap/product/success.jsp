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
		    link	: '${lctx}/wap/product/detail?id=${product.id}&pid=${pid}',	// 分享链接
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
		    link	: '${lctx}/wap/product/detail?id=${product.id}&pid=${pid}', // 分享链接
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
	function hint() {
		$.pop.hint({
			text : '提示',
			note : '该产品暂不支持线下转账，请选择在线支付完成产品的认购！'
		});
	}
</script>
<style>
body{background:#fff;}
section .text { margin: 0px; }
.suc { background: url(${img}/icon_suc.png) center 20px no-repeat #fff; background-size: 50px; width:100%; padding-top: 80px; margin-bottom: 60px; }
.suc h3 span{ color: #ef4023; }
.successBtn {padding-bottom:20px;margin:20px auto 0 auto;width:90%;display:block;overflow:hidden;zoom:1;}
.successBtn li{float:left;width:47%;margin-right:6%;height:40px;line-height:40px;}
.successBtn .btn{margin-right:20px;width:100%;display:block;text-align:center;color:#fff;}
.successBtn li:last-child{margin-right:0px;}
.list .name { padding: 10px; border-top: 1px #d7d7d7 solid; }
.list .name .btn{text-align:center;}
.list .name h4 { font-size: 18px; line-height: 24px; padding-bottom: 10px; }
.list .name  p { font-size:16px;color: #000;padding:0;line-height: 22px;text-align:center; }
.list .name  p a{color:#ef4023;}
.list .name .btn a{width:100%;line-height:40px;background-size:44px auto;display:block;color:#fff;fone-size:14px;}
.list .name  p em { color: #ef4023; font-style: normal; }
.tColor{color:#19bd9b;}
section .text li .con { }
#guide{position:absolute;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.5) url(${img}/guide.png) center 50px no-repeat;display:none;}
.count-time{text-align:center;font-size:16px;margin:0 auto;width:90%;}
.count-time span{color:#f60;}
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
	<h3>已为您预留<span> ${money} </span><c:if test="${product.smallProduct == 0 }">万元</c:if><c:if test="${product.smallProduct == 1 }">元</c:if>份额</h3>
    <div class="list">
    	<div class="name">
        	<h4 style="text-align:center;">${product.name}</h4>
        	<!-- <p>目前支持招商银行、民生银行、兴业银行、广东发展银行、光大银行、交通银行、华夏银行、浦东发展银行借记卡的在线支付功能；同时也支持已开通无卡支付功能的中信银行和建设银行借记卡。</p> -->
        	<p>目前在线支付支持招商银行、建设银行、光大银行、广发银行、民生银行、平安银行、中信银行的借记卡，点击公众账号菜单“新手指南——支付说明”，了解在线支付详细说明。</p>
        	<!-- 
        	<p style="color:#19bd9b;border-top:1px dashed #e4e4e4;padding-top:6px;">缴款时间</p>
        	<p style="font-size:19px;padding-bottom:4px;text-align:center;color:#ef4023;line-height:36px;">5/29上午9:00 -- 6/1上午11:00</p> 
        	-->
        	<!-- 若用按钮 start -->
        	<!-- <p class="btn orangeBg"><a href="#">《在线支付银行卡说明》</a></p> -->
        	<!-- 若用按钮 end -->
        	<!-- 
        	<p  style="border-top:1px dashed #e4e4e4; padding-top:6px;">备注	<br /><span style="font-size:13px;color:#000;">点击菜单“新手指南-支付说明”，了解在线支付所支持的银行借记卡及支付限额</span></p>
        	-->
        </div>
        <!-- 
        <ul class="text">
        	<li><span>应付金额</span><span class="con">${order.investMoney * 10000 - order.useIntegral - order.cashMoney} 元</span></li>
        	<li><span>开户行</span><span class="con">${product.bankName}</span></li>
        	<li><span>账户名称</span><span class="con">${product.accountName}</span></li>
            <li><span>账号</span><span class="con">${product.account}</span></li>
        </ul>
        -->
    </div>
	<ul class="successBtn">
    	<%-- </c:if> --%>
    	<%--
    	<c:if test="${product.incomeType == 2}">
    		<li><a class="btn orangeBg" href="javascript:hint();">线下转账</a></li>
    	</c:if>
    	--%>
    	<c:if test="${product.type != 2 && product.payType == 0}">
	    	<li><a class="btn redBg" href="${ctx}/wap/cnpay/sgate?openid=${openid}&order_no=${order.id}">在线支付</a></li>
	    	<li><a class="btn orangeBg" href="${ctx}/wap/product/pay?openid=${openid}&productId=${product.id}&money=${money}&orderId=${order.id}">线下转账</a></li>
    	</c:if>
    	<c:if test="${product.type == 2 || product.payType == 1}">
	    	<li style="width:100%"><a class="btn redBg" id="online_pay" href="${ctx}/wap/cnpay/sgate?order_no=${order.id}">在线支付</a></li>
    	</c:if>
    </ul>
    <c:if test="${product.type == 2 || product.payType == 1}">
   		<div id="shower" class="count-time">请在<span id="timer">${min}:${sec}</span>分钟内完成在线支付，<br>否则系统将自动取消您本次认购订单。<br>订单号：${order.id}</div>
   		<script type="text/javascript">
   			var timer = document.getElementById("timer");
   			var min = parseInt(timer.innerHTML.split(':')[0]);
   			var sec = parseInt(timer.innerHTML.split(':')[1]);
   			if (min == 0 && sec == 0) {
   				var online_pay = document.getElementById("online_pay");
   				online_pay.style.backgroundColor = '#ccc';
   				online_pay.setAttribute("href", "javascript:;");
   				var shower = document.getElementById("shower");
   				shower.innerHTML = "支付超时，订单已失效！";
   				shower.style.color = "#f00";
   			} else {
   				setInterval(function() {
   					if (min > 0 || sec > 0) {
   						if (sec > 0) {
   							sec --;
   						} else {
   							min --;
   							sec = 59;
   						}
   						var minstr = new String(min);
   						var secstr = new String(sec);
   						if (minstr.length == 1) {
   							minstr = '0' + minstr;
   						}
   						if (secstr.length == 1) {
   							secstr = '0' + secstr;
   						}
   						timer.innerHTML = minstr + ":" + secstr;
   					} else {
   						var online_pay = document.getElementById("online_pay");
   		   				online_pay.style.backgroundColor = '#ccc';
   		   				online_pay.setAttribute("href", "javascript:;");
	   		   			var shower = document.getElementById("shower");
	   	   				shower.innerHTML = "支付超时，订单已失效！";
	   	   				shower.style.color = "#f00";
   					}
   				}, 1000);
   			}
   		</script>
   	</c:if>
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
