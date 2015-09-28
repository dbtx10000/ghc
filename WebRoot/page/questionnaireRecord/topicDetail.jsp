<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"10%", name:"用户账号", field:"userAccount"},
        	{width:"10%", name:"用户姓名", field:"username"},
        	{width:"60%", name:"选项答案", field:"optionName"},
        	{width:"20%", name:"答题时间", field:"createTime"},
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
  		<input type="hidden" id="topicId" name="topicId" value="${topicId}" />
    	<div id="content">
	    	<div class="flag bt10"> 
		    	<div class="location">答题记录</div>
		    	<div class="rightBtn">
		    		<a href="javascript:history.go(-1);">返回</a>
		    	</div>	
		 	</div>	
		 	<div class="tool">
				<div class="sear">
	  				<input type="text" name="userAccount" placeholder="输入用户账号搜索"
	  					onkeydown="if (event.keyCode == 13) { dptl.list(false); }"/>
	  				<a href="javascript:;" onclick="dptl.list(false);">搜 索</a>
 				</div>
			</div>
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>