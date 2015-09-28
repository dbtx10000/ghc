<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
<meta http-equiv="x-dns-prefetch-control" content="on" />
<style>
* {
	margin: 0;
	padding: 0;
}

body {
	font-family: serif;
	background: #e1e0dd;
}

.pay {
	background: #e2e2e2 url(${img}/payment.png) 7px center no-repeat;
	font-size: 20px;
	color: #47aa08;
	line-height: 50px;
	height: 50px;
	display: block;
	text-indent: 45px;
	border-bottom: 2px #ccc solid;
	background-position-x: 10px;
	position:relative;
}

.finish{
	position: absolute;
	top: 12px;
	right: 10px;
	width: 50px;
	height: 27px;
	line-height: 28px;
	font-size: 15px;
	background: #47aa08;
	text-align: center;
	text-indent: 0;
	text-decoration: none;
	color: #fff;
	border-radius: 4px 4px;
	-webkit-border-radius: 4px 4px;
	-moz-border-radius: 4px 4px;
	-o-border-radius: 4px 4px;
	-ms-border-radius: 4px 4px;
	display: block;
}

.title {
	clear:both;
	background: #fff;
	font-size: 24px;
	text-align: center;
	line-height: 70px;
	border-bottom: 1px #e4e4e4 solid;
}

.content {
	padding: 10px;
	background-color: #FFFFFF;
	border-bottom: 1px #e4e4e4 solid;
	font-size: 15px
}

.content ul li {
	line-height: 30px;
	list-style: none;
	color: #7d7d7d
}

.content ul li span {
	color: #000;
}

.content ul li span.num {
	font-size: 15px
}

.money {
	padding: 0 10px;
	line-height: 50px;
	text-align: right;
	font-size: 40px;
	font-weight: bolder;
	border-bottom: 1px #e4e4e4 dashed;
	background: #fff;
	color: #131313;
}
.mH2{font-size:24px;}
.mH4{font-size:20px}
</style>
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script type="text/javascript">
	function jackpot() {
		location.href = '${ctx}/wap/user/center?openid=${openid}';
		/*
		if ('${jackpot}' == '1') {
			$.pop.chio({
				text : '支付成功',
				note : '恭喜你,获得一次抽奖的机会,是否马上去抽奖?',
				left : {
					text : '否',
					call : function() {
						location.href = '${ctx}/wap/user/center?openid=${openid}';
					}
				},
				rite : {
					text : '是',
					call : function() {
						location.href = '${ctx}/wap/jackpot/index?openid=${openid}&productId=${object.product.id}';
					}
				}
			});
		} else {
			location.href = '${ctx}/wap/user/center?openid=${openid}';
		}
		*/
	}
</script>

</head>

<body>
	<section class="all">
		<h3 class="pay">支付成功<a class="finish" href="javascript:jackpot();">完成</a></h3>
		<h3 class="title">高和畅</h3>
		<article class="content">
			<ul>
				<li>交易内容：<span class="num">高和畅产品投资</span></li>
				<li>交易产品：<span class="num">${object.product.name}</span></li>
				<li>交易单号：<span class="num">${object.id}</span></li>
				<li>交易时间：<span><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${object.payTime}"/></span></li>
				<li>银行类型：<span><script>
					switch ('${object.openBankId}') {
						case '0100' : document.write('邮储银行'); break;
						case '0102' : document.write('中国工商银行'); break;
						case '0103' : document.write('中国农业银行'); break;
						case '0104' : document.write('中国银行'); break;
						case '0105' : document.write('中国建设银行'); break;
						case '0301' : document.write('交通银行'); break;
						case '0302' : document.write('中信银行'); break;
						case '0303' : document.write('中国光大银行'); break;
						case '0305' : document.write('中国民生银行'); break;
						case '0306' : document.write('广东发展银行'); break;
						case '0307' : document.write('深发展银行'); break;
						case '0308' : document.write('招商银行'); break;
						case '0309' : document.write('兴业银行'); break;
						case '0410' : document.write('中国平安银行'); break;
					}
				</script></span></li>
				<li>当前状态：<span>支付成功</span></li>
			</ul>
		</article>
		<%-- <h2 class="money">￥<fmt:formatNumber pattern="0.00" value="${object.investMoney * 10000}"/></h2> --%>
		<h2 class="money mH2"><span>认购金额：</span>￥<fmt:formatNumber pattern="0.00" value="${object.investMoney}"/></h2>
		<h4 class="money mH4"><span>支付金额：</span>￥<fmt:formatNumber pattern="0.00" value="${object.investMoney - object.useIntegral - object.cashMoney}"/></h4>
	</section>

</body>
<%@ include file="/jsp/shield.jsp"%>
</html>

