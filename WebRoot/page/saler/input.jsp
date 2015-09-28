<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
<script type="text/javascript" src="${js}/LD.sot/multiupf/init.js?ver=2"></script>
    <script type="text/javascript">
    	$(document).ready(function() {
    		initValid();
    	});
    	
    	function initValid() {
    		var $inputs = $("input");
    		$inputs.focus(function() {
    			$(this).parent().parent().find(".tip").html("*");
    		}).blur(function() {
    			valid($(this),otherValid);
    		});
    	}
    	
    	
    	function formValid() {
    		return validThese($(":text"),otherValid);
    	}
    	
    	
    	function otherValid($input) {
    		var result = true;
    		return result;
    	}
    </script>
       	<style type="text/css">
       	body { 
			background: #fff; 
		}

   		.imager {
			margin: 0;
			padding: 0;
			width: 160px;
			height: 100px;
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
  	<form id="save_form" action="${ctx}/saler/save" method="post">
    	<input type="hidden" id="id" name="id" value="${object.id }" />
    	<div id="content">
	    	<div class="data">
	    		<div class="form">
    				<div class="item h43">
	    				<div class="fir">姓名：</div>
	    				<div class="ipt">
	    					<input type="text" class="w260" id="realname" name="realname" maxlength="20"
	    						value="${object.realname}" placeholder="请输入姓名"/>
	    				</div>
	    				<div class="tip">*</div>
	    			</div>
    				
		  		    <div class="item h43">
	    				<div class="fir">手机号码：</div>
	    				<div class="ipt">
	    					<input type="text" class="w260" id="mobile" name="mobile" maxlength="20"
	    						value="${object.mobile}" placeholder="请输入手机号码"/>
	    				</div>
	    				<div class="tip">*</div>
	    			</div>
	    			
	    		</div>
	    	</div>
	    	<div class="pBtn">
	    		<a class="save orangeBg" href="javascript:lhgSave();">保&nbsp;&nbsp;存</a>
	    		<a class="back grayBg" href="javascript:lhgBack()">返&nbsp;&nbsp;回</a>
	    	</div>
    	</div>

    </form>
  </body>
</html>
