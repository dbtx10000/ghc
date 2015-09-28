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
<title>${snm}<c:if test="${!need_head}"> - 我的投资</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<style>
.list01{margin:10px 0; padding:0px;border:none;box-shadow:5px 5px 10px rgba(0,0,0,0.3);/* border-right:1px solid #d7d7d7;border-left:1px solid #d7d7d7; */}
.list01 p{ font-size:16px;line-height:22px; border-bottom:1px #d7d7d7 solid;font-weight:600; padding:10px 12px;border-top:6px solid #ff6633;}
.list01 ul{  padding:6px 12px; display:block; overflow:hidden;line-height:24px;color:#;}
.list01 .priceNum{position:relative;font-size:15px;border-bottom:1px solid #d7d7d7;display:block;overflow:hidden;zoom:1}
.list01 .priceNum em{font-style:normal;}
.list01 .priceNum i{font-style:normal;font-size:14px;}
.list01 .priceNum h4,.list01 .priceSum h4{color:#ed4023;}
.list01 .priceNum h4 span,.list01 .priceSum h4 span{color:#333;}
.list01 .priceNum .status{text-align:center;color:#ff4400;}
.list01 .priceNum .btn{float:left;width:50%;text-align:center;}
.list01 .priceNum .btn a{width:100%;color:#fff;line-height:2.5rem;font-size:15px;display:block;}
.f40Bg{background:#ff4400;}
.grayBg{background:#333333;}
.list01 .priceDate{font-size:14px;}
.list01 .priceDate{}
.list01 .priceSum{border-top:1px solid #d7d7d7;}
.list01 .price{ border-bottom:1px #d7d7d7 solid;}
.list01 .left,.list01 .right{ padding:10px 0px 6px 0px;}
.list01 .right h4 i{ font-size:12px; color:#ef4023; padding-left:10px; font-style:normal;}
#d{text-align:center;margin-top:100px;}
#d h3{background:none;color:#ccc;font-size:15px;}
#telphone{position:absolute;top:0;left:0;width:100%;height:100%;overflow:hidden;display:none;background:rgba(0,0,0,.5);z-index:999;}	 
#telphone ul{position:fixed;bottom:0;left:0;width:100%;display:block;text-align:center;z-index:9999;}
#telphone li{width:100%;line-height:50px;background:#fff;border-top:1px solid #999;}
#telphone li a{width:100%;display:block;color:#007aff;font-weight:bold;}
#telphone .work{border-bottom:1px solid #000;}


.minLine{position:absolute;top:0;left:50%;width:1px;height:2.5rem;border-right:1px solid #d7d7d7;}
</style>
<link rel="stylesheet" href="${css}/animate.min.css" />
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script>
	//点击客服电话
	/* function payShow(orderId, money, productId) {
	   	var oPhone = document.getElementById("telphone");
	   	var html = oPhone.innerHTML.replace(/#orderId#/gi, orderId);
	   	html = html.replace("#money#", money).replace("#productId#", productId);
	   	oPhone.innerHTML = html;
	   	oPhone.style.display = "block";
		oPhone.setAttribute("class", "telphone animated fadeInUp");
	}
	   //点击取消
	function payHide() {
		var oPhone = document.getElementById("telphone");
		oPhone.setAttribute("class", "telphone animated fadeOutDown");
	} */
	function payShow(orderId, money, productId, from, incomeType, productType, onlinePay) {
		var online = offline = '';
		if (from != null && from != '') {
			online = '${ctx}/wap/product/special?openid=${openid}&ftype=online&orderId=' + orderId;
			offline = '${ctx}/wap/product/special?openid=${openid}&ftype=offline&orderId=' + orderId;
		} else {
			online = '${ctx}/wap/cnpay/sgate?openid=${openid}&order_no=' + orderId;
			offline = '${ctx}/wap/product/pay?openid=${openid}&productId=%s&money=%s&orderId=%s';
			offline = offline.format(productId, money, orderId);
		}
		if ((incomeType && productType == 1) || (onlinePay == 0 || onlinePay == null || onlinePay == '')) {
			$.pop.pull(
				[
					{
						'note' : '请选择支付方式',
					},
					{
						'text' : '线上支付',
						'call' : function() {
							location.href = online;
						}
					},
					{
						'text' : '线下转账',
						'call' : function() {
							location.href = offline;
						}
					}
				],
				[
					{
						'itel' : '客服热线:#4006196805#'
					}
				]
			);
		} else {
			location.href = online;
		}
	}
	function cancel(id) {
		$.pop.chio({
			text : '提示',
			note : '是否确认取消订单?',
			left : {
				text : '否',
				call : function() {
					// operate
				}
			},
			rite : {
				text : '是',
				call : function() {
					$.ios.ajax({
						url : '${ctx}/wap/user/cancel/' + id + '?openid=${openid}',
						msg : {
							text : '正在取消订单', succ : '取消订单成功',
							fail : '取消订单失败', warn : '系统繁忙'
						},
						success : function(response) {
							return {
								flag : response.result == 1,
								call : function(flag) {
									if (flag) {
										$("#invest_" + id).remove();
										var items = $("article").find(".list01");
										if (items == null || items.length == 0) {
											$("article").html(
												'<div id="d">' + 
													'<img src="${img}/icon_imfnone.png">' + 
													'<h3>暂无产品,去投资吧~</h3>' + 
												'</div>'
											);
										}
									}
								}
							};
						}
					});
				}
			}
		});
	}
	function hint() {
		$.pop.hint({
			text : '支付开放时间',
			note : '5/29上午9:00 - 6/1上午11:00'
		});
	}
</script>
</head>

<body>
<c:if test="${need_head}">
	<header>
		我的投资
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<section class="details" style="padding:0 10px;">
	<article>
		<c:forEach var="cell" items="${list}">
			<div class="list01" id="invest_${cell.id}">
	        	<p onclick="location.href='${ctx}/wap/product/detail?id=${cell.productId}'" style="background: url('${img}/icon_more.png') no-repeat right; background-size: 42px;">${cell.productName}</p>
            	<ul class="priceNum">
            		<li><h4><span>投资金额：</span>${cell.investMoney}<em>元</em></h4></li>
            		<c:if test="${cell.status != 3}">
	                    <li><h4><span>预期收益：</span><fmt:formatNumber pattern="0.00" value="${cell.doubleIncomeMoney}" /><em>元</em><c:if test="${cell.incomeFloat == 1}">&nbsp;<i>或以上</i></c:if></h4></li>
            		</c:if>
            		<c:if test="${cell.status == 3}">
	                    <li><h4><span>实际收益：</span><fmt:formatNumber pattern="0.00" value="${cell.doubleIncomeMoney}" /><em>元</em></h4></li>
            		</c:if>
                    <li><h4><span>总计：</span><fmt:formatNumber pattern="0.00" value="${cell.investMoney + cell.doubleIncomeMoney}" /><em>元</em><c:if test="${cell.incomeFloat == 1}"><c:if test="${cell.status != 3}">&nbsp;<i>或以上</i></c:if></c:if></h4></li>
            	</ul>
            	<ul class="priceNum" style="font-size: 14px;">
            		<c:if test="${cell.incomeType == 1}">
	            		<li><span>起息日：</span><fmt:formatDate value="${cell.incomeStartTime}" pattern="yyyy-MM-dd" /></li>
	                    <li><sapn>到期日：</span><fmt:formatDate value="${cell.incomeEndTime}" pattern="yyyy-MM-dd" /></li>
            		</c:if>
            		<c:if test="${cell.incomeType == 2}">
            			<c:if test="${cell.order.status == 1}">
            				<li><span>起息日：</span><fmt:formatDate value="${cell.incomeStartTime}" pattern="yyyy-MM-dd" /></li>
	                    	<li><sapn>到期日：</span><fmt:formatDate value="${cell.incomeEndTime}" pattern="yyyy-MM-dd" /></li>
            			</c:if>
            			<c:if test="${cell.order.status != 1}">
		            		<li><span>起息日：</span>自缴款日次日起开始计息</li>
		                    <li><sapn>到期日：</span>自缴款日次日起第${cell.incomeDays}日</li>
            			</c:if>
            		</c:if>
            	</ul>
            	<c:if test="${cell.status == 2}">
	            	<ul class="priceNum">
	            		<li><h4><span>目前累计收益：</span><fmt:formatNumber value="${cell.current}" pattern="0.00"/><em>元</em></h4></li>
	            	</ul>
            	</c:if>
            	<c:if test="${cell.status != 1 && cell.order.productType == 1}">
	            	<ul class="priceNum" style="background: url('${img}/icon_more.png') no-repeat right; background-size: 42px;">
		            	<li onclick="location.href='${ctx}/wap/product/contract?openid=${openid}&productId=${cell.productId}&orderId=${cell.orderId}'"><h4><span>电子合同</span></h4></li>
	            	</ul>
            	</c:if>
            	<c:if test="${cell.status == 1}">
            		<c:choose>
            			<c:when test="${cell.order.status == 1}">
            				<c:if test="${cell.order.productType == 1}">
            				<ul class="priceNum" style="background: url('${img}/icon_more.png') no-repeat right; background-size: 42px;">
				            	<li onclick="location.href='${ctx}/wap/product/contract?openid=${openid}&productId=${cell.productId}&orderId=${cell.orderId}'"><h4><span>电子合同</span></h4></li>
			            	</ul>
			            	</c:if>
			            	<ul class="priceNum">
				            	<li class="status">已支付</li>
				            </ul>
			            	<!-- 
			            	<c:if test="${cell.jackpot == 0}">
				            	<ul class="priceNum">
					            	<li class="status">已支付</li>
					            </ul>
			            	</c:if>
			            	<c:if test="${cell.jackpot == 1}">
			            		<ul class="priceNum" style="padding:0;border:0;">
					            	<li class="btn f40Bg" style="background: #fff;"><a href="javascript:;" style="color: #ff4400;">已支付</a></li>
					            	<li class="btn grayBg" style="background: #ff6147;"><a href="${ctx}/wap/jackpot/index?productId=${cell.productId}" style="color: #fff;">去抽奖</a></li>
					            </ul>
			            	</c:if>
			            	<c:if test="${cell.jackpot == 2}">
			            		<ul class="priceNum" style="padding:0;border:0;">
			            			<li class="btn f40Bg" style="background: #fff;"><a href="javascript:;" style="color: #ff4400;">已支付</a></li>
					            	<li class="btn f40Bg" style="background: #fff;"><a href="javascript:;" style="color: #ff4400;">已抽奖</a></li>
					            	<li class="minLine"></li>
					            </ul>
			            	</c:if>
			            	-->
            			</c:when>
            			<c:otherwise>
            				<ul class="priceNum" style="padding:0;border:0;">
            					<c:if test="${cell.productId == specialProductId_1 || cell.productId == specialProductId_2 || cell.productId == specialProductId_3}">
				            		<li class="btn f40Bg"><a href="javascript:void(0);" onclick="payShow('${cell.orderId}',${cell.investMoney},'${cell.productId}', 'special', ${cell.incomeType}, ${cell.order.productType}, ${cell.order.onlinePay});">继续支付</a></li>
				            		<li class="btn grayBg"><a href="javascript:cancel(${cell.id});">取消订单</a></li>
			                	</c:if>
			                	<c:if test="${cell.productId != specialProductId_1 && cell.productId != specialProductId_2 && cell.productId != specialProductId_3}">
			                		<li class="btn f40Bg"><a href="javascript:void(0);" onclick="payShow('${cell.orderId}',${cell.investMoney},'${cell.productId}', '', ${cell.incomeType}, ${cell.order.productType}, ${cell.order.onlinePay});">继续支付</a></li>
				            		<li class="btn grayBg"><a href="javascript:cancel(${cell.id});">取消订单</a></li>
			                	</c:if>
				            </ul>
            			</c:otherwise>
            		</c:choose>
            	</c:if>
	    	</div>
		</c:forEach>
		<c:if test="${empty(list)}">
			<div id="d"><img src="${img}/icon_imfnone.png"><h3>暂无投资</h3></div>
		</c:if>
	</article>
	<%-- </section>
	  <section class="telphone" id="telphone">
	    <ul>
	        <li><a href="${ctx}/wap/cnpay/sgate?order_no=#orderId#">在线支付</a></li>
	        <li><a href="${ctx}/wap/product/pay?productId=#productId#&money=#money#&orderId=#orderId#">线下转账</a></li>
	        <li><a href="javascript:payHide();">取消</a></li>
	    </ul>
	  </section> --%>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>