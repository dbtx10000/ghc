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
	<header>
		<p class="explain"><span></span>本测试旨在让您了解自己对投资风险的承受度和属性。以下测试是用来评估投资属性与一般风险承受度。测试结果存在不能完全呈现投资人在面对投资风险的真正态度的可能性，仅供您在投资时作为参考。</p>
	</header>
	<article>
		<h3>我已完成<span>0%</span></h3>
		<p class="progress borderR10"><span class="borderR10 wp0"></span></p>
	</article>
	<section class="content" id="questList">
		<h2 id="title"></h2>
	</section>
	<footer>
		<a class="login redBg"  href="javascript:submitScore('${ctx}/wap/riskEvaluation/part2?openid=${openid}',${score});">下一步</a>
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
			var title="基本财务状况";
			var option=[
				{	
					'sort':1,
					'question':'您的年龄（周岁）为？',
					'answer':[
						'>60岁',
						'51-60岁',
						'18-30岁',
						'31-50岁',
					],
				},
				{	
					'sort':2,
					'question':'您的家庭年收入为（¥）？',
					'answer':[
						'≤5万元',
						'6-20万元',
						'21-50万元',
						'51-100万元',
						'≥100万元'
					],
				},
				{	
					'sort':3,
					'question':'您愿意用来投资的资金占您家庭流动资产的比例为？',
					'answer':[
						'低于10%（含）',
						'10%-25%（含）',
						'25%-50%（含）',
						'50%以上',
					],
				},
				{	
					'sort':4,
					'question':'您的年总投资金额是:',
					'answer':[
						'5万以下',
						'5-20万',
						'20-50万',
						'50-100万',
						'100万以上'
					],
				},
				{	
					'sort':5,
					'question':'在您的资产中不动产的比例为?',
					'answer':[
						'大于90%',
						'89%-60%',
						'59%-20%',
						'小于20%',
						'0%'
					],
				},
			];
		questionHtml(option,title);
	});
</script>
<%@ include file="/jsp/shield.jsp"%>
</html>