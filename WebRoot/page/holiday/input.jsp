<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<script type="text/javascript" src="${js}/kindeditor/kindeditor.js"></script>
<script type="text/javascript" src="${js}/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${js}/LD.sot/multiupf/init.js?ver=2"></script>
<script type="text/javascript">
	$(document).ready(function() {
   		 initValid();
   	});
	function formValid() {
		var $inputs = $(":text");
   		return validThese($inputs,otherValid);
   	}
	function initValid() {
		var $inputs = $(":text");
		$inputs.focus(function() {
			$(this).parent().parent().parent().find(".tip").html("*");
		}).blur(function() {
			valid($(this),otherValid);
		});
	}
	function otherValid($input) {
   		return true;
   	}
</script>
<style>
	body { background: #fff;}
</style>
</head>

<body>
 	<form id="save_form" action="${ctx}/holiday/save" method="post">
    	<input type="hidden" id="id" name="id" value="${object.id}" />
    	<div id="content">
			<!-- 开始 -->
			<div class="data">
				<div class="form">
				
	    			<div class="item h43" >
	    				<div class="fir">假期名称：</div>
	    				<div class="ipt">
	    					<input type="text" class="w150" id="name" name="name"
								value="${object.name}"  placeholder="请输入名称" />
	    				</div>
	    				<div class="tip">*</div>
	    			</div>
	    			
	    			<div class="item h43" >
						<div class="fir">假期时间：</div>
	    				<div class="ipt">
	    					<input type="text" style="width: 135px;" id="startTime" name="startTime" maxlength="20"
	    						value='<fmt:formatDate pattern='yyyy-MM-dd' value="${object.startTime}"/>' placeholder="请输入开始时间" 
	    						onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd',readOnly:true})"/>
	    						<span>至</span>
	    					<input type="text" style="width: 135px;" id="endTime" name="endTime" maxlength="20"
	    						value='<fmt:formatDate pattern='yyyy-MM-dd' value="${object.endTime}"/>' placeholder="请输入结束时间" 
	    						onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',dateFmt:'yyyy-MM-dd',readOnly:true})"/>
	    				</div>
    					<div class="tip">*</div>
    				</div>
				</div>
			</div>
			<!-- 结束 -->
			<div class="pBtn">
				<a class="save orangeBg" href="javascript:lhgSave();">保&nbsp;&nbsp;存</a>
				<a class="back grayBg" href="javascript:lhgBack();">返&nbsp;&nbsp;回</a>
			</div>
		</div>
	</form>
</body>
</html>
