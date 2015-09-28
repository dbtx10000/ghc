<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript" src="${js}/kindeditor/kindeditor.js"></script>
    <script type="text/javascript">
    	$(document).ready(function() {
    		initEditor();
    	});
    	function formValid() {
    		$("textarea[name='invite']").val(editor.html());
    		return true;
    	}
    	var editor;
    	function initEditor() {
    		KindEditor.ready(function(K) {
				editor = K.create('textarea[name="invite"]', {
					uploadJson : '${ke_upload}',
					formatUploadUrl : false
				});
			});
    	}
    </script>
  </head>
  
  <body>
  	<form id="save_form" action="${ctx}/intro/save" method="post">
    	<input type="hidden" id="id" name="id" value="${object.id}" />
    	<div id="content">
	    	<div class="flag"> 
		    	<div class="location">邀请配置</div>
		    	<div class="rightBtn">
		    		<a href="javascript:htmSave('${ctx}/intro/edit');">&nbsp;保&nbsp;存&nbsp;</a>
		    	</div>		    		
			</div>
	    	<div class="data">
	    		<div class="form">
			  		<div class="item" style="height: 450px;">
	    				<div class="fir">邀请说明：</div>
	    				<div class="ipt">
	    					<textarea style="width: 700px; height: 433px;" 
	    						id="invite" name="invite">${object.invite}</textarea>
	    				</div>
	    			</div>
	    		</div>
	    	</div>
    	</div>
    </form>
  </body>
</html>
