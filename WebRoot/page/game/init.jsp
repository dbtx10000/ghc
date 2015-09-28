<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"60%", name:"名称", field:"name"},
        	{width:"15%", name:"开始时间", field:"startTime"},
        	{width:"15%", name:"结束时间", field:"endTime"},
        	/* {width:"15%", name:"创建时间", field:"createTime"}, */
        	{width:"10%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns, 
        	'fuzzies' : 'name',
        	'sortWay' : 'create_time desc',
        	'process' : function(html, cell) {
        		html=html.replace("#name#", cell.name + ' 游戏<br/>游戏链接：${webapp}/wap/game/index?id=' + cell.id);
        		var operate = (
        			"<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>"
        		);
        		return html.replace("#id#", operate);
        	}
        });
        $(document).ready(function() {
        	dptl.init().list(true);
        });
         /** 新增 **/
        function add() {
        	var url = '${ctx}/game/input';
        	location.href = url;
        }
        /** 编辑 **/
        function edit(id) {
        	var url = '${ctx}/game/input?id='+id;
        	location.href = url;
        }
        /** 删除 **/
        function lose(id) {
				$.lhg.confirm('是否确认删除？',function() { 
	        		$.LD.ajax({
	        			url : '${ctx}/game/lose/' + id,
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
	 <form action="${ctx}/game/page" method="post">
	    <div id="content">
    		<div class="flag bt10"> 
	    		<div class="location">游戏列表</div>
	    		<div class="rightBtn">
	    			<a href="javascript:add();">添加游戏</a>
	    		</div>		
	    	</div>		    	
	    	<div class="tool">
	    		<div class="sear">
	  				<input type="text" name="keyword" placeholder="输入名称搜索"
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




	