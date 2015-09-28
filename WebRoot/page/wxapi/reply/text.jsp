<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <style type="text/css">
    	.block_table {
    		width: 99%; 
    		height: 32px;
			line-height: 32px;
			margin-left: 0.5%; 
    		margin: 10px 0 0 0;
			font-size: 12px;
    	}
    	.block_table li.tab {
    		float: left;
    		width: 200px;
    		border-radius: 32px 32px 0 0;
    		border: 1px solid #e1e4e9;
    		text-align: center;
    		border-bottom: none;
    		cursor: pointer;
    		position: relative;
    	}
    	.block_table li.sel {
    		background-color: #f5f5f5;
    	}
    	.block_table li.btn {
    		background: #ed5565; 
    		border-bottom: 3px #da4453 solid; 
    		color: #fff; 
    		padding: 3px 16px;
    		height: 22px;
    		line-height: 22px;
    		text-align: center;
    		float: right;
    		font-size: 12px;
    		cursor: pointer;
    	}
    	.input_table {
    		width: 99%; 
			margin-left: 0.5%; 
    		border: 1px solid #e1e4e9; 
			background-color: #f5f5f5;
			font-size: 12px;
			padding: 10px 0;
    	}
    	.input_table td {
    		border-top: 1px solid #e1e4e9; 
    		border-bottom: 1px solid #e1e4e9; 
    		background-color: #ffffff;
    	}
    </style>
    <script type="text/javascript">
    	function formValid() {
    		return true;
    	}
    	function change(num) {
    		var url = '${ctx}/wxapi/reply/init/${mode}';
    		location.href = (url + '?type=' + num);
    	}
    </script>
  </head>
  
  <body>
	 <form id="save_form" action="${ctx}/wxapi/reply/save" method="post">
    	<input type="hidden" id="id" name="id" value="${object.id}" />
    	<input type="hidden" id="mode" name="mode" value="${mode}" />
    	<input type="hidden" id="type" name="type" value="${type}" />
    	<div id="content">
	    	<div class="flag"> 
		    	<div class="location">
		    		<c:if test="${mode == 1}">关注时回复</c:if>
		    		<c:if test="${mode == 2}">无应答回复</c:if>
		    	</div>
			</div>
			<ul class="block_table" style="margin-left: 0.5%;">
				<li onclick="change(1);" class="tab sel" style="z-index: 1;">文&nbsp;本${object.type == 1 ? '&nbsp;(&nbsp;启&nbsp;用&nbsp;)' : ''}</li>
				<li onclick="change(6);" class="tab" style="margin-left: -10px; z-index: 0;">图&nbsp;文${object.type == 6 ? '&nbsp;(&nbsp;启&nbsp;用&nbsp;)' : ''}</li>
				<li onclick="htmSave();" class="radius3 btn w80">发&nbsp;布</li>
			</ul>
			<table class="input_table">
				<tr>
					<td style="width: 80px; text-align: center;">回复内容</td>
					<td style="border-left: 1px solid #e1e4e9;">
						<textarea style="width: 480px; min-width: 480px; max-width: 480px; 
							height: 120px; min-height: 120px; max-height: 120px; margin: 5px; 
							line-height: normal; border: 1px solid #e1e4e9;" 
							placeholder="请输入回复内容(最多可输入255个字节)" 
							name="txt" maxlength="255">${object.txt}</textarea>
						<span id="txt_tip" style="color: red;">*</span>
					</td>
				</tr>
			</table>
		</div>
    </form>
  </body>
</html>




	