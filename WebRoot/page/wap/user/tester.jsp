<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width,height=device-height, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache" />
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>我的测评</title>
<style>
*{ margin:0; padding:0;}
body{background-color:#f0f0f0; width:100%; height:100%; margin:0;}
.button{width:100%;margin-top:6%;}
@media screen and (max-width:320px){
	.button{height:400px;}
}
@media screen and (min-width: 321px) and (max-width: 375px){
	.button{height:480px;}
}
@media screen and (min-width:376px){
	.button{height:520px}
}
.button div{ width:100%;height:50%;overflow:hidden;}
.button a{margin:10% auto;width:50%;height:80%;display:block;}
.button .c1{ background:url(${img}/button_risk.png) center center no-repeat; background-size:96% auto;-webkit-tap-highlight-color: rgba(0,0,0,0);}
.button .c2{ background:url(${img}/button_questionnaire.png) center center no-repeat;background-size:96% auto;-webkit-tap-highlight-color: rgba(0,0,0,0);}
</style>
</head>

<body>
<div class="button" id="wrap">
	<p id="text"></p>
     <div>
     	<a class="c1" href="${ctx}/wap/riskEvaluation/index?openid=${openid}"></a>
     </div>
     <div>
     	<a class="c2" href="${ctx}/wap/questionnaire/gater?openid=${openid}"></a>
     </div>
</div>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
