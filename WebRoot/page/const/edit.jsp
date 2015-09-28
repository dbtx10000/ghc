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
    		var $inputs = $(":text");
    		$inputs.focus(function() {
    			$(this).parent().parent().find(".valid").html("");
    		}).blur(function() {
    			valid($(this),otherValid);
    		});
    	}
    	function otherValid($input) {
    		var  value = $input.val();
			var $valid = $input.parent().parent().find(".valid");
    		var result = true;
    		if (!value.isEmpty()&&!value.isPositive()) {
				$valid.html("<font color='red'>必须是正整数</font>");
				return false;
			}
    		return result;
    	}
    	function formValid() {
    		var $inputs=$(":text");
    		for (var i = 0; i < $inputs.length; i++) {
    			if($($inputs[i]).val().isEmpty()){
    				return true;
    			}else{
	    			if (!valid($($inputs[i]), otherValid)) {
						return false;
					}
    			}
			}
    		return true;
    	}
    	
</script>
<style type="text/css">
   		.valid {
			  float: left;
  			  line-height: 26px;
  			  margin-left: 10px;
		}
   	</style>
</head>

<body>
	<form id="save_form" action="${ctx}/const/save" method="post">
		<input type="hidden" id="id" name="id" value="${object.id}" />
		<div id="content">
			<div class="flag bt10"> 
				<div class="location">配置管理</div>
				<div class="rightBtn">
					<a href="javascript:htmSave();">保存</a>
				</div>
			</div>
			<div class="data">
				<div class="form">
					<div class="item h43">
						<div class="fir" style="width: 84px;">本人成功注册：</div>
						<div class="ipt">
							<input type="text" class="w100" id="regisIntegral" 
								name="regisIntegral" value="${object.regisIntegral}" 
								placeholder="请输入金币" />
						</div>
						<div class="valid" ></div>
					</div>
					<div class="item h43">
						<div class="fir" style="width: 84px;">本人购买缴款：</div>
						<div class="ipt">
							<input type="text" class="w100" id="buyIntegral" 
								name="buyIntegral" value="${object.buyIntegral}" 
								placeholder="请输入金币" />
							&nbsp;&nbsp;
							限制次数：<input type="text" class="w100" id="buyIntegralLimit" 
								name="buyIntegralLimit" value="${object.buyIntegralLimit}" 
								placeholder="请输入限制" /> (为空时不限制)
						</div>
						<div class="valid" ></div>
					</div>
					<div class="item h43">
						<div class="fir" style="width: 84px;">邀请他人注册：</div>
						<div class="ipt">
							<input type="text" class="w100" id="inviteIntegral" 
								name="inviteIntegral" value="${object.inviteIntegral}" 
								placeholder="请输入金币" /> 
							&nbsp;&nbsp;
							限制次数：<input type="text" class="w100" id="inviteIntegralLimit" 
								name="inviteIntegralLimit" value="${object.inviteIntegralLimit}" 
								placeholder="请输入限制" /> (为空时不限制)
						</div>
						<div class="valid" ></div>
					</div>
					<div class="item h43">
						<div class="fir" style="width: 84px;">邀请购买缴款：</div>
						<div class="ipt">
							<input type="text" class="w100" id="inviteBuyIntegral" 
								name="inviteBuyIntegral" value="${object.inviteBuyIntegral}" 
								placeholder="请输入金币" />
							&nbsp;&nbsp;
							限制次数：<input type="text" class="w100" id="inviteBuyIntegralLimit" 
								name="inviteBuyIntegralLimit" value="${object.inviteBuyIntegralLimit}" 
								placeholder="请输入限制" /> (为空时不限制)
						</div>
						<div class="valid" ></div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>
