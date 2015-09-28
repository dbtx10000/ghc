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
		<h3>我已完成<span>80%</span></h3>
		<p class="progress borderR10"><span class="borderR10 wp80"></span></p>
	</article>
	<section class="content" id="questList">
		<h2 id="title"></h2>
	</section>
	<footer>
		<a class="login redBg"  href="javascript:submitScore('${ctx}/wap/riskEvaluation/finish?openid=${openid}',${score});">下一步</a>
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
			var title="风险承受能力";
			var option=[
				{	
					'sort':13,
					'question':'您的投资出现何种程度波动时，您会呈现明显的焦虑不安？',
					'answer':[
						'本金无损失，但收益未达预期',
						'出现轻微本金损失',
						'本金10％以内的损失',
						'本金20-50％的损失',
						'本金50％以上损失'
					],
				},
			];
		questionHtml(option,title);
	});
</script>
<%@ include file="/jsp/shield.jsp"%>
</html>