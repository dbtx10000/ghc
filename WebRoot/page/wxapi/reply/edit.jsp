<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<style>
	body { background: #fff;}
</style>
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
   		return validThese($(":text"));
   	}
</script>
</head>
<body>
	<form id="save_form" action="${ctx}/wxapi/reply/save" method="post">
		<input type="hidden" id="id" name="id" value="${object.id}" />
		<input type="hidden" id="mode" name="mode" value="${mode}" />
		<div id="content-lhg">
			<div class="item h30">
				<div class="fir">关键字：</div>
				<div class="ipt">
					<input type="text" class="w230" id="tags" name="tags"
						placeholder="请输入关键字" value="${object.tags}" />
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
   				<div class="fir">类　型：</div>
   				<div class="ipt">
	   				<span class="sel">
	   					<select id="type" name="type" class="w140">
							<option ${object.type == 1 ? 'selected' : ''} value="1" >文本</option>
							<option ${object.type == 6 ? 'selected' : ''} value="6" >图文</option>
	   					</select>
	   				</span>
   				</div>
   			</div>
			<div class="item h30">
				<div class="fir">文　本：</div>
				<div class="ipt">
					<textarea style="width: 333px; min-width: 333px; 
						max-width: 333px; height: 120px; min-height: 120px; 
						max-height: 120px; line-height: normal;" 
						placeholder="选择文本时请输入文本回复内容(最多可输入255个字节)" 
						name="txt" maxlength="255">${object.txt}</textarea>
				</div>
			</div>
			<div class="popBtn">
				<a class="save greenBg" href="javascript:lhgSave()">保 存</a> 
				<a class="back grayBg" href="javascript:lhgBack()">返 回</a>
			</div>
		</div>
	</form>
</body>
</html>
