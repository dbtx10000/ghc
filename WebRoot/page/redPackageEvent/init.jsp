<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"53%", name:"红包活动名称", field:"name"},
        	{width:"7%", name:"老用户金币", field:"minIntegral"},
        	{width:"7%", name:"新用户金币", field:"maxIntegral"},
        	{width:"13%", name:"活动时间", field:"time"},
        	{width:"5%", name:"中奖数", field:"getCount"},
        	{width:"15%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns, 'txFixed' : false,
        	'sortWay' : 'create_time desc',
        	'colSort' : false, 'fuzzies' : ['name'],
        	'process' : function(html, cell) {
        	var operate ='';
        		var publish='';
	        		if(cell.status==1){
	        			publish="<a href='javascript:cancelPublish(\"" + cell.id + "\")'>取消发布</a>";
	        		}else{
	        			publish="<a href='javascript:publish(\"" + cell.id + "\")'>发布</a>";
	        		}
	        		html = html.replace("#time#", cell.startTime + ' 至 ' + cell.endTime);
	        		html=html.replace("#name#",cell.name+"<br>${webapp}/wap/redPackageEvent/index?id="+cell.id);
        			operate += (publish +
	        			"&nbsp;&nbsp;<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>" +
	        			"&nbsp;&nbsp;<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>");
        		return html.replace("#id#", operate);
        	}
        });

        $(document).ready(function() {
        	dptl.init().list(true);
        });
		function add() {
        	var url = '${ctx}/redPackageEvent/input';
        	location.href=url;
        }
        
        function publish(id) {
        	$.LD.ajax({
       			url : '${ctx}/redPackageEvent/publish?status=1&id=' + id,
       			success : function(response) {
       				if (response.result == 1) {
       					dptl.list(false);
       				}
       			}
       		});
        }
        function cancelPublish(id) {
        	$.LD.ajax({
       			url : '${ctx}/redPackageEvent/publish?status=2&id=' + id,
       			success : function(response) {
       				if (response.result == 1) {
       					dptl.list(false);
       				}
       			}
       		});
        }
        /** 编辑 **/
        function edit(id) {
        	var url = '${ctx}/redPackageEvent/input?id=' + id;
        	location.href=url;
        }
        
        
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/redPackageEvent/lose/' + id,
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
  	<form action="${ctx}/redPackageEvent/page" method="post">
    	<div id="content">
	    	<div class="flag bt10"> 
		    	<div class="location">红包活动列表</div>
		    	<div class="rightBtn">
		    		<a href="javascript:add();">添加红包活动</a>
		    	</div>	    		
		 	</div>	
		 	<div class="tool">
				<div class="sear">
	  				<input type="text" name="keyword" placeholder="输入红包活动名称搜索"
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