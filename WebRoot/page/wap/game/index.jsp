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
	<meta http-equiv="Cache-Control" content="must-revalidate">
	<meta http-equiv="x-dns-prefetch-control" content="on" />
	<title>高和畅 - 搭房子</title>
	<link rel="stylesheet" href="${css}/animate.min.css" />
	<link rel="stylesheet" href="${css}/gohigh_house.css" />
	<link rel="stylesheet" href="${css}/swiper.min.css" />
	<script type="text/javascript" src="${js}/jquery.js"></script>
	<script type="text/javascript" src="${js}/play.js"></script>
	<script type="text/javascript" src="${js}/swiper.min.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
	<script>
	var submitFlag=${submitFlag};
	var buyer=${buyer};
		window.onload=function(){
			loadImages(res,reTrue);
			controlScroll();
		};
		function reTrue(){
			$("#load").remove();
			$(".swiper-container").show();
			window.scrollTo(0,0);
			return true;
		}
		function sumbitBtn(flag){
			var href = $("#submit_btn").attr('href');
			$("#submit_btn").attr('href', 'javascript:;');
			$.pop.lock(true);
			var score=$("#score").html();
			$.LD.ajax({
        			url : '${ctx}/wap/game/submitScore?openid=${openid}&userId=${userId}&id=${id}&sn=${shareSn}&score='+score,
        			error : function() {
        				$.pop.lock(false);
        				$("#submit_btn").attr('href', href);
        			},
        			success : function(response) {
        				$.pop.lock(false);
        				$("#submit_btn").attr('href', href);
        				if (response.result == 1 && flag==true) {
        					location.href='${ctx}/wap/game/success?openid=${openid}&id=${id}&sn=${shareSn}&score='+score;//跳转success页面
        				} else {
        					if (response.result == -3) {
        						$.pop.hint({
            						text : '温馨提示',
            						note : response.message
            					});
        					}
        				}
        			}
        		});
		}
		//排行榜
		function charts(){
			location.href='${ctx}/wap/game/charts?openid=${openid}&id=${id}&sn=${shareSn}&userId=${userId}';//跳转排行榜
		}
		//排行榜
		function friends(){
			location.href='${ctx}/wap/game/friend?openid=${openid}&id=${id}&sn=${shareSn}&userId=${userId}';//跳转亲友团
		}
		//play界面
		//${headImage}
		var playLayer=function(){
			document.getElementById("playing").play();
			$(".swiper-container").remove();
			var playHtml='<section id="header" style="position:relative;top:0;left:0;width:100%;height:60px;z-index:9999;display:block;overflow:hidden;zoom: 1;background:url(${img}/game/bg_mine.png) center top no-repeat;background-size:100% 90%;">'+
				'<div class="left">'+
					'<img src="${headImage}" alt="" />'+
					'<span>${nickName}</span>'+
				'</div>'+
				'<div class="right" id="score">0'+
					
				'</div>'+
			'</section>'+
			'<canvas id="play"></canvas>'+
			'<canvas id="movehouse"></canvas>'+
			'<canvas id="house"></canvas>'+
			'<canvas id="houseShow"></canvas>';
			$("#game").append(playHtml);
			window.scrollTo(0,0);
			init();
			drawPlayBg(0,0);//背景
			drawMoveHouse();//画X轴移动的房子
			houseLayer();
			var play=document.getElementById("play");
			playCtx=play.getContext("2d");
		}
		
		function result(){
			unclick=true;
			window.cancelAnimationFrame(timer);
			console.log(unclick)
			document.getElementById("playing").pause();
			var overMusic=document.getElementById("gameover");
			var time=overMusic.duration;
			console.log(time);
			overMusic.play();
			setTimeout(function(){
				console.log("gameover");
				var result=clickTimes-1;
				$("#result").html(result);
				if(result>$("#maxScore").html()){
					$("#maxScore").html(result);
					if(!submitFlag||buyer){
						sumbitBtn(false);
					}
				}
				$("#gameoverResult").show();
				$("#yun,#elephant,#elephant_left").hide();
			},500);
		}
		
		function invited(){
			document.getElementById("tipPid").style.display="block";
		}
		function invitedHide(){
			document.getElementById("tipPid").style.display="none";
		}
		function controlScroll(){
		    var width=$(window).width();
		    var height=$(window).height();

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
		        noSwiping : true,
				noSwipingClass : 'stop-swiping',
		    })
  
		}

		function ruleShow(){
			document.getElementById("rule").style.display="block";
		}
		
	</script>

