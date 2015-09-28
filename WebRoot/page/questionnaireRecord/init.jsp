<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"15%", name:"用户账号", field:"userAccount"},
        	{width:"15%", name:"用户姓名", field:"username"},
        	{width:"40%", name:"问卷标题", field:"questionnaireTitle"},
        	{width:"15%", name:"参与问卷时间", field:"createTime"},
        	{width:"15%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'sortWay' : 'create_time desc',
        	'colSort' : false,
        	'process' : function(html, cell) {
        	var operate ='';
        			operate += "&nbsp;<a href='javascript:detail(\""+cell.questionnaireId+"\",\""+cell.userId+"\")'>查看详情</a>" ;
        		return html.replace("#id#", operate);
        	}
        });

        $(document).ready(function() {
        	dptl.init().list(true);
        });
        function detail(questionnaireId,userId){
        	location.href='${ctx}/questionnaireRecord/detail?questionnaireId='+questionnaireId+'&userId='+userId;
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
  		<input type="hidden" id="groupBy" name="groupBy" value="user_id" />
    	<div id="content">
	    	<div class="flag bt10"> 
		    	<div class="location">问卷记录</div>
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