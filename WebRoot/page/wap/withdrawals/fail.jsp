<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
  <meta name="apple-mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-status-bar-style" content="black" />
  <meta name="format-detection" content="telephone=no" />
  <meta name="version" content="goHigh  2015">
  <meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
  <meta http-equiv="x-dns-prefetch-control" content="on" />
<title>提现失败</title>
<link type="text/css" rel="stylesheet" href="${css }/balance.css" />
</head>

<body>
  <c:if test="${need_head}">
	    <header>
	      提现失败
	      <a href="javascript:history.go(-1);" class="back">返回</a>
	    </header>
    </c:if>
  <section class="suc fault">
    <p class="tip faultip">提现失败，请重试！</p> 
    <a class="confirm" href="javascript:history.go(-1)">确认返回</a>
    <div class="service">
     <p class="servicetip"><span class="wechatpic"></span>高宝宝：GHCgobaby</p>
     <p class="servicetip"><span></span>和宝宝：GHChibaby</p>
     <p class="servicetip"><span class="phonepic"></span>热线电话：<a class="phonenumb" href="tel://400-6196-805">400-6196-805</a></p>
    </div>
  </section>
</body>
</html>
