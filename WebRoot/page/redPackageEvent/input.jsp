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
   		initValid();
   	});
	function formValid() {
   		return validThese($(":text"),otherValid);
   	}
	function initValid() {
		var $inputs = $("input");
		$inputs.focus(function() {
			$(this).parent().parent().find(".tip").html("*");
		}).blur(function() {
			valid($(this),otherValid);
		});
	}
		function otherValid($input){
			var result=true;
	    	var id = $input.attr('id'), value = $input.val(), result = true;
	    	if((id == "minIntegral"||id == "maxIntegral")&&value != null && value != ''){
		    	if (!/^[0-9]*$/.test(value)){
		    		$input.parent().parent().find(".tip").
								html("<font color='red'>请输入正确格式金币数</a>");
					return false;
				}
		    }
		    return result;
    	}
</script>
</head>

<body>
 	<form id="save_form" action="${ctx}/redPackageEvent/save" method="post">
    	<input type="hidden" id="id" name="id" value="${object.id}" />
    	<div id="content">
	    	<div class="flag"> 
		    	<div class="location">${empty(object.id) ? '添加红包活动' : '编辑红包活动'}</div>
		    	<div class="rightBtn">
		    	</div>		    		
			</div>
			<!-- 开始 -->
			<div class="data">
	    		<div class="form">
	    			<div class="item h43">
	    				<div class="fir">红包活动名称：</div>
	    				<div class="ipt">
	    					<input type="text" class="w200" id="name" name="name" 
	    						maxlength="50" value="${object.name}" placeholder="请输入红包活动名称"/>
	    				</div>
	    				<div class="tip">*</div>
	    			</div>
	    			<div class="item h43">
	    				<div class="fir">老用户金币数：</div>
	    				<div class="ipt">
	    					<input type="text" class="w200" id="minIntegral" name="minIntegral" 
	    						maxlength="50" value="${object.minIntegral}" placeholder="请输入最小金币数"/>
	    				</div>
	    				<div class="tip">*</div>
	    			</div>
	    			<div class="item h43">
	    				<div class="fir">新用户金币数：</div>
	    				<div class="ipt">
	    					<input type="text" class="w200" id="maxIntegral" name="maxIntegral" 
	    						maxlength="20" value="${object.maxIntegral}" placeholder="请输入最大金币数"/>
	    				</div>
	    				<div class="tip">*</div>
	    			</div>
	    			<div class="item h43">
	    				<div class="fir">活动开始时间：</div>
	    				<div class="ipt">
	    					<input type="text" class="w200" id="startTime" name="startTime" maxlength="20"
	    						value='<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss' value="${object.startTime}"/>' placeholder="请输入开始时间" 
	    						onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})"/>
	    				</div>
	    				<div class="tip">*</div>
	    			</div>
	    			<div class="item h43">
	    				<div class="fir">活动结束时间：</div>
	    				<div class="ipt">
	    					<input type="text" class="w200" id="endTime" name="endTime" maxlength="20"
	    						value='<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss' value="${object.endTime}"/>' placeholder="请输入结束时间" 
	    						onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})"/>
	    				</div>
	    				<div class="tip">*</div>
	    			</div>
	    		</div>
	    	</div>
			<!-- 结束 -->
			<div class="pBtn">
				<a class="save orangeBg" href="javascript:htmSave('${ctx}/redPackageEvent/init');">保&nbsp;&nbsp;存</a>
				<a class="back grayBg" href="${ctx}/redPackageEvent/init">返&nbsp;&nbsp;回</a>
			</div>
		</div>
	</form>
</body>
</html>
