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
   			var userName = '${object.order.userName}';
   			userName = unescape(userName.replace(/\\/gi, '%'));
   			$("#userName").val(userName);
    		$(":text").not("#cardNo").not("#certId").not("#userName").focus(function() {
    			$(this).parent().parent().find(".tip").html("*");
    		}).blur(function() {
    			valid($(this),otherValid);
    		});
    	});
    	function formValid() {
    		return validThese($(":text").not("#cardNo").not("#certId").not("#userName"),otherValid);
    	}
    	function otherValid($input) {
    		var id = $input.attr('id'), value = $input.val();
    		var $fir = $input.parent().parent().find(".fir");
			var fir = $fir.html().substring(0, $fir.html().length - 1);
			var $tip = $input.parent().parent().find(".tip");
    		var result = true;
			if(id=='investMoney'){
				if (!value.isPositive()) {
					$tip.html("<font color='red'>" + fir + "格式不正确</font>");
					result = false;
				}
				if(value!=null&&value!=''&&value=='0'){
					$tip.html("<font color='red'>" + fir + "不能为0</font>");
					result = false;
				}
			}
    		return result;
    	}
    </script>
</head>
<style>
body {
	background: #fff;
}
</style>
<body>
	<form id="save_form" action="${ctx}/users/user/invest/save" method="post">
	<input type="hidden" id="id" name="id" value="${object.id}" />
	<input type="hidden" id="userId" name="userId" value="${user.id}" />
		<div id="content-lhg">
			<div class="item h30">
				<div class="fir">用户姓名：</div>
				<div class="ipt" style="width: 300px;">
					${user.realname}
				</div>
			</div>
			<div class="item h30">
				<div class="fir">手机号码：</div>
				<div class="ipt" style="width: 300px;">
					${user.mobile}
				</div>
			</div>
			<div class="item h30">
				<div class="fir">投资产品：</div>
				<div class="ipt">
					<span class="sel"> 
						<select id="productId" name="productId" class="w140">
							<c:forEach var="product" items="${products}">
								<option value="${product.id}" ${object.productId == 
									product.id ? 'selected' : ''}>${product.name}</option>
							</c:forEach>
						</select> 
					</span>
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
				<div class="fir">投资金额：</div>
				<div class="ipt">
					<input type="text" class="w135" id="investMoney" 
						name="investMoney" value="${object.investMoney}" 
						placeholder="请输入投资金额" />&nbsp;&nbsp;元
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
				<div class="fir">投资时间：</div>
				<div class="ipt">
					<input type="text" class="w135" id="investTime" name="investTime"
						placeholder="请输入投资时间" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})"
						value='<fmt:formatDate value="${object.investTime}" pattern="yyyy-MM-dd HH:mm:ss" />' />
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
				<div class="fir">投资状态：</div>
				<div class="ipt">
					<span class="sel"> 
						<select id="status" name="status" class="w140">
							<option value="1" ${object.status == 1 ? 'selected' : ''}>申请中</option>
							<option value="2" ${object.status == 2 ? 'selected' : ''}>持有中</option>
							<option value="3" ${object.status == 3 ? 'selected' : ''}>已结束</option>
						</select> 
					</span>
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
				<div class="fir">银行卡号：</div>
				<div class="ipt">
					<input type="text" class="w300" id="cardNo" 
						name="order.cardNo" value="${object.order.cardNo}" 
						placeholder="请输入银行卡号" />
				</div>
			</div>
			<div class="item h30">
				<div class="fir">开户行：</div>
				<div class="ipt">
					<span class="sel"> 
						<select id="openBankId" name="order.openBankId" class="w140">
							<option ${object.order.openBankId == '0000' ? 'selected' : ''} value="0000">请选择开户行</option>
			        		<option ${object.order.openBankId == '0100' ? 'selected' : ''} value="0100">邮储银行</option>
			        		<option ${object.order.openBankId == '0102' ? 'selected' : ''} value="0102">中国工商银行</option>
			        		<option ${object.order.openBankId == '0103' ? 'selected' : ''} value="0103">中国农业银行</option>
			        		<option ${object.order.openBankId == '0104' ? 'selected' : ''} value="0104">中国银行</option>
			        		<option ${object.order.openBankId == '0105' ? 'selected' : ''} value="0105">中国建设银行</option>
			        		<option ${object.order.openBankId == '0301' ? 'selected' : ''} value="0301">交通银行</option>
			        		<option ${object.order.openBankId == '0302' ? 'selected' : ''} value="0302">中信银行</option>
			        		<option ${object.order.openBankId == '0303' ? 'selected' : ''} value="0303">中国光大银行</option>
			        		<option ${object.order.openBankId == '0305' ? 'selected' : ''} value="0305">中国民生银行</option>
			        		<option ${object.order.openBankId == '0306' ? 'selected' : ''} value="0306">广东发展银行</option>
			        		<option ${object.order.openBankId == '0307' ? 'selected' : ''} value="0307">深发展银行</option>
			        		<option ${object.order.openBankId == '0308' ? 'selected' : ''} value="0308">招商银行</option>
			        		<option ${object.order.openBankId == '0309' ? 'selected' : ''} value="0309">兴业银行</option>
			        		<option ${object.order.openBankId == '0410' ? 'selected' : ''} value="0410">中国平安银行</option>

			        		<option ${object.order.openBankId == '9000' ? 'selected' : ''} value="9000">浦发银行</option>
			        		<option ${object.order.openBankId == '9001' ? 'selected' : ''} value="9001">北京银行</option>
			        		<option ${object.order.openBankId == '9002' ? 'selected' : ''} value="9002">杭州银行</option>
			        		<option ${object.order.openBankId == '9003' ? 'selected' : ''} value="9003">华夏银行</option>
			        		<option ${object.order.openBankId == '9004' ? 'selected' : ''} value="9004">上海银行</option>
			        		<option ${object.order.openBankId == '9005' ? 'selected' : ''} value="9005">城市商业银行</option>
						</select> 
					</span>
				</div>
			</div>
			<div class="item h30">
				<div class="fir">持卡人：</div>
				<div class="ipt">
					<input type="text" class="w135" id="userName" 
						name="order.userName" value="${object.order.userName}" 
						placeholder="请输入持卡人姓名" />
				</div>
			</div>
			<div class="item h30">
				<div class="fir">证件类型：</div>
				<div class="ipt">
					<span class="sel"> 
						<select id="certType" name="order.certType" class="w140">
							<option ${object.order.certType == '00' ? 'selected' : ''} value="00">请选择证件类型</option>
			        		<option ${object.order.certType == '01' ? 'selected' : ''} value="01">身份证</option>
			        		<option ${object.order.certType == '02' ? 'selected' : ''} value="02">军官证</option>
			        		<option ${object.order.certType == '03' ? 'selected' : ''} value="03">护照</option>
			        		<option ${object.order.certType == '04' ? 'selected' : ''} value="04">户口簿</option>
			        		<option ${object.order.certType == '05' ? 'selected' : ''} value="05">回乡证</option>
			        		<option ${object.order.certType == '06' ? 'selected' : ''} value="06">其他</option>
						</select>
					</span>
				</div>
			</div>
			<div class="item h30">
				<div class="fir">证件号码：</div>
				<div class="ipt">
					<input type="text" class="w300" id="certId" 
						name="order.certId" value="${object.order.certId}" 
						placeholder="请输入证件号码" />
				</div>
			</div>
			<div class="popBtn">
				<a class="save orangeBg" href="javascript:lhgSave()">保 存</a> 
				<a class="back grayBg" href="javascript:lhgBack()">返 回</a>
			</div>
		</div>
	</form>
</body>
</html>
