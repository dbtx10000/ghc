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
<title>余额</title>
<link type="text/css" rel="stylesheet" href="${css}/balance.css" />
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script type="text/javascript">
var cardFlag=${cardFlag};
	function withdrawals(){
		if(cardFlag){
			$.pop.hint({
				text : '提示',
				note : '请先绑定银行卡再进行此操作!',
				call : function() {
				}
			});
			return;
		}else{
			var url = '${ctx}/wap/withdrawals/withdrawals?openid=${openid}&userId=${balance.userId}';
			location.href = url;
		}
	}

	function recharge(){
		if(cardFlag){
			$.pop.hint({
				text : '提示',
				note : '请先绑定银行卡再进行此操作!',
				call : function() {
					
				}
			});
			return;
		}else{
			var url = '${ctx}/wap/recharge/index?openid=${openid}&userId=${balance.userId}';
			location.href = url;
		}
	}
	
</script>
</head>

<body>
	<c:if test="${need_head}">
	    <header>
	      余额
	      <a href="javascript:history.go(-1);" class="back">返回</a>
	    </header>
    </c:if>
     <div class="balancenub">
   		<p>余额（元）</p>
        <h2>${balance.surplusBalance}</h2>
     </div>
     <div class="tradingrecord">
        <p class="title">交易记录</p>
        <c:forEach var="record" items="${recordList}">
	        <ul class="trading">
	          <li>
	            <p class="name">
		            <c:if test="${record.type==1}">充值</c:if>
		            <c:if test="${record.type==2}">提现</c:if>
		            <c:if test="${record.type==3}">收益返还</c:if>
		            <c:if test="${record.type==4}">本金返还</c:if>
		            <c:if test="${record.type==5}">产品购买</c:if>
	            </p>
	            <p class="source">${record.note}</p>
	          </li>
	          <li>
	            <p class="time"><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${record.createTime}"/></p>
	            <p class="sum gray"><c:if test="${record.type==1||record.type==3||record.type==4}">+</c:if>
	            <c:if test="${record.type==2||record.type==5}">-</c:if>
	            ${record.money}</p>
	          </li>
	        </ul>  
        </c:forEach>
     </div>
      
     <ul class="button">
       <li><a class="cash" href="javascript:withdrawals();">提现</a></li>
       <li><a class="recharge" href="javascript:recharge();">充值</a></li>
     </ul>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
