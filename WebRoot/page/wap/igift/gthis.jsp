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
	<title>${snm}<c:if test="${!need_head}"> - 订单提交</c:if></title>
	<link type="text/css" rel="stylesheet" href="${css}/ghc_gift_1.0.css" />
	<script type="text/javascript" src="${js}/jquery.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			setval();
			setInterval(function() {
				setval();
			}, 100);
		});
		function setval() {
			var nums = $("#nums").val();
			if (nums == '') {
				nums = 0;
			} else {
				nums = parseInt(nums);
			}
			var count = parseInt('${gift.integral}') * nums;
			$("#count").text(count);
		}
		function submit() {
			if ($("#nums").val().isEmpty()) {
				$.pop.tips('请输入换购数量');
				return;
			}
			if (parseInt($("#nums").val()) > parseInt('${nums}')) {
				$.pop.tips('换购数量不正确');
				return;
			}
			if ($("#address").val().isEmpty()) {
				$.pop.tips('请输入收货地址');
				return;
			}
			$.LD.ajax({
				url : '${ctx}/wap/igift/check?openid=${openid}&giftId=${gift.id}&nums=' + $("#nums").val(),
				success : function(response) {
					if (response.result == 1) {
						$('form').submit();
					} else {
						$.pop.tips(response.message);
					}
				}
			});
		}
	</script>
	<style type="text/css">
		ul.count li span input {
			height: 30px;
			line-height: 30px;
			border: none;
			float: right;
			text-align: right;
			font-size: 16px;
		}
	</style>
</head>

<body>
<c:if test="${need_head}">
	<header>
		订单提交
	    <a class="back" href="javascript:history.go(-1);"></a>
	</header>
</c:if>
<section class="lists">
    <ul>
        <li>
            <div class="img"><img src="${gift.smallImage}" alt=""></div>
            <div class="text">
                <p class="title overTxt">${gift.name}</p>
                <p class="detail overTxt">${gift.intro}</p>
                <p class="detail overTxt">限购：${nums}个</p>
            </div>
        </li>
    </ul>
</section>
<form action="${ctx}/wap/igift/gsure?openid=${openid}" method="post">
	<input type="hidden" name="giftId" value="${gift.id}" />
	<input type="hidden" name="userId" value="${user.id}" />
	<section>
	    <ul class="count">
	        <li>换购数量<span><input type="tel" id="nums" name="nums" placeholder="请输入换购数量" /></span></li>
	        <li style="border-top:1px solid #e4e4e4">换购金币<span><em id="count" style="font-style: normal;">0</em>金币</span></li>
	        <li><input type="text" name="note" placeholder="请输入备注内容"></li>
	    </ul>
	</section>
	<article class="address">
	    <p>收货地址</p>
	    <p class="detail"><input type="text" id="address" name="address" placeholder="请输入收货地址" value="${user.address}"></p>
	</article>
</form>
<footer class="changBtn">
    <a class="redBg" href="javascript:submit();">提交</a>
</footer>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
