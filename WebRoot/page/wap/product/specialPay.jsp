<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta name="version" content="GoHigh v1.1 20150320">
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>${snm}<c:if test="${!need_head}"> - 确认订单</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<link type="text/css" rel="stylesheet" href="${css}/animate.min.css" />
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/jquery.form.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<style>
section .text{ margin:0px;}
.suc { background:url(${img}/icon_suc.png) center 20px no-repeat #fff; background-size:50px; width:100%; padding-top:80px; margin-bottom:0px;}
.suc h3 span,.redText{ color:#ef4023;}
.gold{padding:0px 0 4px 0;width:100%;border-bottom:1px solid #d7d7d7}
.gold p{line-height:34px;font-size:16px;color:#000;font-style:normal;}
.gold p i{font-style:normal;font-weight:normal;font-size:14px}
.gold .money{margin-top:20px;border-top:1px solid #e4e4e4;/*border-bottom:1px solid #e4e4e4;*/text-indent:12px;line-height:40px}
.gold .money span{float:right;margin-right:10px;font-size:20px;}
.gold input{width:120px;margin:6px 0 10px 0;font-size:15px; text-indent:6px; height:30px;line-height:30px;border:none;border:2px solid #e4e4e4;border-radius:3px 3px;-webkit-border-radius:3px 3px;-moz-border-radius:3px 3px;-o-border-radius:3px 3px;-ms-border-radius:3px 3px;}
.btn{width:100%}
.btn a{margin:10px auto;width:92%;height:40px;line-height:40px;display:block;text-align:center;background:#ef4023;color:#fff;border-radius:5px 5px;-webkit-border-radius:5px 5px;-ms-border-radius:5px 5px;-o-border-radius:5px 5px;-ms-border-radius:5px 5px;-moz-border-radius:5px 5px;}
.payFun{margin:0 auto;width:92%;padding-bottom:20px;}
.payFun p{position:relative;line-height:50px;}
.checked{background-position: -22px 0;}
.flat{position:absolute;top:14px;left:0;width:20px;height:20px;display:inline-block;background-image: url(${img}/flat@2x.png);-webkit-background-size: 176px 22px;background-size: 176px 22px;}
.gold .head{padding:5px 0;width:100%;background: rgba(24,24,29,0.9);text-align:center;}
.gold .head p{color:#fff;font-weight:bold;line-height:30px;}
#use_coupon {
	display: none;
}
.payFun ul{width:100%;}
.payFun ul li{position:relative;display:inline-block;width:44%;margin:0 2%;text-align:center;-webkit-border-radius:5px 5px;font-size:14px}
.payFun ul li p{width:100%;height:100%;border:1px solid #d7d7d7;border-radius:5px 5px;line-height:40px}
.payFun ul li input[type="radio"]{position:absolute;left:0;margin:0;padding:0;opacity:0;text-align:center;z-index:1000;display:block;-webkit-tap-highlight-color:rgba(0,0,0,0);.outline:none;-webkit-appearance: none;width:100%;height:100%;}
.payFun ul li input[type="radio"]:checked+p{background:#ef4023;color:#fff;border-color:#ef4023;}
</style>
<script>
	$(document).ready(function() {
	});
	
	
	function success() {
		var money = parseInt('${money}');
		var integral = parseInt('${integral}');
		if ($("#integralPay").attr("checked") == "checked") {
			//两个都选中
			if (integral <10) {
				$.pop.hint({
					text : '提示',
					note : '您没有那么多金币哦',
					call : function() {
					}
				});
			}else {
				$.pop.chio({
					text : '提示',
					note : '是否确认使用${(product.actualPayMoney)*10}金币认购？',
					left : {
						text : '取消',
						call : function() {
							// operate
						}
					},
					rite : { 
						text : '确认',
						call : function() {
							var url = '${ctx}/wap/product/specialSuccess?openid=%s&productId=%s&money=%s&orderId=%s&useIntegral=%s&type=1';
							location.href = url.format('${openid}', '${productId}', '0', '${orderId}','${(product.actualPayMoney)*10}');
						}
					}
				});
			}
		} else if ($("#moneyPay").attr("checked") == "checked") {
			$.pop.chio({
						text : '提示',
						note : '是否确认使用${product.actualPayMoney}元认购?',
						left : {
							text : '取消',
							call : function() {
								// operate
							}
						},
						rite : { 
							text : '确认',
							call : function() {
								var url = '${ctx}/wap/product/specialSuccess?openid=%s&productId=%s&money=%s&orderId=%s&useIntegral=%s&type=0';
								location.href = url.format('${openid}','${productId}', '${product.subscribeMoney}', '${orderId}', 0);
							}
						}
					});
		} 
	}
</script>
</head>

<body>
<c:if test="${need_head}">
	<header>
		确认订单
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<!--  <section class="suc">
	<h3>认购总金额：<span> ${money * 10000}</span> 元</h3>
</section>  -->
<section class="gold" id="gold">
    <article class="head">
    	<p>产品名称：<span>${product.name}</span></p>
    	<p>认购金额：<span class="redText">${product.subscribeMoney}</span> 元</p>
    </article>
    <article class="payFun" id="pay">
    	<p>选择支付方式：</p>
		<ul>
			<li><label for=""><input id="moneyPay" type="radio" checked="checked" value="1" name="pay-fun"><p>${product.actualPayMoney}元现金支付</p></label></li>
			<li><label for=""><input id="integralPay" type="radio" value="2" name="pay-fun"><p>${(product.actualPayMoney)*10}金币支付</p></label></li>
		</ul>
    </article>
   <!--  <p class="money">待付金额： <span class="redText"><em id="em" style="font-style: normal;">1</em> 元</span> </p> -->
</section>
<section class="btn" id="nextBtn">
    <a href="javascript:success()">下一步</a>
</section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>

