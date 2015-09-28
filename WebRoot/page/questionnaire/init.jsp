<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"57%", name:"问卷标题", field:"title"},
        	{width:"07%", name:"奖励金币", field:"integral"},
        	{width:"07%", name:"题目数", field:"topicCount"},
        	{width:"07%", name:"调查人数", field:"userCount"},
        	{width:"14%", name:"创建时间", field:"createTime"},
        	{width:"08%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'sortWay' : 'create_time desc',
        	'colSort' : false,
        	'process' : function(html, cell) {
        	html=html.replace("#title#", cell.title + '<br/>问卷链接：${webapp}/wap/questionnaire/index?id=' + cell.id);
        	var operate ='';
        			operate += "&nbsp;<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>" +
        			"&nbsp;&nbsp;<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>";
        		html = html.replace("#topicCount#", "<a href='javascript:showTopicCount(\"" + cell.id + "\");'>" + cell.topicCount + "</a>");
        		html = html.replace("#userCount#", "<a href='javascript:showUserCount(\"" + cell.id + "\");'>" + cell.userCount + "</a>");
        		return html.replace("#id#", operate);
        	}
        });

        $(document).ready(function() {
        	dptl.init().list(true);
        });
		function add() {
        	var url = 'url:${ctx}/questionnaire/input';
        	$.dialog($.extend(lhg, {
				width : '600px', height : '330px', 
				title : '新增问卷', content : url
			}));
        }
        
        /** 查看题目列表 **/
        function showTopicCount(id) {
        	location.href = '${ctx}/topic/init?questionnaireId=' + id;
        }
        
         /** 查看参与调查用户列表 **/
        function showUserCount(id) {
        	location.href = '${ctx}/questionnaireRecord/init?questionnaireId=' + id;
        }
        
        /** 编辑 **/
        function edit(id) {
        	var url = 'url:${ctx}/questionnaire/input?id=' + id;
        	$.dialog($.extend(lhg, {
				width : '600px', height : '330px', 
				title : '编辑', content : url
			}));
        }
        
        
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/questionnaire/lose/' + id,
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
  	<form action="${ctx}/questionnaire/page" method="post">
    	<div id="content">
	    	<div class="flag bt10"> 
		    	<div class="location">问卷列表</div>
		    	<div class="rightBtn">
		    		<a href="javascript:add();">添加问卷</a>
		    	</div>	    		
		 	</div>	
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>