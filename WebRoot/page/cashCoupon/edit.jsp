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
   		var $inputs = $(":text");
   		$inputs.focus(function() {
   			$(this).parent().parent().find(".tip").html("*");
   		}).blur(function() {
   			valid($(this), otherValid);
   		});
   	});
   	function formValid() {
   		return validThese($(":text"), otherValid);
   	}
   	function otherValid($input) {
   		var result = true;
   		if (!$("#money").val().isPositive()) {
   			$("#money").parent().parent().find(".tip").html("额度格式不正确");
   			result = false;
   		}
   		if (!$("#useCondition").val().isPositive()) {
   			$("#useCondition").parent().parent().find(".tip").html("使用条件格式不正确");
   			result = false;
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
	<form id="save_form" action="${ctx}/cashCoupon/save" method="post">
	<input type="hidden" id="userId" name="userId" value="${userId }"/>
		<div id="content-lhg">
			<div class="item h30">
				<div class="fir">额度：</div>
				<div class="ipt">
					<input type="text" class="w120" id="money" name="money" placeholder="请输入额度(元)" />
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
				<div class="fir">使用条件：</div>
				<div class="ipt">
					<input type="text" class="w120" id="useCondition" name="useCondition" placeholder="请输入使用条件(万元)" />
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
				<div class="fir">有效截至：</div>
				<div class="ipt">
					<input type="text" class="w120" id="vaildEndTime" name="vaildEndTime" placeholder="请输入有效期截至"
						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" />
				</div>
				<div class="tip">*</div>
			</div>
			<div class="popBtn">
				<a class="save orangeBg" href="javascript:lhgSave()">保 存</a> 
				<a class="back grayBg" href="javascript:lhgBack()">返 回</a>
			</div>
		</div>
	</form>
</body>
</html>
