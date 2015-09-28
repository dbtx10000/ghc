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
<meta name="author" content="zalon" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>${snm}<c:if test="${!need_head}"> - 我的账户</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/goHigh_beta1.0.css" />
<link type="text/css" rel="stylesheet" href="${css}/mine.css" />
<style>
footer.menu{ background:#f9f9f9;}
footer.menu ul li{ border:0px;background:#f9f9f9;}
</style>
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script type="text/javascript">
	$(function () {
		var inv1_readed = '${inv1_readed}';
		var inv2_readed = '${inv2_readed}';
		var inv3_readed = '${inv3_readed}';
		
		if(inv1_readed!=1) {
			$("#inv1").attr("class","nub gray");
		}
		if(inv2_readed!=1) {
			$("#inv2").attr("class","nub gray");
		}
		if(inv3_readed!=1) {
			$("#inv3").attr("class","nub gray");
		}
	});
	function logout() {
		$.ios.ajax({
			url : '${ctx}/wap/user/logout?openid=${openid}',
			msg : { 
				text : '正在退出', succ : '退出成功',
				fail : '退出失败', warn : '系统繁忙'
			},
			success : function(response) {
				return {
					flag : response.result == 1,
					call : function(flag) {
						if (flag) {
							location.href = '${ctx}/wap/index?openid=${openid}';
						}
					}
				};
			}
		});
	}
	function manage() {
		var payTxt = payUrl = touchsTxt = touchsUrl = '';
		if ('${object.payPassword}'.isEmpty()) {
			payTxt = '设置';
			payUrl = '${ctx}/wap/user/payset/1?openid=${openid}';
		} else {
			payTxt = '重置';
			payUrl = '${ctx}/wap/user/payset/2?openid=${openid}';
		}
		var list = [
			{ 
				'note' : '请选择操作类型'
			},
			{
				'text' : '修改登录密码',
				'call' : function() {
					location.href = '${ctx}/wap/user/repswd?openid=${openid}';
				}
			},
			{
				'text' : payTxt + '支付密码',
				'call' : function() {
					location.href = payUrl;
				}
			},
		];
		if ('${from_micr}' == 'true') {
			if ('${object.touchsPassword}'.isEmpty()) {
				touchsTxt = '设置';
				touchsUrl = '${ctx}/wap/user/stpswd?openid=${openid}';
			} else {
				touchsTxt = '修改';
				touchsUrl = '${ctx}/wap/user/rtpswd?openid=${openid}';
			}
			list.push({
				'text' : touchsTxt + '手势密码',
				'call' : function() {
					location.href = touchsUrl;
				}
			});
		}
		$.pop.pull(list);
	}
</script>
</head>
<body>
<c:if test="${need_head}">
	<header>
		我的账户
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<section class="user">
   <div class="my">
   		<a href="${ctx}/wap/user/update?openid=${openid}">
   			<c:if test="${union == null}">
        		<img src="${img}/pic_default.png" />
   			</c:if>
   			<c:if test="${union != null}">
        		<img src="${union.headimgurl}" />
   			</c:if>
            <h3>${object.realname}</h3>
            <p>${object.mobile}</p>
        </a>
   </div>
   <div class="yields">
   		<p><c:if test="${time != null}"><span>从${time}开始</span></c:if>我的累计总收益</p>
        <h2><fmt:formatNumber value="${gsum}" pattern="0.00" /><span>元</span></h2>
   </div>
   <div class="asset">
   		<p>我的总资产</p>
        <h3>${isum}<span>元</span></h3>
   </div>
   <div class="link">
        <p>我的产品</p>
        <ul>
            <li><a class="get" href="${ctx}/wap/user/invest/2?openid=${openid}"><span></span>持有中<c:if test="${inv2 > 0}"><span id="inv2" class="nub red">${inv2}</span></c:if></a></li>
            <li><a class="ing" href="${ctx}/wap/user/invest/1?openid=${openid}"><span></span>申请中<c:if test="${inv1 > 0}"><span id="inv1" class="nub red">${inv1}</span></c:if></a></li>
            <li><a class="end" href="${ctx}/wap/user/invest/3?openid=${openid}"><span></span>已结束<c:if test="${inv3 > 0}"><span id="inv3" class="nub red">${inv3}</span></c:if></a></li>
       </ul>
   </div>
   <div class="link">
        <p>我的高和畅</p>
        <ul class="linkul">
            <li><a class="card" href="${ctx}/wap/user/mycard?openid=${openid}"><span></span>银行卡</a></li>
            <li><a class="coin" href="${ctx}/wap/user/goldmy?openid=${openid}"><span></span>金币</a></li>
            <li><a class="gift" href="${ctx}/wap/user/giftmy?openid=${openid}"><span></span>礼品</a></li>
            <li><a class="prize" href="${ctx}/wap/user/awards?openid=${openid}"><span></span>奖品</a></li>
       </ul>
   </div>
   <div class="listLink">
   		<ul>
        	<li><a class="text" href="${ctx}/wap/user/tester?openid=${openid}"><span></span>我的测评<label style="float: right; margin-right: 40px; font-size: 14px;">${risk.result}</label></a></li>
            <li><a class="help" href="${ctx}/wap/user/helper?openid=${openid}"><span></span>我的助手</a></li>          
        </ul>
        <ul>
        	<li><a class="friend" href="${ctx}/wap/user/invite?openid=${openid}"><span></span>邀请好友</a></li>
            <li><a class="password" href="javascript:manage();"><span></span>密码管理</a></li>          
        </ul>
   </div>
    <a id="login" class="login redBg" style="margin-bottom: 60px; margin-top: -50px;" href="javascript:logout();">退出登录</a>
</section>
<footer class="menu">
	<ul>
    	<li><a class="product" href="${ctx}/wap/index">产品</a></li>
        <li><a class="accountSel" href="javascript:;">账户</a></li>
    </ul>
</footer>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>