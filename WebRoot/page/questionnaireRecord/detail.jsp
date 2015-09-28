<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"40%", name:"题目名称", field:"topicName"},
        	{width:"60%", name:"选项答案", field:"optionName"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'sortWay' : 'create_time desc',
        	'colSort' : false,
        	'process' : function(html, cell) {
        		return html;
        	}
        });

        $(document).ready(function() {
        	dptl.init().list(true);
        });
        function detail(questionnaireId){
        	location.href='${ctx}/questionnaireRecord/detail?questionnaireId='+questionnaireId;
        }
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/questionnaireRecord/lose/' + id,
        			success : function(response) {
        				if (response.result == 1) {
        					dptl.list(false);
        				}
        			}
        		});
        	});
        }
    </script>
  </head>
  
  <body>
  	<form action="${ctx}/questionnaireRecord/page" method="post">
  		<input type="hidden" id="questionnaireId" name="questionnaireId" value="${questionnaireId}" />
  		<input type="hidden" id="userId" name="userId" value="${userId}" />
    	<div id="content">
	    	<div class="flag bt10"> 
		    	<div class="location">问卷记录</div>
		    	<div class="rightBtn">
		    		<a href="javascript:history.go(-1);">返回</a>
		    	</div>	
		 	</div>	
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>