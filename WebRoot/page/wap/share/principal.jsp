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
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>高和畅 - 特权本金</title>
<link rel="stylesheet" href="${css}/spacel.css" />
<link rel="stylesheet" href="${css}/animate.min.css" />
<script type="text/javascript" src="${js}/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
</head>
<body>
	<div class="swiper-container">
		<section id="wrap" class="swiper-wrapper">
			<section class="swiper-slide sect section0" id="page0">
				<section class="logo animated ">
					<img src="${img}/principal/logo.png" alt="" />
				</section>
				<section class="slogn animated  delay05">
					<img src="${img}/principal/text.png" alt="" />
				</section>
				<section class="people animated ">
					<img src="${img}/principal/people.png" alt="" />
				</section>
				<section class="text0 animated delay08">
					<h3>畅享周专享理财计划</h3>
					<section class="content">
						<p>投资金额：<span>10000元</span></p>
						<p style="padding-left:70px;"><span>（实际支付1元或10金币)</span></p>
						<p>投资期限：<span>7天</span></p>
						<p>预期年化收益率：<span>8%</span></p>
					</section>
					<img class="ercode animated  delay10" src="${img}/principal/ercode.png" alt="" />
				</section>
				<section class="moreBtn"><img src="${img}/principal/more-btn.png" alt="" /></section>
			</section>
			<section class="swiper-slide sect section1" id="page1">
				<section class="elephant">
					<ul>
						<li class="e_left animated "><img src="${img}/principal/elephant_girl.png" alt="左边大象"/></li>
						<li class="e_right animated "><img src="${img}/principal/elephant_boy.png" alt="右边大象"/></li>
					</ul>
				</section>
				<a class="btn animated " href="javascript:tipsfadeIn();"></a>
				<section class="note borderR10 animated ">
					<section class="product animated " id="product">
						<h3 class="borderR10">金钥匙</h3>
						<section>
							<h4>京沪核心商业物业类<br />资产证券化产品</h4>
							<p>以北京东三环地铁上盖写字楼为底层基础资产的类资产证券化产品，以万元的资金门槛便于可参与短期限、高收益、高保障的理财产品。</p>
							<ul class="head">
								<li class="orangeBg borderR-top">期 限</li>
								<li class="redBg borderR-top">预期年化 <br/>收益率</li>
								<li class="orangeBg borderR-top">投资金额</li>
							</ul>
							<ul class="date">
								<li>7天</li>
								<li>8.0%</li>
								<li style="line-height:24px;">10000元<span style="font-size:7px;display:block;line-height:10px;">(实际支付1元或10金币)</span></li>
							</ul>
						</section>
					</section>
					<section class="rule borderR10 animated" id="rule">
						<h3>&bull;活动规则&bull;</h3>
				        <section class="list">
				             <p> ■ 活动时间：2015年8月7日——2015年12月31日；</p>
				             <p> ■ 客户支付1元人民币或10金币加获赠的9999元特权本金即可认购1万元特权本金产品；</p>
				             <p> ■ 请确保已注册高和畅平台，否则将导致投资本金无法发送至个人账户；</p>
				             <p> ■ 产品到期后所赠特权本金由高和畅收回，收益将存入客户账户内，经认证银行卡即可保证收益提取；</p>
				             <p> ■ 本次活动由高和畅平台举办，最终解释权归高和畅平台所有。</p>
				        </section>
					</section>
				</section>
				<section class="change">
					<a  class="active" href="javascript:void(0);" onclick="changes(this)">活动规则</a>
					<a href="javascript:void(0);" style="display:none;" onclick="changes(this)">返回</a>
				</section>
			</section>
		</section>
		<div id="tipPid" style="display: none" class="tip">
	      <div class="point">
	        <!-- <p><span>1</span>点击右上角图标</p>
	        <p><span>2</span>在弹出菜单中选择分享到朋友圈</p>
	        <p><span>3</span>领取金币</p> -->
	        <p>分享给我的好友！</p>
	      </div>
	    </div>
	</div>
	<script src="${js}/swiper.min.js"></script>
	<script>
		$(function(){

			$("#page1").find('.animated').hide();

			//滑动控件
			slideControl();
			
    		
		});


		function  slideControl(){
			event.preventDefault();
			var height=$(window).height();
		    var mySwiper = new Swiper('.swiper-container', {
		    	initialSlide:0,
		    	height:height,
		        pagination: '.swiper-pagination',
		        paginationClickable: true,
		        direction: 'vertical',
		        longSwipes:0.01,
		        mousewheelControl:true,
		        shortSwipes:true,
		        onInit:function(mySwiper){
		        	$("#page0").find('.logo').fadeIn().addClass('slideInDown');
				    $("#page0").find('.slogn').fadeIn().addClass('bounceIn');
				   	
				   		$("#page0").find('.text0').fadeIn().addClass('zoomIn');
				    	$("#page0").find(".ercode").fadeIn().addClass('slideInUp');
				   
				    $("#page1").find('.animated').hide();
				    setTimeout(function(){
				    	$("#page0").find('.people').show().addClass('slideInDown');
				    },1500);
		        },
		        onSlideChangeStart: function(mySwiper){
		        	var index=mySwiper.activeIndex;
				      switch (index){
				      	case 0 : 
				      		$("#page0").find('.logo').fadeIn().addClass('slideInDown');
				      		$("#page0").find('.slogn').fadeIn().addClass('bounceIn');
				      		$("#page0").find('.text0').fadeIn().addClass('zoomIn');
				      		$("#page0").find(".ercode").fadeIn().addClass('slideInDown');
				      		$("#page1").find('.animated').hide();
				      		setTimeout(function(){
				    	$("#page0").find('.people').show().addClass('slideInDown');
				    },1500);
				      		break;
				      	case 1 : 
				      		$("#page1").find('.e_left').fadeIn().addClass('slideInLeft');
				      		$("#page1").find('.e_right').fadeIn().addClass('slideInRight');
				      		$("#page1").find('.btn').fadeIn().addClass('rubberBand');
				      		$("#page1").find('.note').fadeIn().addClass('slideInLeft');
				      		$("#page1").find('.product').fadeIn().removeClass("slideOutLeft").addClass('slideInLeft');
				      		$("#page0").find('.animated').hide();
				      		$("#page1").find('.active').show().siblings('a').hide();
				      		break;
				      }
				}
		    });
		}

		function changes(t){
			if($(t).hasClass('active')){
				$(".note").css("margin-top","0px");
				$("#product").removeClass('slideInLeft').removeClass('delay05').addClass('slideOutLeft').hide();
				$("#rule").show().addClass('slideInRight');
			}else{
				$(".note").css("margin-top","10px");
				$("#rule").removeClass('slideInRight').removeClass('delay05').addClass('slideInLeft').hide();
				$("#product").removeClass('slideOutLeft').show().addClass('slideInLeft');

			}
			$(t).hide().siblings('a').fadeIn();
		}

		function tipsfadeIn(){
			location.href = '${ctx}/wap/product/detail?id=${spid}';
  		}
	</script>
</body>
<%@ include file="/jsp/shared.jsp"%>
<script type="text/javascript">
	wx.ready(function () {
		wx.onMenuShareAppMessage({
			title	: '【畅享福利】支付1元或10金币即享9999元特权本金！',	// 分享标题
			desc	: '8.6-8.13特权本金欢畅送，收益可提现咯！',	// 分享描述
			link	: '${lctx}/wap/share/principal',	// 分享链接
			imgUrl	: '${lctx}/images/principal/sp_share_logo.png',	// 分享图标
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
			title	: '【畅享福利】支付1元或10金币即享9999元特权本金！',	// 分享标题
			link	: '${lctx}/wap/share/principal',	// 分享链接
			imgUrl	: '${lctx}/images/principal/sp_share_logo.png',	// 分享图标
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