<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"25%", name:"广告名称", field:"title"},
        	{width:"15%", name:"广告位置", field:"position"},
        	{width:"20%", name:"添加时间", field:"createTime"},
        	{width:"15%", name:"添加者", field:"creater"},
        	{width:"5%", name:"排序", field:"weight"},
        	{width:"20%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'fuzzies' : ['title'],
        	'sortWay' : 'weight',
        	'colSort' : false,
        	'process' : function(html, cell) {
        		html = html.replace("#creater#", cell.creater.linkman);
        		var position = "";
        		if (cell.position == 1) {
        			position = "首页";
        		}
        		html = html.replace("#position#", position);
        		var operate = "";
        		operate = "<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>" +
        			"&nbsp;&nbsp;<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>";
        		return html.replace("#id#", operate);
        	}
        });

        $(document).ready(function() {
        	dptl.init().list(true);
        	$(".auxi select").change(function() {
        		dptl.list(false);
        	});
        });

        /** 新增 **/
        function add() {
        	location.href = '${ctx}/advert/input';
        }

        /** 编辑 **/
        function edit(id) {
        	location.href = '${ctx}/advert/input?id=' + id;
        }
        
        
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/advert/lose/' + id,
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
  	<form action="${ctx}/advert/list" method="post">
    	<div id="content">
	    	<div class="flag"> 
			    	<div class="location">广告列表</div>
			    	<div class="rightBtn">
			    			<a href="javascript:add(0);">添加广告</a>
			    	</div>		    		
			 </div>	
	    	<div class="tool">
	    		<div class="sear">
	  				<input type="text" name="keyword" placeholder="输入广告名称进行搜索"
	  					onkeydown="if (event.keyCode == 13) { dptl.list(false); }"/>
	  				<a href="javascript:dptl.list(false);">搜 索</a>
	  			</div>
	    	</div>
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>
