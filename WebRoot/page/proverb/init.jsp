<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"80%", name:"箴言内容", field:"content"},
        	{width:"20%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'sortWay' : 'create_time desc',
        	'colSort' : false,
        	'process' : function(html, cell) {
        	var operate ='';
        			operate += "&nbsp;<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>" +
        			"&nbsp;&nbsp;<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>";
        		return html.replace("#id#", operate);
        	}
        });

        $(document).ready(function() {
        	dptl.init().list(true);
        });
		function add() {
        	var url = 'url:${ctx}/proverb/input';
        	$.dialog($.extend(lhg, {
				width : '600px', height : '265px', 
				title : '新增箴言', content : url
			}));
        }
        
        /** 编辑 **/
        function edit(id) {
        	var url = 'url:${ctx}/proverb/input?id=' + id;
        	$.dialog($.extend(lhg, {
				width : '600px', height : '265px', 
				title : '编辑', content : url
			}));
        }
        
        
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/proverb/lose/' + id,
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
  	<form action="${ctx}/proverb/page" method="post">
    	<div id="content">
	    	<div class="flag bt10"> 
		    	<div class="location">箴言列表</div>
		    	<div class="rightBtn">
		    		<a href="javascript:add();">添加箴言</a>
		    	</div>	    		
		 	</div>	
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>