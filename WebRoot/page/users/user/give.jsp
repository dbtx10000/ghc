<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<script type="text/javascript" src="${js}/LD.sot/multiupf/init.js?skin=image"></script>
<script type="text/javascript">
	$(document).ready(function() {
		initValid();
	});
	function initValid() {
		$(":text").focus(function() {
			$(this).parent().parent().find(".tip").html("*");
		}).blur(function() {
			valid($(this));
		});
	}
	function formValid() {
		if(!$("#integral").val().isPositive()||$("#integral").val()==0) {
   			alert('金币数必须是正数');
   			return false;
   		}
		return validThese($(":text"));
	}
</script>
<style type="text/css">
body { 
	background: #fff; 
}
.imager {
	margin: 0;
	padding: 0;
	width: 83px;
	height: 83px;
	float: left;
	background-color: #fff;
	text-align: center;
	vertical-align: middle;
	line-height: 81px;
	color: #000;
}
.upload {
	margin: 0;
	padding: 0;
	width: 83px;
	height: 31px;
	float: left;
	margin-left: 18px;
	margin-top: 52px;
}
</style>
</head>

<body>
	<form id="save_form" action="${ctx}/users/user/give/save" method="post">
		<input type="hidden" id="id" name="id" value="${object.id}" /> 
		<div id="content-lhg">
			<div class="item h30">
				<div class="fir">用户姓名：</div>
				<div class="ipt">
					${object.realname}
				</div>
			</div>
			
			<div class="item h30">
				<div class="fir">赠送金币：</div>
				<div class="ipt">
					<input type="text" class="w120" maxlength="50"
						id="integral" name="integral"  value="" 
						placeholder="请输入赠送金币数" />
				</div>
				<div class="tip">*</div>
			</div>
			
			<div class="popBtn">
				<a class="save greenBg" href="javascript:lhgSave()">保 存</a> 
				<a class="back grayBg" href="javascript:lhgBack()">返 回</a>
			</div>
		</div>
	</form>
</body>
</html>
