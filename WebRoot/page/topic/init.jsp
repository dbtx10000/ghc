<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"70%", name:"题目名称", field:"name"},
        	{width:"12%", name:"排序", field:"seq"},
        	{width:"18%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'sortWay' : 'seq,create_time desc',
        	'colSort' : false,
        	'process' : function(html, cell) {
        	var operate ='';
        			operate += "&nbsp;<a href='javascript:topicDetail(\"" + cell.id + "\")'>答题详情</a>" +
        			"&nbsp;&nbsp;<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>" +
        			"&nbsp;&nbsp;<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>";
        		return html.replace("#id#", operate);
        	}
        });

        $(document).ready(function() {
        	dptl.init().list(true);
        });
		function add() {
        	var url = '${ctx}/topic/input?questionnaireId=${questionnaireId}';
        	location.href = url;
        }
        
        function topicDetail(topicId) {
        	var url = '${ctx}/questionnaireRecord/topicDetail?topicId='+topicId;
        	location.href = url;
        }
        
        /** 编辑 **/
        function edit(id) {
        	var url = '${ctx}/topic/input?questionnaireId=${questionnaireId}&id=' + id;
        	location.href = url;
        }
        
        
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/topic/lose/' + id,
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
  	<form action="${ctx}/topic/page" method="post">
  		<input type="hidden" value="${questionnaireId}" name="questionnaireId"/>
    	<div id="content">
	    	<div class="flag bt10"> 
		    	<div class="location">题目列表</div>
		    	<div class="rightBtn">
		    		<a href="javascript:history.go(-1);">返回</a>
		    		<a href="javascript:add();">添加题目</a>
		    	</div>	    		
		 	</div>	
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>