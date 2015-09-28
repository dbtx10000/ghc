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
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>问卷调查</title>
<link type="text/css" rel="stylesheet" href="${css}/style.css" />
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/jquery.form.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script type="text/javascript" src="${js}/zepto.min.js"></script>
<script type="text/javascript" src="${js}/questionChose.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script>
	$(function(){
		chose();
	});
</script>
</head>
<body>
	<div class="bg" style="height: 100%;"></div>
	<div class="contain">
		<header>
			<p class="explain">为了更好地了解畅友们的理财习惯和需求，并提供更合适用户的理财产品，小畅专门为您准备了几个小问题，请您耐心解答。还没有关注我们公众账号的用户可加入我们：‘Gohichang’。</p>
		</header>
		<form id="save_form" action="" method="post">
			<input type="hidden"  name="questionnaireId" value="${questionnaireId}"/>
			<input type="hidden"   id="integral" value="${integral}"/>
			<section class="content" id="questList">
				<c:forEach items="${topicList}" varStatus="status" var="topic">
					<ul id="question0" class="question borderR5">
						<input type="hidden" class="${status.index + 1}" id="topicId" value="${topic.id}"/>
						<input type="hidden" class="choose" value="${topic.choose}"/>
						<input type="hidden" class="type" value="${topic.type}"/>
						<input type="hidden" name="optionId" value=""/>
						<h4>${status.index + 1}、${topic.name}</h4>
						<c:forEach items="${topic.optionList}"  var="option">
							<li ><input type="hidden"  value="${option.id}"/><p><span class="icon_unradio"></span>${option.name}</p></li>
						</c:forEach>
					</ul>
				</c:forEach>
			</section>
		</form>
		<footer>
			<a class="login redBg"  href="javascript:submitScore();">完成</a>
		</footer>
	</div>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>