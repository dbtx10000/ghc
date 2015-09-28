<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<script type="text/javascript">
    	$(document).ready(function() {
    		var $inputs = $("input");
    		if ($("#id").val().isNotBlank()) {
    			$inputs = $inputs.not("#password");
    			$("#password").attr("placeholder", "输入可修改密码");
    			$("#password").parent().parent().find(".tip").html("");
    		}
    		$inputs.focus(function() {
    			$(this).parent().parent().find(".tip").html("*");
    		}).blur(function() {
    			valid($(this), otherValid);
    		});
    	});
    	function formValid() {
    		if ($("#id").val().isEmpty()) {
    			return validThese($("input").not("#id"), otherValid);
    		} else {
    			return validThese($("input").not("#id").not("#password"), otherValid);
    		}
    	}
    	function otherValid($input) {
    		var id = $input.attr('id'), value = $input.val(), result = true;
			if (id == 'username') {
				$.ajax({
					url : '${ctx}/manager/find?key=' + value + '&type=1&id=${object.id}',
					async : false, 
					dataType : 'json',
					success : function(response) {
						if (response.result == 1) {
							$input.parent().parent().find(".tip").html("登录名已存在");
							result = false;
						}
					}
				});
    		}
			return result;
    	}
    </script>
</head>
<style>
body {
	background: #fff
}
</style>
<body>
	<form id="save_form" action="${ctx}/manager/save" method="post">
		<input type="hidden" id="id" name="id" value="${object.id}" />
		<div id="content-lhg">
			<div class="item h30">
				<div class="fir">编号：</div>
				<div class="ipt">
					<input type="text" class="w230" id="code" name="code"
						placeholder="请输入管理编号" value="${object.code}" />
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
				<div class="fir">登录名：</div>
				<div class="ipt">
					<input type="text" class="w230" id="username" name="username"
						placeholder="请输入登录名" value="${object.username}" />
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
				<div class="fir">密码：</div>
				<div class="ipt">
					<input type="password" class="w230" id="password" 
						name="password" placeholder="请输入密码" />
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
				<div class="fir">联系人：</div>
				<div class="ipt">
					<input type="text" class="w230" id="linkman" name="linkman"
						placeholder="请输入联系人" value="${object.linkman}" />
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
				<div class="fir">联系方式：</div>
				<div class="ipt">
					<input type="text" class="w230" id="telephone" name="telephone"
						placeholder="请输入联系方式" value="${object.telephone}" />
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
