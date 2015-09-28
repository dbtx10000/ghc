<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"30%", name:"名称", field:"name"},
        	{width:"20%", name:"开始时间", field:"startTime"},
        	{width:"20%", name:"结束时间", field:"endTime"},
        	{width:"30%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns, 
        	'fuzzies' : 'name,start_time,end_time',
        	'sortWay' : 'create_time desc',
        	'process' : function(html, cell) {
        		var startTime,endTime = "";
        		var operate = (
        			"<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>&nbsp;&nbsp;&nbsp;"+
        			"<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>"
        		);
        		startTime = cell.startTime.substr(0,10);
        		endTime = cell.endTime.substr(0,10);
        		html = html.replace("#startTime#", startTime).replace("#endTime#", endTime);
        		return html.replace("#id#", operate);
        	}
        });
        $(document).ready(function() {
        	dptl.init().list(true);
        	$(".auxi select,.auxi1 select").change(function() {
        		dptl.list(false);
        	});
        });
         /** 新增 **/
        function add() {
        	var url = 'url:${ctx}/holiday/input';
        	$.dialog($.extend(lhg, {
				width : '520px', height : '210px',
				title : '添加', content : url
			}));
        }
        /** 编辑 **/
        function edit(id) {
        	var url = 'url:${ctx}/holiday/input?id='+id;
        	$.dialog($.extend(lhg, {
				width : '520px', height : '210px',
				title : '编辑', content : url
			}));
        }
        /** 删除 **/
        function lose(id) {
				$.lhg.confirm('是否确认删除？',function() { 
	        		$.LD.ajax({
	        			url : '${ctx}/holiday/lose/' + id,
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
	 <form action="${ctx}/holiday/page" method="post">
	    <div id="content">
    		<div class="flag bt10"> 
	    		<div class="location">假期列表</div>
	    		<div class="rightBtn">
	    			<a href="javascript:add();">添加假期</a>
	    		</div>		
	    	</div>		    	
	    	<div class="tool">
	    		<div class="sear">
	  				<input type="text" name="keyword" placeholder="输入名称搜索"
	  					onkeydown="if (event.keyCode == 13) { dptl.list(false); }"/>
	  				<a href="javascript:;" onclick="dptl.list(false);">搜 索</a>
	  			</div>
	  			<div class="auxi">
	  				<select name="year" class="w120">
		  				<option value="">全部</option>
		  				<option value="2015">2015年</option>
		  				<option value="2016">2016年</option>
		  				<option value="2017">2017年</option>
		  				<option value="2018">2018年</option>
		  			</select>
	  			</div>
	    	</div>
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>




	