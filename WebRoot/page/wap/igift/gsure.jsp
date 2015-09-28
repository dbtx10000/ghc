<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>${snm}<c:if test="${!need_head}"> - 确认订单</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_gift_1.0.css" />
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<style>
.count li{border-bottom:1px solid #e4e4e4;}
</style>
<script type="text/javascript">
	function order() {
		$.ios.ajax({
			url : '${ctx}/wap/igift/order?openid=${openid}',
			msg : {
				text : '正在换购', succ : '换购成功',
				fail : '换购失败', warn : '系统繁忙'
			},
			data : {
				giftId : '${gift.id}',
				nums : '${nums}',
				note : '${note}',
				address : '${address}'
			},
			success : function(response) {
				return {
					'flag' : response.result == 1 ? true : null,
					'call' : function(flag) {
						if (flag) {
							location.href = '${ctx}/wap/user/giftmy?openid=${openid}';
						} else {
							$.pop.tips(response.message);
						}
					}
				};
			}
		});
	}
</script>
</head>

<body>
<c:if test="${need_head}">
	<header>
		确认订单
	    <a class="back" href="javascript:history.go(-1);"></a>
	</header>
</c:if>
<section>
    <article class="detailMsg">
        <p><span class="name">${user.realname}</span><span class="tel">${user.mobile}</span></p>
        <p class="address">收货地址：${address}</p>
    </article>
    <ul class="count">
        <li>礼品名称<span>${gift.name}</span></li>
        <li>换购数量<span>${nums}</span></li>
        <li style="margin-top:0;border-bottom:none;">换购金币<span>${gift.integral * nums}金币</span></li>
    </ul>
</section>
<footer class="changBtn">
    <a class="redBg" href="javascript:order();">确认</a>
</footer>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
