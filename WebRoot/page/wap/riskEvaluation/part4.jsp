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
		<h3>我已完成<span>60%</span></h3>
		<p class="progress borderR10"><span class="borderR10 wp60"></span></p>
	</article>
	<section class="content" id="questList">
		<h2 id="title"></h2>
	</section>
	<footer>
		<a class="login redBg"  href="javascript:submitScore('${ctx}/wap/riskEvaluation/part5?openid=${openid}',${score});">下一步</a>
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
			var title="风险偏好";
			var option=[
				{	
					'sort':12,
					'question':'请选择最符合您的投资态度的一项描述。',
					'answer':[
						'排斥风险，不希望本金损失，希望获得稳定回报',
						'保守投资，不希望本金损失，可以承担一定幅度的收益波动',
						'寻求资金的较高收益及成长性，可以为此承担有限本金损失',
						'希望赚取高回报，愿意为此承担较大本金损失',
					],
				},
			];
		questionHtml(option,title);
	});
</script>
<%@ include file="/jsp/shield.jsp"%>
</html>