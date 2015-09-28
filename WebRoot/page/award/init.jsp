<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"20%", name:"名称", field:"name"},
        	{width:"30%", name:"图片", field:"image"},
        	{width:"30%", name:"剩余数量/总数量", field:"count"},
        	{width:"20%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns, 
        	'fuzzies' : 'name',
        	'sortWay' : 'create_time desc',
        	'process' : function(html, cell) {
        		var image='';
        		if(cell.smallImage !=null&&cell.smallImage !=''){
         	 		image+="<img width='120' height='50' style='margin-top: 6px;' src='"+cell.smallImage+"'/>";	
         	 	}else{
         	 		image+="<img width='120' height='50' style='margin-top: 6px;' src='${img}/default.png'/>";	
         	 	}
         	 	html = html.replace("#image#", image);
        		html = html.replace("#count#", cell.residueCount + '/' + cell.count);
        		var operate = (
        			"<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>&nbsp;" +
        			"&nbsp;<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>"
        		);
        		return html.replace("#id#", operate);
        	}
        });
        $(document).ready(function() {
        	dptl.init().list(true);
        });
         /** 新增 **/
        function add() {
        	var url = '${ctx}/award/input';
        	location.href = url;
        }
        /** 编辑 **/
        function edit(id) {
        	var url = '${ctx}/award/input?id='+id;
        	location.href = url;
        }
        /** 删除 **/
        function lose(id) {
       			$.LD.ajax({
        			url : '${ctx}/award/checkJackpot?relateId=' + id,
        			success : function(response) {
        				if (response.result == 1) {
        					$.lhg.confirm('是否确认删除？',function() { 
				        		$.LD.ajax({
				        			url : '${ctx}/award/lose/' + id,
				        			success : function(response) {
				        				if (response.result == 1) {
				        					dptl.list(false);
				        				}
				        			}
				        		});
        					});
        				}else{
        					$.lhg.confirm("请删除奖池管理对应奖品后，才能点击此操作!");
        				}
        			}
        		});
        }
    </script>
  </head>
  
  <body>
	 <form action="${ctx}/award/page" method="post">
	    <div id="content">
    		<div class="flag bt10"> 
	    		<div class="location">奖品列表</div>
	    		<div class="rightBtn">
	    			<a href="javascript:add();">添加奖品</a>
	    		</div>		
	    	</div>		    	
	    	<div class="tool">
	    		<div class="sear">
	  				<input type="text" name="keyword" placeholder="输入关键字搜索"
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




	