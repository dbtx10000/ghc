<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"70%", name:"奖池名称", field:"name"},
        	{width:"07%", name:"奖品数量", field:"jackpotCount"},
        	{width:"16%", name:"创建时间", field:"createTime"},
        	{width:"07%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns, 
        	'fuzzies' : 'name',
        	'sortWay' : 'create_time desc',
        	'process' : function(html, cell) {
        		html=html.replace("#name#", cell.name + ' 奖池<br/>抽奖链接：${webapp}/wap/jackpot/index?id=' + cell.id);
        		html=html.replace("#jackpotCount#", "<a href='javascript:showAward(\"" + cell.productId + "\")'>"+cell.jackpotCount+"</a>&nbsp;");
        		var operate = (
/*         			"<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>&nbsp;" +
 */        			"<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>"
        		);
        		return html.replace("#id#", operate);
        	}
        });
        $(document).ready(function() {
        	dptl.init().list(true);
        });
         /** 新增 **/
        function add() {
        	var url = '${ctx}/jackpotType/input';
        	location.href = url;
        }
        /** 编辑 **/
        function edit(id) {
        	var url = '${ctx}/jackpotType/input?id='+id;
        	location.href = url;
        }
        /** 查看该产品奖品 **/
        function showAward(productId) {
        	var url = '${ctx}/jackpot/init?productId='+productId;
        	location.href = url;
        }
        
        /** 删除 **/
        function lose(id) {
        					$.lhg.confirm('是否确认删除？',function() { 
				        		$.LD.ajax({
				        			url : '${ctx}/jackpotType/lose/' + id,
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
	 <form action="${ctx}/jackpotType/page" method="post">
	    <div id="content">
    		<div class="flag bt10"> 
	    		<div class="location">奖池列表</div>
	    		<div class="rightBtn">
	    			<a href="javascript:add();">添加奖池</a>
	    		</div>		
	    	</div>		    	
	    	<div class="tool">
	    		<div class="sear">
	  				<input type="text" name="keyword" placeholder="输入产品名称搜索"
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




	