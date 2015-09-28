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
.gold{padding:0px 0 4px 0;width:100%;}
.gold p{line-height:34px;font-size:16px;color:#000;font-style:normal;}
.gold p i{font-style:normal;font-weight:normal;font-size:14px}
.gold .money{margin-top:20px;border-top:1px solid #e4e4e4;/*border-bottom:1px solid #e4e4e4;*/text-indent:12px;line-height:40px}
.gold .money span{float:right;margin-right:10px;font-size:20px;}
.gold input{width:120px;margin:6px 0 10px 0;font-size:15px; text-indent:6px; height:30px;line-height:30px;border:none;border:2px solid #e4e4e4;border-radius:3px 3px;-webkit-border-radius:3px 3px;-moz-border-radius:3px 3px;-o-border-radius:3px 3px;-ms-border-radius:3px 3px;}
.btn{width:100%}
.btn a{margin:10px auto;width:92%;height:40px;line-height:40px;display:block;text-align:center;background:#ef4023;color:#fff;border-radius:5px 5px;-webkit-border-radius:5px 5px;-ms-border-radius:5px 5px;-o-border-radius:5px 5px;-ms-border-radius:5px 5px;-moz-border-radius:5px 5px;}
.payFun{margin:0 auto;width:92%;}
.payFun p{position:relative;line-height:50px;}
.checked{background-position: -22px 0;}
.flat{position:absolute;top:14px;left:0;width:20px;height:20px;display:inline-block;background-image: url(${img}/flat@2x.png);-webkit-background-size: 176px 22px;background-size: 176px 22px;}
ul li{position:relative;margin:5px auto ;width:100%;/*border:1px solid #e4e4e4;*/display:block;overflow:hidden;zoom:1;color:#888;background: -webkit-radial-gradient( transparent 0px, transparent 4px, #ebeee7 4px, #ebeee7 );background-size: 15px 20px;background-position: -10px -10px;}
ul li:after{content: '';position: absolute;left: 5px;top: 5px;right: 5px;bottom: 5px;z-index: -1;}
ul li p{float:left;display:block;text-align:left;}
ul li .left{width:80px;height:82px;line-height:72px;font-size:14px;color:#fff;background: -webkit-radial-gradient( transparent 0px, transparent 4px, #feba33 4px, #feba33 );background-size: 15px 20px;background-position: -10px -10px;}
ul li .left span{margin:4px auto;width:92%;height:90%;display:block;background:#feba33;text-align:center;}
ul li .left em{font-size:26px;font-style:normal;}
ul li .right{position:relative;top:0;left:0;width:70%;font-size:14px;line-height:24px;}
ul li .right span{margin:4px auto;padding:0 10px;padding-top:4px;min-height:70px;display:block;background:#ebeee7;line-height:22px;overflow:hidden;zoom:1;}
ul li .right span i{position:absolute;bottom:4px;right:10px;}
ul li .right i{float:right;margin:0px 4px 4px 0;display:block;font-style:normal;font-size:10px;line-height:14px;border:1px solid #feba33;border-radius:5px;padding:2px 4px;color:#feba33;}
.selectTicket{margin-left:30px;color:#feba33}
.del,.selected a{position:absolute;top:0px;right:0;width:20px;height:20px;display:block;text-align:center;color:#fff;font-size:14px;line-height:20px;}
.del{background:#fe4023;}
.ticketList {position:fixed;top:0;left:0;right:0;bottom:0;background:#fff;display:none;z-index:999;}
<%-- .ticketList ul{margin:10px auto 180px auto;width:92%;background:#fff;} --%>
.ticketList ul{width:92%;background:#fff;position:absolute;left:4%;top:10px;bottom:60px;overflow-y:scroll;}
.selected a{background:#4fc66a;}
.mark{display:none;}
.sectBtn{position:fixed;bottom:0px;background:#fff;width:100%;}
.sectBtn a{margin-left:4%;width:92%;}
.gold .head{padding:5px 0;width:100%;background: rgba(24,24,29,0.9);text-align:center;}
.gold .head p{color:#fff;font-weight:bold;line-height:30px;}
#use_coupon {
	display: none;
}
</style>
<script>
	$(document).ready(function() {
	
		if ('${product.canUseCoupon}' == '1') {
			$("#use_coupon").show();
		}
		
		initgold();
	
		var timer = setInterval(function() {
			if ($("#goldCont").attr("checked") == "checked" && $("#goldTicket").attr("checked") == "checked") {
				//两个都选中
				var money = '${money}';
				if ($("#useIntegral").val() == parseInt($("#useIntegral").val())) {
					if (parseInt('${product.smallProduct}') == 0) {
						$("#em").html(money * 10000 - parseInt($("#useIntegral").val()) - allMoney);
					} else {
						$("#em").html(money - parseInt($("#useIntegral").val()) - allMoney);
					}
			    } else {
			    	if (parseInt('${product.smallProduct}') == 0) {
						$("#em").html(money * 10000 - allMoney);
					} else {
						$("#em").html(money - allMoney);
					}
			    }
			} else if ($("#goldCont").attr("checked") == "checked") {
				//选中金币
				if ($("#useIntegral").val() == parseInt($("#useIntegral").val())) {
			    	var money = '${money}';
			    	if (parseInt('${product.smallProduct}') == 0) {
						$("#em").html(money * 10000 - parseInt($("#useIntegral").val()));
					} else {
						$("#em").html(money - parseInt($("#useIntegral").val()));
					}
			    } else {
			    	if (parseInt('${product.smallProduct}') == 0) {
						$("#em").html('${money * 10000}');
					} else {
						$("#em").html('${money}');
					}
			    }
			} else if ($("#goldTicket").attr("checked") == "checked") {
				//选中代金券
				var money = '${money}';
				if (parseInt('${product.smallProduct}') == 0) {
					 $("#em").html(money * 10000 - allMoney);
				} else {
					 $("#em").html(money - allMoney);
				}
			} else if ($("#goldTicket").attr("checked") != "checked" && $("#goldCont").attr("checked") != "checked") {
				//都没选中
				if (parseInt('${product.smallProduct}') == 0) {
					$("#em").html('${money}' * 10000);
				} else {
					$("#em").html('${money}');
				}
			}
		}, 100);
		
		checkBox();
		selected();
	});
	
	function initgold() {
		var goldmy = parseInt('${integral}');
		var goldon = parseInt('${maxintegral}');
		if (goldmy < goldon) { goldon = goldmy; }
		$("#useIntegral").val(goldon);
	}
	
	function success() {
		var money = parseInt('${money}') * 10000;
		var integral = parseInt('${integral}');
		if ($("#goldCont").attr("checked") == "checked" && $("#goldTicket").attr("checked") == "checked") {
			//两个都选中
			if ($("#useIntegral").val() > integral) {
				$.pop.hint({
					text : '提示',
					note : '您没有那么多金币哦',
					call : function() {
						$("#useIntegral").val("");
						$("#useIntegral").focus();
					}
				});
			} else if ($("#useIntegral").val() != "" && ($("#useIntegral").val() != parseInt($("#useIntegral").val()) || parseInt($("#useIntegral").val()) < 0)) {
				$.pop.hint({
					text : '提示',
					note : '输入的金币数有误',
					call : function() {
						$("#useIntegral").val("");
						$("#useIntegral").focus();
					}
				});
			} else if ($("#useIntegral").val() > parseInt('${maxintegral}')) {
				$.pop.hint({
					text : '提示',
					note : '输入金币超过限制',
					call : function() {
						$("#useIntegral").val("");
						$("#useIntegral").focus();
					}
				});
			} else {
				var integral = $("#useIntegral").val();
				if (integral != "") {
					if (allMoney != 0) {
						$.pop.chio({
							text : '提示',
							note : '是否确认使用' + integral + '金币及' + allMoney + '元代金券?',
							left : {
								text : '取消',
								call : function() {
									// operate
								}
							},
							rite : { 
								text : '确认',
								call : function() {
									var url = '${ctx}/wap/product/success?openid=${openid}&productId=%s&money=%s&orderId=%s&useIntegral=%s&cashId=' + ticketId + '&cashMoney=' + allMoney + '&type=3';
									location.href = url.format('${productId}', '${money}', '${orderId}', integral);
								}
							}
						});
					} else {
						$.pop.chio({
							text : '提示',
							note : '是否确认使用' + integral + '金币?',
							left : {
								text : '取消',
								call : function() {
									// operate
								}
							},
							rite : { 
								text : '确认',
								call : function() {
									var url = '${ctx}/wap/product/success?openid=${openid}&productId=%s&money=%s&orderId=%s&useIntegral=%s&cashId=' + ticketId + '&cashMoney=' + allMoney + '&type=3';
									location.href = url.format('${productId}', '${money}', '${orderId}', integral);
								}
							}
						});
					}
				} else {
					var url = '${ctx}/wap/product/success?openid=${openid}&productId=%s&money=%s&orderId=%s&useIntegral=%s&cashId=' + ticketId + '&cashMoney=' + allMoney + '&type=3';
					location.href = url.format('${productId}', '${money}', '${orderId}', integral);
				}
			}
		} else if ($("#goldCont").attr("checked") == "checked") {
			//选中金币
			if ($("#useIntegral").val() > integral) {
				$.pop.hint({
					text : '提示',
					note : '您没有那么多金币哦',
					call : function() {
						$("#useIntegral").val("");
						$("#useIntegral").focus();
					}
				});
			} else if ($("#useIntegral").val() != "" && ($("#useIntegral").val() != parseInt($("#useIntegral").val()) || parseInt($("#useIntegral").val()) < 0)) {
				$.pop.hint({
					text : '提示',
					note : '输入的金币数有误',
					call : function() {
						$("#useIntegral").val("");
						$("#useIntegral").focus();
					}
				});
			} else if ($("#useIntegral").val() > parseInt('${maxintegral}')) {
				$.pop.hint({
					text : '提示',
					note : '输入金币超过限制',
					call : function() {
						$("#useIntegral").val("");
						$("#useIntegral").focus();
					}
				});
			} else {
				var integral = $("#useIntegral").val();
				if (integral != "") {
					$.pop.chio({
						text : '提示',
						note : '是否确认使用' + integral + '金币?',
						left : {
							text : '取消',
							call : function() {
								// operate
							}
						},
						rite : { 
							text : '确认',
							call : function() {
								var url = '${ctx}/wap/product/success?openid=${openid}&productId=%s&money=%s&orderId=%s&useIntegral=%s&type=1';
								location.href = url.format('${productId}', '${money}', '${orderId}', integral);
							}
						}
					});
				} else {
					var url = '${ctx}/wap/product/success?openid=${openid}&productId=%s&money=%s&orderId=%s&useIntegral=%s&type=1';
					location.href = url.format('${productId}', '${money}', '${orderId}', integral);
				}
			}
		} else if ($("#goldTicket").attr("checked") == "checked") {
			//选中代金券
			var url = '${ctx}/wap/product/success?openid=${openid}&productId=%s&money=%s&orderId=%s&cashId=' + ticketId + '&cashMoney=' + allMoney + '&type=2';
			location.href = url.format('${productId}', '${money}', '${orderId}');
		} else {
			//没有选中任何抵用券
			var url = '${ctx}/wap/product/success?openid=${openid}&productId=%s&money=%s&orderId=%s&type=0';
			location.href = url.format('${productId}', '${money}', '${orderId}');
		}
	}
	
	//复选框 代金券，金币
	function checkBox(){
		$(".flat").each(function(){
			$(this).click(function(){
				if($(this).hasClass("checked")){//取消
					$(this).removeClass("checked").parent().find("input[type='checkbox']").removeAttr("checked");
				}else{//选中
					$(this).addClass("checked").parent().find("input[type='checkbox']").attr("checked","checked");
				}
			});
		});
	}
	//选中的代金券删除
	function del(t){
		$this=t;//this
		
		var id=$($this).parent().attr("dataId");
		ticketId.splice($.inArray(id,ticketId),1);//数组内删除id
				
		allMoney -= parseInt($($this).parent().find("em").html());
				
		$($this).parent().remove();
		$("#ticketList ul").find("li[dataId='"+id+"']").removeClass("selected");
		var length=$("#selectList ul").find("li").length;
		if(length==0){
			$("#selectList").hide();
		}
	}
	var ticketId=[];
	var allMoney = 0;
	function selected(){
		$("#ticketList").find("li").each(function(){
			$(this).click(function(){
				if($(this).hasClass("selected")){
					//去除选中状态
					$(this).removeClass("selected").find(".mark").hide();
					var id=$(this).attr("dataId");
					ticketId.splice($.inArray(id,ticketId),1);//数组内删除id
					allMoney -= parseInt($(this).find("em").html());
					$("#selectList ul").find("li[dataId='"+id+"']").remove();
					var length=$("#selectList ul").find("li").length;
					if(length==0){
						$("#selectList").hide();
					}
				}else{
					//选中
					$(this).addClass("selected").find(".mark").show();
					var id=$(this).attr("dataId");
					ticketId.push(id);//数组添加id
					allMoney += parseInt($(this).find("em").html());
					/* 添加到代金券选中区 */
					var liContent=$(this).html();
					var content="<li dataId='"+id+"'>"+liContent+"</li>";
					var delBtn='<a class="del borderR50p" href="javascript:void(0);" onclick="del(this)">X</a>';
					$("#selectList ul").append(content);
					$("#selectList ul").find("li[dataId='"+id+"']").find("a").remove();
					$("#selectList ul").find("li[dataId='"+id+"']").append(delBtn);//添加删除按钮
					$("#selectList").show();
				}
			});
		});
	}
	
	function sure(){
		$("#ticketList").removeClass("slideInRight").addClass("animated slideOutRight");
		$("#gold,#nextBtn").show();
	} 

	function selectTicket(){
		var money = 0;
		if (parseInt('${product.smallProduct}') == 0) {
			money = parseInt('${money}');
		} else {
			money = parseInt('${money}') / 10000.0;
		}
		if (money >= 1) {
			$("#ticketList").show();
			$("#gold,#nextBtn").hide();
			$("#ticketList").removeClass("slideOutRight").addClass("animated slideInRight");
		} else {
			$.pop.hint({
				text : '提示',
				note : '认购1万元及以上才可使用代金券哦',
				call : function() {
					// operate
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
<%-- <section class="suc">
	<h3>认购总金额：<span> ${money * 10000}</span> 元</h3>
</section> --%>
<section class="gold" id="gold">
    <article class="head">
    	<p>产品名称：<span>${product.name}</span></p>
    	<p>认购金额：<span class="redText">${product.smallProduct == 0 ? money * 10000 : money}</span> 元</p>
    </article>
    <article class="payFun" style="padding-top:10px;border-top:1px solid #e4e4e4">
    	<p>
    		<input type="checkbox" id="goldCont" style="display:none;">
    		<i class="flat"></i>
    		<span style="margin-left:30px;color:#000;">使用金币：</span>
    		<input type="tel" id="useIntegral" name="useIntegral" placeholder="请输入金币数"> 个
    	</p>
    	<div style="padding:4px;border:1px dashed #e4e4e4 ;">
    		<p style="line-height:34px;"><span style="font-size:14px;color:#000;">可用金币：</span><span class="redText">${integral}</span>个</p>
        	<p style="font-size:14px;line-height:34px;">备注：<c:if test="${product.smallProduct == 0}">每1万认购</c:if><c:if test="${product.smallProduct == 1}">最多</c:if>可使用${integrallimit}金币</p>
    	</div>
    </article>
    <article id="use_coupon" class="payFun">
    	<p>
    		<input type="checkbox" id="goldTicket" style="display:none;">
    		<i class="flat"></i>
    		<span style="margin-left:30px;color:#000;">使用代金券<a class="selectTicket" href="javascript:selectTicket();">选择代金券</a></span>
    	</p>
    	<div style="padding:4px;border:1px dashed #e4e4e4 ;">
        	<p style="font-size:14px;line-height:34px;">备注：可同时使用多张代金券</p>
    	</div>
    	<div id="selectList" style="margin-bottom:10px;display:none;padding:4px;border:1px dashed #e4e4e4;">
    		<ul>
    		</ul>
    	</div>
    </article>
    <p class="money">待付金额： <span class="redText"><em id="em" style="font-style: normal;">${product.smallProduct == 0 ? money * 10000 : money}</em> 元</span> </p>
</section>
<section class="btn" id="nextBtn">
    <a href="javascript:success()">下一步</a>
</section>
<section class="ticketList" id="ticketList">
	<ul>
		<c:forEach items="${cashCouponList }" var="list">
			<li dataId="${list.id }">
	   			<p class="left"><span>&yen;<em>${list.money }</em></span></p>
	   			<p class="right"><span>单笔投资${list.useCondition }万元及以上可抵扣${list.money }元 <br /><i class="time"><fmt:formatDate pattern="yyyy-MM-dd" value="${list.vaildEndTime }"></fmt:formatDate>到期</i></span></p>
	   			<a class="mark borderR50p" href="javascript:void(0);">√</a>
	 		</li>
		</c:forEach>
	</ul>
	<article class="btn sectBtn">
		<a href="javascript:sure()">确定</a>
	</article>
</section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>

