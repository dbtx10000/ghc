<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<script type="text/javascript" src="${js}/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
    	$(document).ready(function() {
    		var $inputs = $("input,#status");
    		$inputs.focus(function() {
    			$(this).parent().parent().find(".tip").html("*");
    		}).blur(function() {
    			valid($(this));
    		});
    	});
    	function formValid() {
    		return validThese($("input,#status"));
    	}
    	
    	function send(id) {
        	$.LD.ajax({
	        			url : '${ctx}/distr/send?id=' + id,
	        			success : function(response) {
	        				if (response.result == 1) {
	        					getLhgParent().dptl.list(true);
								lhgBack();
	        				}
	        			}
	        	});
        }
    </script>
</head>
<style>
body {
	background: #fff
}
#content-lhg .item {
margin-top: 1px;
}
</style>
<body>
	<form id="save_form" action="${ctx}/order/save" method="post">
	<input type="hidden" id="id" name="id" value="${object.id }"/>
		<div id="content-lhg">
			
			<div class="item h20">
				<div class="fir">产品类型：</div>
				<div class="ipt">
					${object.productType}
				</div>
			</div>
			
			<div class="item h20">
				<div class="fir">产品名称：</div>
				<div class="ipt">
					${object.productName}
				</div>
			</div>
			
			<div class="item h20">
				<div class="fir">订单编号：</div>
				<div class="ipt">
					${object.order.id}
				</div>
			</div>
			
			<div class="item h20">
				<div class="fir">用户姓名：</div>
				<div class="ipt">
					${object.order.userUsername}
				</div>
			</div>
			
			<div class="item h20">
				<div class="fir">手机号：</div>
				<div class="ipt">
					${object.order.userContact}
				</div>
			</div>
			
			<div class="item h20">
				<div class="fir">付款时间：</div>
				<div class="ipt">
					<fmt:formatDate value="${object.order.payTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</div>
			</div>
			
			<div class="item h20">
				<div class="fir">起息日期：</div>
				<div class="ipt" style="width: 80px;">
					<fmt:formatDate value="${object.incomeStartTime}" pattern="yyyy-MM-dd"/>
				</div>
				
				<div class="fir" style="padding-left: 60px;">到期日期：</div>
				<div class="ipt">
					<fmt:formatDate value="${object.incomeEndTime}" pattern="yyyy-MM-dd"/>
				</div>
			</div>
			
			<div class="item h20">
				<div class="fir">返款日期：</div>
				<div class="ipt">
					<fmt:formatDate value="${object.repayTime}" pattern="yyyy-MM-dd"/>
				</div>
			</div>
			
			<div class="item h20">
				<div class="fir">投资金额：</div>
				<div class="ipt" style="width: 80px;">
					${object.investMoney}元
				</div>
				
				<div class="fir" style="padding-left: 60px;">支付金额：</div>
				<div class="ipt">
					${object.order.actualMoney}元
				</div>
			</div>
			
			
			<div class="item h20">
				<div class="fir">收益金额：</div>
				<div class="ipt" style="width: 80px;">
					${object.incomeMoney}元
				</div>
				
				<div class="fir" style="padding-left: 60px;">还款金额：</div>
				<div class="ipt">
					<fmt:formatNumber type="number" 
					value="${object.incomeMoney + object.order.actualMoney}" maxFractionDigits="2" pattern="#.##" />元
				</div>
			</div>
			
			<div class="item h20">
				<div class="fir">金币：</div>
				<div class="ipt" style="width: 80px;">
					${object.order.useIntegral}
				</div>
				
				<div class="fir" style="padding-left: 60px;">代金券：</div>
				<div class="ipt">
					${object.order.cashMoney}元
				</div>
			</div>
			
			<div class="item h20">
				<div class="fir">缴款人：</div>
				<div class="ipt">
					${object.order.userName}
				</div>
			</div>
			
			<div class="item h20">
				<div class="fir">开户银行：</div>
				<div class="ipt">
					${object.order.openBankId}
				</div>
			</div>
			
			<div class="item h20">
				<div class="fir">银行卡号：</div>
				<div class="ipt">
					${object.order.cardNo}
				</div>
			</div>
		
			<div class="popBtn" style="padding: 8px 0 0;">
				<c:if test="${type==1}">
				<a class="save orangeBg" href="javascript:send('${object.id}')">推送</a>
				<a class="back grayBg" href="javascript:lhgBack()">返&nbsp;&nbsp;回</a>
				</c:if>
			</div>
		</div>
	</form>
</body>
</html>
