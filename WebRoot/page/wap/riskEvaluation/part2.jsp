<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<meta name="format-detection" content="telephone=no" />
		<meta name="version" content="GoHigh v1.1 20150320" />
		<meta name="author" content="zalon" />
		<meta http-equiv="Cache-Control" content="must-revalidate,no-cache" />
		<meta http-equiv="x-dns-prefetch-control" content="on" />
		<title>高和资本</title>
		<link type="text/css" rel="stylesheet" href="${css}/evalue.css" />
</head>
<body>
	<article>
		<h3>我已完成<span>20%</span></h3>
		<p class="progress borderR10"><span class="borderR10 wp20"></span></p>
	</article>
	<section class="content" id="questList">
		<h2 id="title"></h2>
	</section>
	<footer>
		<a class="login redBg"  href="javascript:submitScore('${ctx}/wap/riskEvaluation/part3?openid=${openid}',${score});">下一步</a>
	</footer>
</body>
<script type="text/javascript" src="${js}/jquery-1.10.2.js"></script>
<script type="text/javascript" src="${js}/chose.js"></script>
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script>
	$(function(){
			var title="投资经验";
			var option=[
				{	
					'sort':6,
					'question':'以下最能说明您投资经验的一项是？',
					'answer':[
						'我几乎不投资除存款、国债外的其他金融产品',
						'我主要投资于存款、国债等，较少投资于股票、基金等风险产品',
						'我的资产均衡配置于存款、国债、银行理财产品、信托产品、股票、基金等',
						'我的资产主要配置在股票、基金、外汇等高风险产品，较少投资于存款、国债',
					],
				},
				{	
					'sort':7,
					'question':'您在股票、基金、外汇、金融衍生产品等风险投资品的投资经验有多长？',
					'answer':[
						'没有经验',
						'少于1年',
						'2至5年',
						'6至8年',
						'8年以上'
					],
				},
				{	
					'sort':8,
					'question':'您在过去一年是否有过投资失败的经历？如有，您之前受到的最大亏损幅度是多少？',
					'answer':[
						'没有经验',
						'0%-10%',
						'10%-30%',
						'30%-60%',
						'60%以上'
					],
				},
			];
		questionHtml(option,title);
	});
</script>
<%@ include file="/jsp/shield.jsp"%>
</html>