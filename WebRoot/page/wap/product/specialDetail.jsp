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
<title>${snm}<c:if test="${!need_head}"> - 产品详情</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<link type="text/css" rel="stylesheet" href="${css}/animate.min.css" />
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/jquery.form.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script>
	$(document).ready(function() {
	
		$(".select").parent().find("li").click(function() {
			$(".select").removeClass("select");
			$(this).addClass("select");
			if ($(this).attr("id") == "productNote") {
				$("#p_note").show();
				$("#a_note").hide();
			} else {
				$("#p_note").hide();
				$("#a_note").show();
			}
		});
		leftH4();
	});
	
    function save() {
   		var msg = {
			text : '正在提交', succ : '提交成功', fail : '提交失败'
		};
   			$.pop.chio({
				text : '提示',
				note : '是否确认投资${object.subscribeMoney}元?',
				left : {
					text : '取消',
					call : function() {
						// operate
					}
				},
				rite : { 
					text : '确认',
					call : function() {
						$.ios.ajax({
							url : '${ctx}/wap/product/specialBuy?openid=${openid}',
							msg : msg, data : getdata(),
							success : function(response) {
								var flag = response.result == 1;
								return {
									flag : flag ? true : null,
									call : function() {
										process(response);
									}
								};
							}    			
		    			});
					}
				}
			});
	}
	
	function getdata() {
		return {
			money : "${object.subscribeMoney}",
			productId : $("#productId").val()
		};
	}
	
	function process(response) {
		if (response.result == 1) {
			var url = '${ctx}/wap/product/specialPay?openid=%s&productId=%s&money=%s&orderId=%s';
			location.href = url.format('${openid}', '${object.id}', "${object.subscribeMoney}", response.data);
		} else {
			if (response.result == 401) {
				$.pop.chio({
					text : '提示',
					note : '投资前请先登录哦!',
					left : {
						text : '等会儿吧',
						call : function() {
							// operate
						}
					},
					rite : { 
						text : '立即登录',
						call : function() {
							var url = '${ctx}/wap/user/slogin?';
							url += 'openid=%s&redirect_uri=%s';
							var i_redirect_uri = location.href;
							url = url.format('${openid}', i_redirect_uri.encode());
							location.href = url;
						}
					}
				});
			} else if (response.result == 403) {
				$.pop.hint({
					text : '提示',
					note : '账号还在审核中!'
				});
			} else {
				$.pop.hint({
					text : '提示',
					note : response.message,
					call : function() {
					
					}
       			});
			}
		}
	}
    
    function leftH4(){
    	$(".left h4").each(function(i) {
    		while ($(this).height() > 52) {
    			var regex = /(\s)*([a-zA-Z0-9]+|\W)(\.\.\.)?$/;
    			var txt = $(this).text().replace(regex, "...");
       	 		$(this).text(txt);
   	 		};
   	 		leftH(i);
		});
    }
    
    function leftH(i) {
  	 	if (i % 2 == 0) {
  	 		var $this = $($(".left h4")[i]);
  	 		var $thisN = $($(".left h4")[i+1]);
  	 		var height = $this.height();
  	 		var heightN = $thisN.height();
			var result = height > heightN ? height : heightN;
  	 		$this.css({"minHeight" : result});
  	 		$thisN.css({"minHeight" : result});
  	 	}
    }
    
    function guide(){
		$("#guide").show();
	}
	
	function inviteText(){
		var height=$(".invited").height();
		if(height>48){
			$(".invited").css("line-height","22px");
			height=$(".invited").height();
		}else{
			$(".invited").css("line-height","36px");
			height=$(".invited").height();
		}
		//$(".details h3").css("margin-top",height);
	}
	
	function register() {
		var url = '${ctx}/wap/user/regist?';
		url += 'openid=%s&redirect_uri=%s';
		var i_redirect_uri = location.href;
		url = url.format('${openid}', i_redirect_uri.encode());
		location.href = url;
	}
	
	function slogin() {
		var url = '${ctx}/wap/user/slogin?';
		url += 'openid=%s&redirect_uri=%s';
		var i_redirect_uri = location.href;
		url = url.format('${openid}', i_redirect_uri.encode());
		location.href = url;
	}
	
	function investment() {
		$("#invesTips").removeClass("slideOutUp").addClass("slideInDown").show();
		$("#invesTips").not("#contentTip").click(function() {
			$("#invesTips").removeClass("slideInDown");
			$("#invesTips").addClass("slideOutUp");
		});
	};
