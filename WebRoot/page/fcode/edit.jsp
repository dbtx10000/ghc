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
   		var $inputs = $("input");
   		$inputs.focus(function() {
   			$(this).parent().parent().find(".tip").html("*");
   		}).blur(function() {
   			valid($(this), otherValid);
   		});
   	});
   	function formValid() {
   		return validThese($("input"), otherValid);
   	}
   	function otherValid($input) {
   		var result = true;
   		if (!$("#nums").val().isPositive()) {
   			$("#nums").parent().parent().find(".tip").html("生成数格式不正确");
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
	<form id="save_form" action="${ctx}/fcode/save" method="post">
		<div id="content-lhg">
			<div class="item h30">
				<div class="fir">F码前缀：</div>
				<div class="ipt">
					<input type="text" class="w120" id="fcode" name="fcode" placeholder="请输入F码前缀" />
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
				<div class="fir">生成数量：</div>
				<div class="ipt">
					<input type="text" class="w120" id="nums" name="nums" placeholder="请输入生成数量" />
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
				<div class="fir">有效截至：</div>
				<div class="ipt">
					<input type="text" class="w120" id="endTime" name="endTime" placeholder="请输入有效期截至"
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
