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
    </script>
</head>
<style>
body {
	background: #fff
}
</style>
<body>
	<form id="save_form" action="${ctx}/order/save" method="post">
	<input type="hidden" id="id" name="id" value="${object.id }" />
		<div id="content-lhg">
			<div class="item h30">
				<div class="fir">订单状态：</div>
				<div class="ipt">
					<span class="sel"> 
						<select id="status" name="status" class="w140">
							<option value="">请选择订单状态</option>
							<!-- <option value="-1" ${object.status == -1 ? 'selected' : ''}>等待支付</option>
							<option value="0" ${object.status == 0 ? 'selected' : ''}>支付定金</option>
							<option value="2" ${object.status == 2 ? 'selected' : ''}>已关闭</option> -->
							<option value="1" ${object.status == 1 ? 'selected' : ''}>支付成功</option>
						</select> 
					</span>
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
				<div class="fir">付款时间：</div>
				<div class="ipt">
					<input type="text" class="w135" id="payTime" name="payTime"
						value='<fmt:formatDate value="${object.payTime}" pattern="yyyy-MM-dd" />' placeholder="请输入付款时间"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
				<div class="fir">银行卡号：</div>
				<div class="ipt">
					<input type="text" class="w300" id="cardNo" 
						name="cardNo" value="${object.cardNo}" 
						placeholder="请输入银行卡号" />
				</div>
			</div>
			<div class="item h30">
				<div class="fir">开户行：</div>
				<div class="ipt">
					<span class="sel"> 
						<select id="openBankId" name="openBankId" class="w140">
							<option ${object.openBankId == '0000' ? 'selected' : ''} value="0000">请选择开户行</option>
			        		<option ${object.openBankId == '0100' ? 'selected' : ''} value="0100">邮储银行</option>
			        		<option ${object.openBankId == '0102' ? 'selected' : ''} value="0102">中国工商银行</option>
			        		<option ${object.openBankId == '0103' ? 'selected' : ''} value="0103">中国农业银行</option>
			        		<option ${object.openBankId == '0104' ? 'selected' : ''} value="0104">中国银行</option>
			        		<option ${object.openBankId == '0105' ? 'selected' : ''} value="0105">中国建设银行</option>
			        		<option ${object.openBankId == '0301' ? 'selected' : ''} value="0301">交通银行</option>
			        		<option ${object.openBankId == '0302' ? 'selected' : ''} value="0302">中信银行</option>
			        		<option ${object.openBankId == '0303' ? 'selected' : ''} value="0303">中国光大银行</option>
			        		<option ${object.openBankId == '0305' ? 'selected' : ''} value="0305">中国民生银行</option>
			        		<option ${object.openBankId == '0306' ? 'selected' : ''} value="0306">广东发展银行</option>
			        		<option ${object.openBankId == '0307' ? 'selected' : ''} value="0307">深发展银行</option>
			        		<option ${object.openBankId == '0308' ? 'selected' : ''} value="0308">招商银行</option>
			        		<option ${object.openBankId == '0309' ? 'selected' : ''} value="0309">兴业银行</option>
			        		<option ${object.openBankId == '0410' ? 'selected' : ''} value="0410">中国平安银行</option>

			        		<option ${object.openBankId == '9000' ? 'selected' : ''} value="9000">浦发银行</option>
			        		<option ${object.openBankId == '9001' ? 'selected' : ''} value="9001">北京银行</option>
			        		<option ${object.openBankId == '9002' ? 'selected' : ''} value="9002">杭州银行</option>
			        		<option ${object.openBankId == '9003' ? 'selected' : ''} value="9003">华夏银行</option>
			        		<option ${object.openBankId == '9004' ? 'selected' : ''} value="9004">上海银行</option>
			        		<option ${object.openBankId == '9005' ? 'selected' : ''} value="9005">城市商业银行</option>
						</select> 
					</span>
				</div>
			</div>
			<div class="item h30">
				<div class="fir">持卡人：</div>
				<div class="ipt">
					<input type="text" class="w135" id="userName" 
						name="userName" value="${object.userName}" 
						placeholder="请输入持卡人姓名" />
				</div>
			</div>
			<div class="item h30">
				<div class="fir">证件类型：</div>
				<div class="ipt">
					<span class="sel"> 
						<select id="certType" name="certType" class="w140">
							<option ${object.certType == '00' ? 'selected' : ''} value="00">请选择证件类型</option>
			        		<option ${object.certType == '01' ? 'selected' : ''} value="01">身份证</option>
			        		<option ${object.certType == '02' ? 'selected' : ''} value="02">军官证</option>
			        		<option ${object.certType == '03' ? 'selected' : ''} value="03">护照</option>
			        		<option ${object.certType == '04' ? 'selected' : ''} value="04">户口簿</option>
			        		<option ${object.certType == '05' ? 'selected' : ''} value="05">回乡证</option>
			        		<option ${object.certType == '06' ? 'selected' : ''} value="06">其他</option>
						</select>
					</span>
				</div>
			</div>
			<div class="item h30">
				<div class="fir">证件号码：</div>
				<div class="ipt">
					<input type="text" class="w300" id="certId" 
						name="certId" value="${object.certId}" 
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
