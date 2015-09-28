<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	$(document).ready(function() {
    		$("input").focus(function() {
    			$(this).parent().parent().find(".tip").html("*");
    		}).blur(function() {
    			if ($(this).attr('id') == 'confirm') {
    				valid($(this), validPswd);
    			} else {
    				valid($(this));
    			}
    		});
    	});
    	function formValid() {
    		return valid($("#oldPswd")) && valid($("#newPswd")) 
    			&& valid($("#confirm"), validPswd);
    	}
    	function validPswd() {
    		if ($("#newPswd").val() != $("#confirm").val()) {
    			var error = "<font color='red'>两次密码不一致</font>";
				$("#confirm").parent().parent().find(".tip").html(error);
				return false;
			} else {
				return true;
			}
    	}
    	function updPswd() {
    		if (formValid()) {
    			$.LD.ajax({
	    			url : "${ctx}/manager/repswd",
	    			data : { oldPswd : $("#oldPswd").val(),
	    					newPswd : $("#newPswd").val() },
	    			success : function(response) {
	    				if (response.result == 1) {
	    					window.top.location.href = "${ctx}/login";
	    				} else if (response.result == -21) {
	    					var $tip = $("#oldPswd").parent().parent().find(".tip");
	    					$tip.html("<font color='red'>旧密码不正确</font>");
	    				}
	    			}
	    		});
    		}
    	}
    </script>
   <style type="text/css">
		 body{ background:#fff;}
		#content-lhg .item .fir {line-height:30px;}
   </style>
  </head>
  <body>
  	<div id="content-lhg">
  		<div class="item h30">
  			<div class="fir">旧密码：</div>
  			<div class="ipt">
  				<input type="password" class="w230" 
  					id="oldPswd" name="oldPswd" placeholder="请输入旧密码" />
  			</div>
  			<div class="tip">*</div>
  		</div>
  		<div class="item h30">
  			<div class="fir">新密码：</div>
  			<div class="ipt">
  				<input type="password" class="w230" 
  					id="newPswd" name="newPswd" placeholder="请输入新密码" />
  			</div>
  			<div class="tip">*</div>
  		</div>
  		<div class="item h30">
  			<div class="fir">确认密码：</div>
  			<div class="ipt">
  				<input type="password" class="w230" 
  					id="confirm" placeholder="请再次输入新密码" />
  			</div>
  			<div class="tip">*</div>
  		</div>
  		<div class="popBtn">
  			<a class="save orangeBg" href="javascript:updPswd()">保 存</a>
  			<a class="back grayBg" href="javascript:lhgBack()">返 回</a>
  		</div>
  	</div>

  </body>
</html>
