<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"15%", name:"名称", field:"name"},
        	{width:"10%", name:"类型", field:"type"},
        	{width:"25%", name:"换购时间", field:"time"},
        	{width:"10%", name:"所需金币数", field:"integral"},
        	{width:"10%", name:"剩余库存数", field:"stocknum"},
        	{width:"10%", name:"已被换购数", field:"tradenum"},
        	{width:"08%", name:"排序", field:"weight"},
        	{width:"12%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns, 'fuzzies' : 'name',
        	'sortWay' : 'weight , create_time desc',
        	'process' : function(html, cell) {
        		if (cell.type == 1) {
        			html = html.replace("#type#", "实物");
        		} else if (cell.type == 2) {
        			html = html.replace("#type#", "电子券");
        		}
        		html = html.replace("#time#", cell.startTime + '至' + cell.endTime);
        		var operate = (
        			"<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>&nbsp;" +
        			"&nbsp;<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>"
        		);
        		return html.replace("#id#", operate);
        	}
        });
        $(document).ready(function() {
        	dptl.init().list(true);
        	$(".auxi select").change(function() {
        		dptl.list(false);
        	});
        });
        /** 编辑 **/
        function edit(id) {
        	var url = '${ctx}/gifts/igift/edit';
        	if (id != null) {
        		url += ('?id=' + id);
        	}
        	location.href = url;
        }
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/gifts/igift/lose/' + id,
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
	 <form action="${ctx}/gifts/igift/page" method="post">
	    <div id="content">
    		<div class="flag"> 
	    		<div class="location">礼品列表</div>
	    		<div class="rightBtn">
	    			<a href="javascript:edit();">添加礼品</a>
	    		</div>		
	    	</div>		    	
	    	<div class="tool">
	    		<div class="sear">
	  				<input type="text" name="keyword" placeholder="输入关键字搜索"
	  					onkeydown="if (event.keyCode == 13) { dptl.list(false); }"/>
	  				<a href="javascript:;" onclick="dptl.list(false);">搜 索</a>
	  			</div>
	  			<!-- <div class="auxi">
		  			<select name="type" id="type" class="w120">
		  				<option value="">全部类型</option>
		  				<option value="1">实物</option>
		  				<option value="2">电子券</option>
		  			</select>
		  		</div> -->
	    	</div>
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>




	