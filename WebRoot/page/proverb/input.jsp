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
    		var $inputs = $("textarea");
    		$inputs.focus(function() {
    			$(this).parent().parent().find(".tip").html("*");
    		}).blur(function() {
    			valid($(this));
    		});
    	}
    	function formValid() {
    		return validThese($("textarea"));
    	}
    </script>
  </head>
  
  <body>
  	<form id="save_form" action="${ctx}/proverb/save" method="post">
    	<input type="hidden" id="id" name="id" value="${object.id }" />
    	<div id="content">
	    	<div class="data">
	    		<div class="form">
    				<div class="item h150">
	    				<div class="fir">箴言内容：</div>
	    				<div class="ipt">
	    					<textarea style="width: 380px;resize:none; min-width: 360px; max-width: 360px; 
								height: 50px; min-height: 120px; max-height: 200px; line-height: normal;" 
								placeholder="请输入箴言内容(最多可输入100个字)" maxlength="255" 
								name="content">${object.content}</textarea>
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
