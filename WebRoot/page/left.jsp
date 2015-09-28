<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" ></meta>
<title></title>
<link type="text/css" rel="stylesheet" href="${css}/index.css"></link>
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/menu.js"></script>
<style>
body { background: #141d25; }
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("li").each(function(){
			$(this).bind("click",function(event){
				$(".select").removeClass("select");
				$(this).addClass("select");
				event.stopPropagation();
			});
		});
	});
	function go(url) {
		$.ajax({
			url : '${ctx}/power',
			error : function() { window.top.location.href = "${ctx}/login"; },
			dataType : 'json',
			success : function(response) {
				if (response.result == 1) {
					window.open('${ctx}' + url, 'right_frame');
				} else {
					window.top.location.href = "${ctx}/login";
				}
			}
		});
	}
</script>
</head>

<body class="sidebar">
	<ul id="menu">
		<c:if test="${super_power}">
			<li class="account"> <span>用户管理</span>
				<ul>
					<li><a href="javascript:go('/users/user/init');" title="用户列表">用户列表</a></li>
					<li><a href="javascript:go('/balanceRecord/init');" title="余额记录">余额记录</a></li>
					<li><a href="javascript:go('/cardBindRecord/init');" title="银行卡记录">银行卡记录</a></li>
				</ul>
		    </li>
		    
		    <li class="account"> <span>销售管理</span>
				<ul>
					<li><a href="javascript:go('/saler/init');" title="用户列表">销售列表</a></li>
					<li><a href="javascript:go('/holiday/init');" title="假期管理">假期管理</a></li>
					<li><a href="javascript:go('/distr/init');" title="分配管理">分配管理</a></li>
				</ul>
		    </li>
		    
		    <li class="product"> <span>产品管理</span>
				<ul>
					<li><a href="javascript:go('/productType/init');" title="分类列表">分类列表</a></li>
					<li><a href="javascript:go('/product/init?type=1');" title="产品列表">产品列表</a></li>
					<li><a href="javascript:go('/order/init?productType=1');" title="订单列表">订单列表</a></li>
					<li><a href="javascript:go('/fcode/init');" title="F码列表"><font style="font-family: sans-serif;">F </font>码列表</a></li>
				</ul>
		    </li>
		    <li class="sepcial"> <span>特权本金</span>
				<ul>
					<li><a href="javascript:go('/product/specialInit?type=2');" title="产品列表">产品列表</a></li>
					<li><a href="javascript:go('/order/init?productType=2');" title="订单列表">订单列表</a></li>
				</ul>
		    </li>
		    <!-- <li class="order"> <span>订单管理</span>
				<ul>
					<li><a href="javascript:go('/order/init');" title="订单列表">订单列表</a></li>
				</ul>
		    </li> -->
		</c:if>
	    <li class="wx"> <span>微信管理</span>
			<ul>
				<li><a href="javascript:go('/wxapi/reply/init/1');" title="关注时回复">关注时回复</a></li>
				<li><a href="javascript:go('/wxapi/reply/init/2');" title="无应答回复">无应答回复</a></li>
				<li><a href="javascript:go('/wxapi/reply/init/3');" title="自定义回复">自定义回复</a></li>
				<li><a href="javascript:go('/wxapi/menus/init');" title="自定义菜单">自定义菜单</a></li>
			</ul>
	    </li>
	    <c:if test="${super_power}">
		    <li class="base"> <span>基础管理</span>
				<ul>
					<li><a href="javascript:go('/advert/init');" title="广告列表">广告列表</a></li>
					<li><a href="javascript:go('/game/init');" title="游戏列表">游戏列表</a></li>
					<li><a href="javascript:go('/article/init');" title="文章列表">文章列表</a></li>
					<li><a href="javascript:go('/questionnaire/init');" title="问卷列表">问卷列表</a></li>
					<li><a href="javascript:go('/gifts/igift/init');" title="礼品列表">礼品列表</a></li>
					<li><a href="javascript:go('/gifts/order/init');" title="订单列表">订单列表</a></li>
					<li><a href="javascript:go('/cashCoupon/init');" title="代金券列表">代金券列表</a></li>
				</ul>
		    </li>
		    <li class="jackpot"> <span>抽奖管理</span>
				<ul>
					<li><a href="javascript:go('/jackpotType/init');" title="奖池管理">奖池管理</a></li>
			    	<li><a href="javascript:go('/redPacket/init');" title="红包列表">红包列表</a></li>
			    	<li><a href="javascript:go('/award/init');" title="奖品列表">奖品列表</a></li>
			    	<li><a href="javascript:go('/winningRecord/init');" title="抽奖记录">抽奖记录</a></li>
				</ul>
		    </li>
		    <li class="signin"> <span>签到管理</span>
				<ul>
					<li><a href="javascript:go('/signinRecord/init');" title="签到记录">签到记录</a></li>
			    	<li><a href="javascript:go('/proverb/init');" title="箴言管理">箴言管理</a></li>
				</ul>
		    </li>
		    <li class="redpack"> <span>红包管理</span>
				<ul>
					<li><a href="javascript:go('/redPackageEvent/init');" title="红包活动">红包活动</a></li>
					<li><a href="javascript:go('/redPackageRecord/init');" title="红包记录">红包记录</a></li>
				</ul>
		    </li>
	    </c:if>
		<c:if test="${super_power}">
			<li class="system"> <span>系统管理</span>
				<ul>
					<li><a href="javascript:go('/manager/init');" title="管理列表">管理列表</a></li>
					<li><a href="javascript:go('/const/edit');" title="金币配置">金币配置</a></li>
					<li><a href="javascript:go('/intro/edit');" title="邀请配置">邀请配置</a></li>
				</ul>
		    </li>
		</c:if>
	</ul>
</body>
</html>