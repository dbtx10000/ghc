<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<script type="text/javascript">
    	$(document).ready(function() {
    		initValid();
    	});
    	function initValid() {
    		var $inputs = $("#mobile,#realname");
    		$inputs.focus(function() {
    			$(this).parent().parent().find(".tip").html("*");
    		}).blur(function() {
    			valid($(this), otherValid);
    		});
    	}
    	function formValid() {
    		return validThese($("#mobile,#username"), otherValid);
    	}
    	function otherValid($input) {
    		var id = $input.attr('id'), 
    			value = $input.val(), 
    			result = true;
			if (id == 'mobile') {
				var url = '${ctx}/users/user/find';
				$.ajax({
					url : url + '?mobile=' + value + '&id=${object.id}',
					async : false,
					dataType : 'json',
					success : function(response) {
						if (response.result == 1) {
							$input.parent().parent().find(".tip").
								html("<font color='red'>该手机号已注册</a>");
							result = false;
						}
					}
				});
    		}
			return result;
    	}
    </script>
</head>

<body>
	<form id="save_form" action="${ctx}/users/user/save" method="post">
		<input type="hidden" id="id" name="id" value="${object.id}" /> 
		<div id="content">
			<div class="flag bt10"> 
				<div class="location">${empty(object.id) ? "添加用户" : "编辑用户"}</div>
				<div class="rightBtn">
					<a href="javascript:history.go(-1);">返回用户列表</a>
				</div>
			</div>
			<!-- 开始 -->
			<div class="data">
				<div class="form">
					<div class="item h43">
						<div class="fir">用户类型：</div>
						<div class="ipt">
							<span class="sel" class="w140">
								<select name="type" class="w140">
									<option value="1" ${object.type == 1 ? 'selected' : ''}>VIP用户</option>
									<option value="2" ${object.type == 2 ? 'selected' : ''}>普通用户</option>
									<option value="3" ${object.type == 3 ? 'selected' : ''}>销售人员</option>
								</select>
							</span>
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">姓名：</div>
						<div class="ipt">
							<input type="text" class="w300" id="realname"
								name="realname" maxlength="20" placeholder="请输入姓名"  
								value="${object.realname}"/>
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">手机号码：</div>
						<div class="ipt">
							<input type="text" class="w300" id="mobile" 
								name="mobile" maxlength="11" value="${object.mobile}" 
								placeholder="请输入手机号码" />
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">证件类型：</div>
						<div class="ipt">
							<span class="sel" class="w140">
								<select name="credentialsType" class="w140">
									<option value="01" ${object.credentialsType == 01 ? 'selected="seleced"' : ''}>身份证</option>
									<option value="02" ${object.credentialsType == 02 ? 'selected="seleced"' : ''}>军官证</option>
									<option value="03" ${object.credentialsType == 03 ? 'selected="seleced"' : ''}>护照</option>
									<option value="04" ${object.credentialsType == 04 ? 'selected="seleced"' : ''}>户口簿</option>
									<option value="05" ${object.credentialsType == 05 ? 'selected="seleced"' : ''}>回乡证</option>
									<option value="90" ${object.credentialsType == 90 ? 'selected="seleced"' : ''}>港澳通行证</option>
									<option value="06" ${object.credentialsType == 06 ? 'selected="seleced"' : ''}>其他</option>
								</select>
							</span>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">证件号码：</div>
						<div class="ipt">
							<input type="text" class="w300" id="credentialsCode"
								name="credentialsCode" maxlength="50" placeholder="请输入证件号码"  
								value="${object.credentialsCode}"/>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">邮箱：</div>
						<div class="ipt">
							<input type="text" class="w300" id="email"
								name="email" maxlength="50" placeholder="请输入邮箱"  
								value="${object.email}"/>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">地址：</div>
						<div class="ipt">
							<input type="text" class="w300" id="address"
								name="address" maxlength="50" placeholder="请输入地址"  
								value="${object.address}"/>
						</div>
					</div>
					<div class="item h125">
						<div class="fir">简介：</div>
						<div class="ipt">
							<textarea style="width: 360px; min-width: 360px; max-width: 360px; 
								height: 98px; min-height: 98px; max-height: 98px; line-height: normal;" 
								placeholder="请输入简介(最多可输入255个字节)" maxlength="255" 
								name="intro">${object.intro}</textarea>
						</div>
					</div>
				</div>
			</div>
			<!-- 结束 -->
			<div class="pBtn">
				<a class="save greenBg"
					href="javascript:htmSave('${ctx}/users/user/init');">保&nbsp;&nbsp;存</a>
				<a class="back grayBg" href="javascript:history.go(-1);">返&nbsp;&nbsp;回</a>
			</div>
		</div>
	</form>
</body>
</html>