</head>
<body style="background:#7aedf1">
	<canvas id="load"></canvas>
	<section class="swiper-container" style="display:none;top:0;left:0;">
		<section class="swiper-wrapper" style="top:0;left:0;">
			<section class="swiper-slide page1"><section class="moreBtn"><img src="${img}/more-btn.png" alt="" /></section></section>
			<section class="swiper-slide page2"><section class="moreBtn"><img src="${img}/more-btn.png" alt="" /></section></section>
			<section class="swiper-slide page3"><section class="moreBtn"><img src="${img}/more-btn.png" alt="" /></section></section>
			<section class="swiper-slide page4 menu swiper-no-swiping">
				<a href="javascript:playLayer();" class="btn start"></a>
				<a href="javascript:charts();" class="btn charts"></a>
				<section class="conet">
					<a href="javascript:friends();" class="friend">亲友团</a>
					<a href="javascript:ruleShow();" class="rule">游戏规则</a>
				</section>
				<section id="rule">
					<h3></h3>
					<a href="javascript:ruleHide();" class="close"></a>
					<article class="content">
				<ul>
						<li><span class="bull">1</span> 活动时间：9月4日下午15:30起至9月6日23:59分;</li>
						<li><span class="bull">2</span> 此次活动为高和畅平台客户专享活动，成功认购【畅享杯锦标赛】活动产品的用户可通过参与和邀请的朋友参与游戏比赛，按照总成绩排名提高所认购【畅享杯锦标赛】产品的相应收益率，最高不超过预期年化收益率20%;</li>
						<li><span class="bull">3</span> 成功认购【畅享杯锦标赛】活动产品的用户为每队的【队长】，并可以通过微信邀请朋友加入自己的【亲友团】一起参与比赛，提高本队的总成绩;</li>
						<li><span class="bull">4</span>【队长】可以多次参加并多次提交成绩，以提交的历史最高成绩作为个人的最终成绩计入本队总分;</li>
						<li><span class="bull">5</span>【亲友团】成员可多次参加比赛，但仅可提交一次成绩，以唯一提交的成绩作为个人参与的最终成绩计入本队总分;</li>
						<li><span class="bull">6</span> 在活动结束后，高和畅将根据每队【队长】和【亲友团】的个人最终成绩累计总和，计算整体排名，并确认每位【队长】最后的活动奖励;</li>
						<li><span class="bull">7</span> 若出现最终累积成绩一样的队伍，以达到累计层数的时间先后排序在排行榜进行排名；</li>
						<li><span class="bull">8</span> 若出现两队及两队以上未参与游戏的无效成绩，以购买该产品的时间先后顺序在排行榜进行排名 ；</li>
						<li><span class="bull">9</span> 本次活动由高和畅举办，最终解释权归高和畅所有。</li>
					</ul>
					</article>
				</section>
			</section>
			
		</section>
	</section>
	<section id="game" style="position:absolute;top:0;left:0;width:100%;height:100%;z-index:10;"></section>
	<!-- 规则 -->
	
	<!-- 游戏结果 -->
	<section id="gameoverResult">
		<h3 class="title"></h3>
		<p class="history"><span class="text"><i>历史最高</i><em id="maxScore">${maxScore}</em></span><span class="icon-small"></span></p>
		<h1 class="score"><span class="text"><em id="result">48</em></span><span class="icon-big"></span></h1>
		<a href="javascript:again();" class="btn again" name="再玩一次"></a>
		<!-- <a href="javascript:charts();" class="btn charts" name="排行榜"></a> -->
		<!-- <a href="javascript:sumbitBtn();" class="btn sumbit" name="提交"></a> -->
		<a href="javascript:invited();" class="btn invited" name="邀请"></a>
		<c:if test="${buyer==false&&submitFlag==true}"><a id="submit_btn" href="javascript:sumbitBtn(true);" class="btn sumbit" name="提交"></a></c:if>
		<%-- <p class="tips">长按二维码关注高和畅</p>
		<img src="${img}/game/ercode.png" alt="高和畅二维码"/> --%>
	</section>
	<section class="yun" id="yun">
		<img class="yun1 animated_yun infinite yun_left" src="${img}/game/cloud1.png" alt="" />
		<img class="yun2 animated_yun infinite yun_right" src="${img}/game/cloud2.png" alt="" />	
	</section>
	<section class="elephant" id="elephant">
		<img class="animated slideInRight" src="${img}/game/elephant.png" alt="" />
	</section>
	<section class="elephant_left" id="elephant_left">
		<img class="animated slideInLeft" src="${img}/game/elphant_left.png" alt="" />
	</section>
	<div id="tipPid" style="display: none" class="tip" onclick="invitedHide()" >
	      <div class="point">
	        <!-- <p><span>1</span>点击右上角图标</p>
	        <p><span>2</span>在弹出菜单中选择分享到朋友圈</p>
	        <p><span>3</span>领取金币</p> -->
	        <p>分享给我的好友！</p>
	      </div>
	</div>
	<audio id="playing" src="${img}/game/background.mp3" loop="loop" style="height:0;display:none;"></audio>
	<audio id="gameover" src="${img}/game/gameover.mp3" style="height:0;display:none;"></audio>
</body>
<%@ include file="/jsp/shared.jsp"%>
<script type="text/javascript">
	wx.ready(function () {
		wx.onMenuShareAppMessage({
			title	: '‘${union.nickname}’邀你参加【畅享杯锦标赛】',	// 分享标题
			desc	: '为城市加油，为好友助力！帮好友赢取最高20%预期年化收益率。',	// 分享描述
			link	: '${lctx}/wap/game/index?id=${id}${shareSn}',	// 分享链接
			imgUrl	: '${lctx}/images/game/house.png',	// 分享图标
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
			title	: '‘${union.nickname}’邀你参加【畅享杯锦标赛】', // 分享标题
			link	: '${lctx}/wap/game/index?id=${id}${shareSn}', // 分享链接
			imgUrl	: '${lctx}/images/game/house.png', // 分享图标
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