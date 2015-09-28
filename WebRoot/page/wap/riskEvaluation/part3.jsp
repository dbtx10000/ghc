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
		<h3>我已完成<span>40%</span></h3>
		<p class="progress borderR10"><span class="borderR10 wp40"></span></p>
	</article>
	<section class="content" id="questList">
		<h2 id="title"></h2>
	</section>
	<footer>
		<a class="login redBg"  href="javascript:submitScore('${ctx}/wap/riskEvaluation/part4?openid=${openid}',${score});">下一步</a>
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
			var title="投资策略";
			var option=[
				{	
					'sort':9,
					'question':'您预期的投资期限是？',
					'answer':[
						'6个月以内',
						'6个月-1年',
						'1-3年',
						'3年以上',
					],
				},
				{	
					'sort':10,
					'question':'您期望的投资年化收益率是？',
					'answer':[
						'高于同期定期存款',
						'5%左右，风险相对较低',
						'5%--15%，愿意承受中等风险',
						'15%以上，可以承担较高风险',
					],
				},
				{	
					'sort':11,
					'question':'您的投资目的？',
					'answer':[
						'确保资产安全性，同时获得固定收益',
						'希望投资能获得一定的增值，同时获得波动适度的年回报',
						'倾向于长期的成长，较少关心短期的回报和波动',
						'只关心长期的高回报，能够接受短期的资产价值波动',
					],
				},
			];
		questionHtml(option,title);
	});
</script>
<%@ include file="/jsp/shield.jsp"%>
</html>