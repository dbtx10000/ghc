<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"20%", name:"中奖用户", field:"userInfo"},
        	{width:"10%", name:"类型", field:"relateType"},
        	{width:"30%", name:"名称", field:"relateName"},
        	// {width:"20%", name:"SN码", field:"sncode"},
        	{width:"25%", name:"中奖时间", field:"createTime"},
        	{width:"15%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'fuzzies' : ['relateName'],
        	'sortWay' : 'create_time desc',
        	'process' : function(html, cell) {
        		html = html.replace("#relateType#", (cell.relateType == '1') ? '红包' : '奖品');
        		/* if (cell.relateType == '1') { html = html.replace("#sncode#", "暂无类型SN码"); } */
        		if (cell.userInfo != null) {
	        		html = html.replace("#userInfo#", cell.userInfo.realname);
        		}
        		/* var operate = "<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>" */;
        		return html;
        	}
        });

        $(document).ready(function() {
        	dptl.init().list(true);
        	$(".auxi select").change(function() {
        		dptl.list(true);
        	});
        });
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/winningRecord/lose/' + id,
        			success : function(response) {
        				if (response.result == 1) {
        					dptl.list(true);
        				}
        			}
        		});
        	});
        }
        
    </script>
  </head>
  
  <body>
  	<form action="${ctx}/winningRecord/page" method="post">
    	<div id="content">
	    	<div class="flag"> 
		    	<div class="location">用户中奖记录列表</div>   		
		 	</div>	
	    	<div class="tool">
	    		<div class="sear">
	  				<input type="text" name="keyword" placeholder="输入名称进行搜索"
	  					onkeydown="if (event.keyCode == 13) { dptl.list(false); }"/>
	  				<a href="javascript:;" onclick="dptl.list(false);">搜 索</a>
	  			</div>
  			<div class="auxi">
	  			<select name=relateType id="relateType" class="w120">
	  				<option value="">全部类型</option>
					<option value="1">红包</option>
					<option value="2">奖品</option>
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