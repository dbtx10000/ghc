<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<script type="text/javascript" src="${js}/kindeditor/kindeditor.js"></script>
<script type="text/javascript" src="${js}/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${js}/LD.sot/multiupf/init.js?skin=image"></script>
<script type="text/javascript">
		$(document).ready(function() {
    		$("input").focus(function() {
    			$(this).parent().parent().find(".tip").html("*");
    		}).blur(function() {
    			valid($(this), otherValid);
    		});
    	});
    	function formValid() {
    		return validThese($("input"), otherValid);
    	}
    	function otherValid($input) {
    		var id = $input.attr('id'), value = $input.val();
    		var $fir = $input.parent().parent().find(".fir");
			var fir = $fir.html().substring(0, $fir.html().length - 1);
			var $tip = $input.parent().parent().find(".tip");
    		var result = true;
    		if("${object.relateType}" != 4){
    			var allNum = parseInt($("#allNum").val());
    			if(parseInt($("#count").val()) > parseInt(allNum)){
    				$("#count").parent().parent().find(".tip").html("导入数不能大于可导入总数");
    				result = false;
    			}
    			if(id=='count'||id=='basic'){
				if ((!value.isPositive()&&parseInt(value)!=0)|| parseInt(value) < 0) {
					$tip.html("<font color='red'>" + fir + "必须是正整数</font>");
					result = false;
				}
			}
    		}
    		return result;
    	}
	
		$(document).keypress(function(event){ 
			if(event.keyCode == 13){ 
				//按下回车键时候，由于当页面只有一个input-text文本框的时候，浏览器默认会把你按下回车键，当成表单提交，这样我们的验证就会被忽略，这边避免一下
				return false;
			}
		});
</script>
<style>
body {
	background: #fff
}
</style>
</head>

<body>
	<form id="save_form" action="${ctx}/jackpot/save" method="post">
		<input type="hidden" id="id" name="id" value="${object.id }" /> 
		<input type="hidden" id="allNum" value="${object.relate.residueCount+object.count }"/>
		<div id="content-lhg">
			<div class="item h30">
				<div class="fir">名称：</div>
				<div class="ipt">
					${object.relate.name}
				</div>
			</div>
			<div class="item h30">
				<div class="fir">类型：</div>
				<div class="ipt">
				<c:choose>
					<c:when test="${object.relateType==1}">红包</c:when>
					<c:when test="${object.relateType==2}">奖品</c:when>
				</c:choose>
				</div>
			</div>
				<div class="item h30">
					<div class="fir">最多可导入：</div>
					<div class="ipt">
							${object.relate.residueCount+object.count}
					</div>
				</div>
				<div class="item h30">
				<div class="fir">导入数:</div>
		  			<div class="ipt">
		  				<input type="text" class="w210" maxlength="8" id="count" name="count"
		  					placeholder="请输入导入数" value="${object.count}" 
		  					<c:if test="${(object.relate.residueCount)+object.count==0 }">readonly="readonly"</c:if>/>
		  			
		  			</div>
	  			<div class="tip">*</div>
				</div>
			<div class="item h30">
			<div class="fir">基数:</div>
		  		<div class="ipt">
		  			<input type="text" class="w210" id="basic" maxlength="8" name="basic"
		  				placeholder="请输入基数" value="${object.basic}" />
		  		</div>
	  		<div class="tip">*</div>
			</div>
			<div class="popBtn">
				<a class="save orangeBg" href="javascript:lhgSave()">保 存</a> <a
					class="back grayBg" href="javascript:lhgBack()">返 回</a>
			</div>
		</div>
	</form>
</body>
</html>