</script>
<style>
	.list01,.list02 { border-bottom:none; }
	.list01 .left h4 { font-size:13px; }
	.list01 .left h4,.list01 .left span{margin:0 auto;width:94%;}
	.list01 .left:nth-child(even){background:url(${img}/d7.png) left center no-repeat;}
	#fsave { background:#e2e6eb; }
	.introduce div img { max-width: 100%; }
	.invited{width:100%;line-height:30px;padding:6px 0;display:block;font-size:17px;color:#000;text-indent:10px;}
	.invited p span{margin-left:10px}
	#guide{position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.5) url(${img}/guide.png) center 50px no-repeat;display:none;z-index:99999}
	footer .payMoney{width: 100%;text-align: center;color: #fff;font-size: 17px;line-height: 49px;height: 49px;display: block;background: #ef4023;}
	.investment{position:absolute;top:-30px;right:10px;width:70px;height:70px;border:4px solid #f7a091;overflow:hidden;border-radius:50%;-webkit-border-radius:50%;-moz-border-radius:50%;-o-border-radius:50%;-ms-border-radius:50%;}
	.investment a{background:#432927;width:100%;height:100%;display:block;text-align:center;line-height:80px;color:#ef4023;font-size:13px;}
	.investment a:after{content:"";position:absolute;bottom:8px;left:30px;width:10px;height:10px;display:block;background:url(${img}/icon_down_red.png) center center no-repeat;background-size:10px auto;}
	.invesTips{position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.8);z-index:999999;display:none;}
	.invesTips article{padding-top:10px;text-align:center;background:#fff;line-height:200%;font-size:16px;}
	.invesTips article h4{color:#ef4023;}
	.invesTips  article h4:before{content:"";width:30px;height:20px;background:url(${img}/icon_tip.png) center center no-repeat;display:inline-block;background-size:26px auto;}
	.invesTips  article .red{padding:0 6px;color:#ef4023;}
	.invesTips  article p{font-size:14px;}
	.invesTips  article .btn{width:100%;height:44px;line-height:44px;display:block;color:#64a3cb;background:#f4f4f4;border-top:1px solid #d7d7d7;font-size:16px;}
</style>
</head>

<body>
<form id="form" action="${ctx}/wap/product/buy" method="post">
<input type="hidden" id="productId" name="productId" value="${object.id}" />
<c:if test="${need_head}">
	<header>
		产品详情
		<a href="javascript:window.history.go(-1);" class="back">返回</a>
	</header>
</c:if> 
<section class="details">
	<c:if test="${isSpecialProduct && puser != null }">
		<div class="invited">
			<p>你的朋友‘${puser.realname}’向你推荐：<%-- <span>${object.name}</span> --%></p>
		</div>
	</c:if>
	
	<h3>${object.name}</h3>
    <article>
    	<div class="list01">
            <div class="left">
            	<span>投资金额</span>
                <h4 class="colorRed">${object.subscribeMoney}元
                </h4>
            </div>
            <c:if test="${object.startTimeShow == 1}">
	            <div class="left">
	            	<span>起息日</span>
	                <h4>${object.startTime}</h4>
	            </div>
            </c:if>
            <c:if test="${object.expectIncomeShow == 1}">
	            <div class="left">
	            	<span>预期年化收益</span>
	                <h4>${object.expectIncome}</h4>
	            </div>
	        </c:if>
            <c:if test="${object.allotTypeShow == 1}">
	            <div class="left">
	            	<span>收益分配方式</span>
	                <h4>${object.allotType}</h4>
	            </div>
	        </c:if>
	        <c:if test="${object.endTimeShow == 1}">
	            <div class="left">
	            	<span>期限</span>
	                <h4>${object.endTime}</h4>
	            </div>
	        </c:if>
            <c:forEach items="${object.productProjects}" var="list">
	        	<div class="left">
	            	<span>${list.name}</span>
	                <h4>${list.note}</h4>
	            </div>
        	</c:forEach>
        </div>
        <c:if test="${flag == null }">
        	<c:if test="${object.buyStatus == 1}">
	        	<div class="list02" style="border-bottom: 0px;">
		        	<div class="invest">
		                <!--不需要输入F码时-->
		                <a class="investBtn02" style="margin-bottom: 10px;" href="javascript:save();">立即投资</a>
		                <!-- 
			                <c:if test="${type == null }">
		                		<a class="investBtn02" style="margin-bottom: 10px;" href="javascript:save();">立即投资</a>
		                	</c:if>
		                	<c:if test="${type == 0 }">
			                	<a class="investBtn02" style="margin-bottom: 10px;" href="javascript:register();">立即注册</a>
		                	</c:if>
		                	<c:if test="${type == 1 }">
		                		<a class="investBtn02" style="margin-bottom: 10px;" href="javascript:save();">立即投资</a>
		                	</c:if>
		                	<c:if test="${type == 2 }">
			                	<a class="investBtn02" style="margin-bottom: 10px;" href="javascript:slogin();">立即登录</a>
		                	</c:if>
	                	-->
		            </div>
		        </div>
	        </c:if>
        </c:if>
        <div class="introduce">
        	<ul>
            	<li class="select" id="productNote">产品介绍</li>
                <li class="" id="allotNote">分配计划</li>
            </ul>
            <div id="p_note" class="content">
            	${object.productNote}
            </div>
            <div id="a_note" class="content" style="display: none;">
            	${object.allotNote}
            </div>
        </div>
    </article> 
</section>
<footer class="bottom">
	<c:if test="${flag != null && flag }">
		<a class="payMoney" style="margin-bottom: 10px;" href="javascript:register();">我想认购</a>
	</c:if>
	<c:if test="${flag == null }">
		<ul>
	    	<li><a class="forward" style="color: black;" href="javascript:guide();">分享给好友</a></li>
	        <li><a class="share" style="color: black;" href="javascript:guide();">分享到朋友圈</a></li>
	    </ul>
	</c:if>
</footer>
<section id="guide" onclick="$('#guide').hide();"></section>
</form>
<!-- <section class="investment" id="investment">
	<a href="javascript:investment();">投资提示</a>
</section> -->
<section class="invesTips win animated" id="invesTips">
	<article class="win" id="contentTip">
		<h4><span class="icon_tip"></span>你必须满足以下条件才能投资该项目</h4>
		<p><span class="red">1</span>年龄：18～65岁<span class="red">2</span>风险承受能力：稳健型</p>
		<a class="btn" href="${ctx}/wap/riskEvaluation/index?openid=${openid}">检测我是否满足条件</a>
	</article>
</section>
</body>
<%@ include file="/jsp/shared.jsp"%>
<script type="text/javascript">
	wx.ready(function () {
		wx.onMenuShareAppMessage({
		    title	: '你的朋友\'${user.realname}\'向你推荐',	// 分享标题
		    desc	: '\'${object.name}\',预期年化收益${object.expectIncome},${object.endTime},1元支付',	// 分享描述
		    link	: '${lctx}/wap/product/detail?id=${object.id}&pid=${userId}&flag=true',	// 分享链接
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
		    title	: '你的朋友\'${user.realname}\'向你推荐\'${object.name}\',预期年化${object.expectIncome},${object.endTime},${object.actualPayMoney}元支付', // 分享标题
		    link	: '${lctx}/wap/product/detail?id=${object.id}&pid=${userId}&flag=true', // 分享链接
		    imgUrl	: '${lctx}/images/pic_share.jpg', // 分享图标
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

