<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<meta name="format-detection" content="telephone=no" />
	<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
	<title>${snm}<c:if test="${!need_head}"> - 支付</c:if></title>
	<style>
		*{margin:0;padding:0;}
		a{text-decoration:none}
		body{background:#f6f6f6}
		header { margin: 0px; padding: 0px; position:relative;  background:#403b37;  color:#fff; font-size: 17px; height: 49px; line-height: 49px; padding: 0; text-align: center; width: 100%; z-index: 3; }
		header a { display: block; height: 49px; left: 10px; position: absolute; top: 0; width: 49px; color: #fff; }
		header .back { background: url(../images/icon_arrow.png) scroll left center no-repeat; background-size: 12px auto; line-height: 49px; text-indent: 4px; width: 60px; font-size: 15px; }
		.agreem{position: absolute;top: 0;left: 6%;width: 88%;display: block;line-height: 24px;font-size: 13px;text-indent: 20px;}
		.agreem a{color:#ff6147;/* text-decoration: underline; */}
		.regist{position:relative;top:0px;left:0;display:inline-block;text-align:center;width:100%;}
		.flat{position:absolute;top:1px;left:0px;width:20px;height:20px;display:inline-block;background-image: url(${img}/flat@2x.png);-webkit-background-size: 176px 22px;background-size: 176px 22px;}
		.pos{/*position:absolute;top:0px;left:0;*/} 
		.checked{background-position: -22px 0;}
		.nextBtn{width: 96%;color: #fff;margin: 0px auto 10px auto;text-align: center;display: block;height: 44px;line-height: 44px;border-radius: 4px;-moz-border-radius: 4px;-ms-border-radius: 4px;-o-border-radius: 4px;-webkit-border-radius: 4px;background: #ff6147}
		.detail{padding-bottom:30px;width:100%;display:block;}
		.detail h3{line-height:40px;font-size:20px;border-bottom:1px solid #e4e4e4}
		.detail p{padding:0 10px;font-size:18px;height:50px;line-height:50px;}
		.detail p span{float:right;}
		.detail p:last-child{font-size:18px;border-bottom:1px solid #e4e4e4;border-top:1px solid #e4e4e4}
		.suc h3,.suc p{padding-bottom:0;}
		.suc {background:url(${img}/icon_suc.png) center 20px no-repeat;background-size: 50px;width: 100%;padding-top: 80px;}
	</style>
	<script type="text/javascript" src="${js}/jquery.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
	<script>
		$(function(){
			checkBox();
		})
		function checkBox(){
			$(".flat").each(function(){
				$(this).click(function(){
					if($(this).hasClass("checked")){//取消
						$(this).removeClass("checked").parent().parent().find("input[type='checkbox']").removeAttr("checked");
					}else{//选中
						$(this).addClass("checked").parent().parent().find("input[type='checkbox']").attr("checked","checked");
					}
				});
			});
		}
		function next(url) {
			var resgreem = $("#resgreem").attr("checked");
			var resgreemTip = "<p style='line-height:30px;'>请阅读并同意<br/>《债权转让及服务协议》</p>";
			if (resgreem != "checked") {
				$.pop.tips(resgreemTip);
				return;
			}
			location.href = url;
		}
	</script>
</head>
<body>
	<c:if test="${need_head}">
		<header> 
			支付
			<a href="javascript:history.go(-1);" class="back">返回</a>
		</header>
	</c:if>
	<section class="detail suc">
		<h3>继续支付</h3>
		<h3 style="text-align:center;color:#000;font-weight:bold;">${order.product.name}</h3>
		<p>认购金额：<span><fmt:formatNumber pattern="0" value="${order.investMoney * 10000}"/>元</span></p>
		<p>支付金额：<span><fmt:formatNumber pattern="0" value="${order.investMoney * 10000 - order.useIntegral - order.cashMoney}"/>元</span></p>
	</section>
	<div class="boxBtn">
		<c:if test="${ftype == 'online'}">
			<a class="nextBtn" href="javascript:next('${ctx}/wap/cnpay/sgate?openid=${openid}&order_no=${order.id}');">下一步</a>
		</c:if>
		<c:if test="${ftype != 'online'}">
			<a class="nextBtn" href="javascript:next('${ctx}/wap/product/pay?openid=${openid}&productId=${order.productId}&money=${order.investMoney}&orderId=${order.id}');">下一步</a>
		</c:if>
		<p class="regist ">
	    	<input type="checkbox" id="resgreem" checked="checked" style="display:none;">
	    	<span class="agreem pos"><i class="flat checked"></i>我已阅读并同意签署<a style="text-align:left;" href="${ctx}/wap/product/contract?productId=${order.productId}&orderId=${order.id}&from=special">《债权转让及服务协议》</a></span>
	    </p>
	</div>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>