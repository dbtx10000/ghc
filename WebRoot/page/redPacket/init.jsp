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
        	{width:"20%", name:"剩余数量/总数量", field:"allCount"},
        	{width:"20%", name:"金币", field:"integral"},
        	{width:"20%", name:"创建时间", field:"createTime"},
        	{width:"20%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'fuzzies' : ['name'],
        	'sortWay' : 'id desc',
        	'colSort' : false,
        	'process' : function(html, cell) {
        		var operate = "";
        		html=html.replace("#allCount#", cell.residueCount+"/"+cell.allCount);
        		operate += (
        			"<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>");
        		return html.replace("#id#", operate);
        	}
        });

        $(document).ready(function() {
        	dptl.init().list(true);
        });

  		function add() {
        	var url = 'url:${ctx}/redPacket/input';
        	$.dialog($.extend(lhg, {
				width : '600px', height : '390px', 
				title : '新增红包', content : url
			}));
        }
        /** 删除 **/
        function lose(id) {
       			$.LD.ajax({
        			url : '${ctx}/redPacket/checkJackpot?relateId=' + id,
        			success : function(response) {
        				if (response.result == 1) {
        					$.lhg.confirm('是否确认删除？',function() { 
				        		$.LD.ajax({
				        			url : '${ctx}/redPacket/lose/' + id,
				        			success : function(response) {
				        				if (response.result == 1) {
				        					dptl.list(false);
				        				}
				        			}
				        		});
        					});
        				}else{
        					$.lhg.confirm("请删除奖池管理对应红包后，才能点击此操作!");
        				}
        			}
        		});
        }
    </script>
  </head>
  
  <body>
 	  	<form action="${ctx}/redPacket/page" method="post">

		    <div id="content">
	    			<div class="flag"> 
			    		<div class="location">红包列表</div>
			    		<div class="rightBtn">
			    			<a href="javascript:add();">添加红包</a>
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




	