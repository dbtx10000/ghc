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
	<script type="text/javascript" src="${js}/jquery.js"></script>
	<script type="text/javascript" src="${js}/jquery.form.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
    <script type="text/javascript">
    	function save(){
    		$.LD.ajax({
       			url : '${ctx}/wap/riskEvaluation/riskEvaluation?openid=${openid}&score=${score}',
       			success : function(response) {
       				if (response.result == 1) {
       					location.href = '${ctx}/wap/user/center?openid=${openid}';
       				}else{
							$.pop.hint({
	      							text : '系统错误,请重试!',
	     							call : function() {
	      								 
	      								}
   								});
       					return ;
       				}
       			}
       		});
    	}
    </script>
</head>
<body>
	<section class="evalue_finish">
		<div class="evalue_scroe">您的抗风险指数<p class="score">${score * 2}</p></div>
		<div class="result_type">
			<c:choose>
				<c:when test="${13<=score&&score<=20}">
					保守型
				</c:when>
				<c:when test="${21<=score&&score<=29}">
					稳健型
				</c:when>
				<c:when test="${30<=score&&score<=39}">
					平衡型
				</c:when>
				<c:when test="${40<=score&&score<=49}">
					进取型
				</c:when>
				<c:when test="${50<=score&&score<=58}">
					激进型
				</c:when>
				<c:otherwise>
					<p class="time orange">最新测评时间：无</p>
				</c:otherwise>
			</c:choose>
		</div>
		<p class="tips">提示：</p>
		<p class="tips">1、本测试自完成之日起1年内可作为有效参考，超过有效期如需进行交易必须重新测试。</p>
		<p class="tips">2、投资人在产品购买过程中，应注意核对风险承受能力和产品风险的匹配情况。</p>
	</section>
	<a class="login redBg"  href="javascript:save();">确定</a>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>