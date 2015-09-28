<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta name="version" content="GoHigh v1.1 20150320" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache" />
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>${snm}<c:if test="${!need_head}"> - 债权转让及服务协议</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<style>
h3{text-align:center;}
h5{position:relative;font-size:15px;line-height:40px}
body{background:#f8f8f8;font-family:"KaiTi","KaiTi_GB2312";}
section{margin:0 auto;width:96%}
.about article{margin:8px auto  10px auto;padding:18px 8px 8px 8px;width:95%;background:#fff;box-shadow:0 5px 20px #000}
.about article p {margin:0 auto;font-size:12px;display:block;width:95%;}
.count {text-align:center;}
.count span{position:absolute;top:0;left:0;width:20px;}
.lCount {margin-right:10px;font-weight:bold;}
.image{margin:0 auto 10px auto;width:92%;height:auto;display:block;}
table{width:100%;border:1px solid #000;font-size:12px;border-bottom: none;}
table tr td{border-bottom:1px solid #000;border-right:1px solid #000;padding:5px 0 5px 2.5%;}
table tr td:last-child{border-right:none}
</style>
</head>

<body>
<c:if test="${need_head}">
	<header>
		债权转让及服务协议
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
${html}
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
