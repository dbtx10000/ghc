<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta name="version" content="GoHigh v1.1 20150320">
<meta name="author" content="zalon" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>${snm}<c:if test="${!need_head}"> - 我的代金券</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<style>
section .text{ margin:0px;}
.vouchers {width:100%}
.vouchers ul{margin-top:16px;width:100%;display:block;}
.vouchers ul li{position:relative;margin:0 auto 16px auto ;width:92%;/*border:1px solid #e4e4e4;*/display:block;overflow:hidden;zoom:1;color:#888;background: -webkit-radial-gradient( transparent 0px, transparent 4px, #ebeee7 4px, #ebeee7 );background-size: 15px 20px;background-position: -10px -10px;}
.vouchers ul li:after{content: '';position: absolute;left: 5px;top: 5px;right: 5px;bottom: 5px;z-index: -1;}
.vouchers ul li p{float:left;display:block;text-align:left;}
.vouchers ul li .left{width:80px;height:82px;line-height:72px;font-size:14px;color:#fff;background: -webkit-radial-gradient( transparent 0px, transparent 4px, #feba33 4px, #feba33 );background-size: 15px 20px;background-position: -10px -10px;}
.vouchers ul li .left span{margin:4px auto;width:92%;height:90%;display:block;background:#feba33;text-align:center;}
.vouchers ul li .left em{font-size:26px;font-style:normal;}
.vouchers ul li .right{position:relative;top:0;left:0;width:72%;font-size:14px;line-height:24px;}
.vouchers ul li .right span{margin:4px auto;padding:0 10px;padding-top:4px;min-height:70px;display:block;background:#ebeee7;line-height:22px;overflow:hidden;zoom:1;}
.vouchers ul li .right span i{position:absolute;bottom:4px;right:10px;}
.vouchers ul li.used .left{background: -webkit-radial-gradient( transparent 0px, transparent 4px, #d7d7d7 4px, #d7d7d7 );background-size: 15px 20px;background-position: -10px -10px;}
.vouchers ul li.used {background: -webkit-radial-gradient( transparent 0px, transparent 4px, #f0f0f0 4px, #f0f0f0 );background-size: 15px 20px;background-position: -10px -10px;}
.vouchers ul li.used .left span{background:#d7d7d7}
.vouchers ul li.used .right span{background:#f0f0f0}
.vouchers ul li .right i{float:right;margin:0px 4px 4px 0;display:block;font-style:normal;font-size:10px;line-height:14px;border:1px solid #feba33;border-radius:5px;padding:2px 4px;color:#feba33;}
.vouchers ul li.used .right i{border:none;color:#888;}
#used{position:absolute;top:14px;right:-36px;width:120px;font-size:14px;line-height:18px;z-index:999;text-align:center;background:#d7d7d7;color:#fff;transform:rotate(45deg);-ms-transform:rotate(45deg);   /* IE 9 */-moz-transform:rotate(45deg);  /* Firefox */-webkit-transform:rotate(45deg); /* Safari 和 Chrome */-o-transform:rotate(45deg);  /* Opera */}

</style>
<script type="text/javascript">
  window.onload=function(){
    var vList=document.getElementById("vList");
    var oli=vList.getElementsByTagName("li");
    var width=oli[0].offsetWidth-80;
    for(var i=0;i<oli.length;i++){
      var oP=oli[i].getElementsByTagName("p")[1];
      oP.style.width=width+"px";
    }
  };
</script>
</head>

<body>
<c:if test="${need_head}">
	<header>
		我的代金券
  		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<section class="vouchers">
  <ul id="vList">
  	<c:forEach items="${list }" var="list">
  		<c:if test="${list.status == 1 }">
  			<li >
		      <p class="left"><span>&yen;<em>${list.money }</em></span></p>
		      <p class="right"><span>单笔投资${list.useCondition }万元及以上可抵扣${list.money }元 <br /><i class="time"><fmt:formatDate pattern="yyyy-MM-dd" value="${list.vaildEndTime }"></fmt:formatDate>到期</i></span></p>
		    </li>
  		</c:if>
  		<c:if test="${list.status != 1 }">
  			<li class="used">
		      <p class="left"><span>&yen;<em>${list.money }</em></span></p>
		      <p class="right"><span >单笔投资${list.useCondition }万元<br/>及以上可抵扣${list.money }元<br /><i class="time">使用时间:<fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${list.useTime }"></fmt:formatDate></i></span></p>
		      <span id="used">
		      	<c:if test="${list.status == 2 }">
		      		已使用
		      	</c:if>
		      	<c:if test="${list.status == 3 }">
		      		已过期
		      	</c:if>
		      </span>
		    </li>
  		</c:if>
  	</c:forEach>
  </ul>
</section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>