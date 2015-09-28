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
<title>${snm}<c:if test="${!need_head}"> - 我的银行卡</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript">
	function bind() {
		var url = '${ctx}/wap/cnpay/sopen?openid=${openid}&redirect_uri=%s';
		location.href = url.format(location.href.encode().encode());
	}
</script>
<style>
	
body {
	font-family: serif;
	background: #e1e0dd;
}
.cardList{margin:10px auto;width:100%;display: block;background:#fff}

.cardList ul{margin:0 auto;width:92%}

.cardList ul li{cursor:pointer;width:100%;border-bottom:1px solid #e4e4e4;display:block;overflow:hidden;zoom: 1;background: #fff url("${img}/icon_more_1.png") no-repeat scroll right 13px / 44px auto;}

.cardList ul li:last-child{border:none;}

.cardList ul li .img{width:188px;height:36px; margin-top:18px; float:left;}

.cardList ul li .name{float:right;margin-right:30px; line-height:72px;font-weight: 500;}

.btn{width:100%;text-align:center; color:#fff; font-size:17px; line-height:44px; height:44px; display:block;background:#ef4023; }

.noCard{margin-top:100px;font-weight:bold;font-size:12px;text-align:center;color:#8e8e8e;}

</style>
</head>
<body>
<c:if test="${need_head}">
	<header>
		我的银行卡
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<c:if test="${cards != null}">
	<section class="cardList">
		<!-- 有银行卡   start -->
		<ul>
			<c:forEach var="card" items="${cards}">
				<li onclick="javascript:location.href='${ctx}/wap/user/detail?openid=${openid}&cardId=${card.id}'">
					<span class="img"><img src="${img}/cnpay_bank_${card.openBankId}.png"></span>
					<span class="name">尾号${fn:substring(card.cardNo, fn:length(card.cardNo) - 4, fn:length(card.cardNo))}</span>
				</li>
			</c:forEach>
		</ul>	
		<!-- 有银行卡  end -->
	</section>
</c:if>
<c:if test="${cards == null}">
	<section class="noCard">
		<!-- 没有卡  start -->
		<p>/(ㄒoㄒ)/~~您还没有绑定银行卡呦！</p>
		<!-- 没有卡  end -->
	</section>
</c:if>
<footer>
	<a class="btn" href="javascript:bind();">＋添加银行卡</a>
</footer>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>