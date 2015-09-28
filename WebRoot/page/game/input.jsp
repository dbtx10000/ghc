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
	/*
	$(document).ready(function() {
   		// initValid();
   		
		$("#productTypeId").change(function() {
  				$("#productId").empty();
			$("#productId").append("<option value=''>选择产品</option>");
			if($("#productTypeId").val()!=''){
				$.LD.ajax({
        			url : '${ctx}/game/productListByProductTypeId?productTypeId='+$("#productTypeId").val(),
        			success : function(response) {
        				for(var i=0;i<response.data.length;i++){
        					$("#productId").append("<option value="+ response.data[i].id+">"+ response.data[i].name+"</option>");
        					$("#productId").find("option[value='"+$("#PI").val()+"']").attr("selected",true);
        				}
        			}
       			});
			}
       	});
   		
   	});
	function formValid() {
		var $inputs = $("select");
   		return validThese($inputs,otherValid);
   	}
	function initValid() {
		var $inputs = $("select");
		$inputs.focus(function() {
			$(this).parent().parent().parent().find(".tip").html("*");
		}).blur(function() {
			valid($(this),otherValid);
		});
	}
	function otherValid($input) {
    		var result = true;
			if($("#productId").val().isEmpty()){
				$("#productId").parent().parent().parent().find(".tip").html("请选择产品");
				result=false;
			}
    		return result;
    	}
	*/
</script>
</head>

<body>
 	<form id="save_form" action="${ctx}/game/save" method="post">
    	<input type="hidden" id="id" name="id" value="${object.id}" />
    	<div id="content">
	    	<div class="flag"> 
		    	<div class="location">${empty(object.id) ? '添加' : '编辑'}</div>
		    	<div class="rightBtn">
			    	<a href="${ctx}/game/init">返回</a>
		    	</div>		    		
			</div>
			<!-- 开始 -->
			<div class="data">
				<div class="form">
	    			<div class="item" style="height: 420px;">
	    				<div class="fir">选择产品：</div>
	    				<div class="ipt">
	    					<select id="productId" name="productId"
								multiple="multiple" style="height: 400px; width: 277px;">
									<c:forEach items="${productList}" var="product">
										<option value="${product.id}" ${fn:contains(object.productId, product.id) ? 'selected' : ''}>${product.name}</option>
									</c:forEach>
							</select> 
	    				</div>
	    				<div class="tip">*</div>
	    			</div>
	    			<div class="item h43" id="income_type_1">
						<div class="fir">游戏时间：</div>
	    				<div class="ipt">
	    					<input type="text" style="width: 135px;" id="startTime" name="startTime" maxlength="20"
	    						value='<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss' value="${object.startTime}"/>' placeholder="请输入开始时间" 
	    						onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})"/>
	    						<span>至</span>
	    					<input type="text" style="width: 135px;" id="endTime" name="endTime" maxlength="20"
	    						value='<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss' value="${object.endTime}"/>' placeholder="请输入结束时间" 
	    						onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})"/>
	    				</div>
    					<div class="tip">*</div>
    				</div>
				</div>
			</div>
			<!-- 结束 -->
			<div class="pBtn">
				<a class="save orangeBg" href="javascript:htmSave('${ctx}/game/init');">保&nbsp;&nbsp;存</a>
				<a class="back grayBg" href="javascript:history.go(-1);">返&nbsp;&nbsp;回</a>
			</div>
		</div>
	</form>
</body>
</html>
