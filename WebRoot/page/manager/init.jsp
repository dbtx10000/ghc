<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"10%", name:"编号", field:"code"},
        	{width:"15%", name:"登录名", field:"username"},
        	{width:"15%", name:"联系人", field:"linkman"},
        	{width:"15%", name:"联系方式", field:"telephone"},
        	{width:"15%", name:"添加时间", field:"createTime"},
        	{width:"10%", name:"状态", field:"status"},
        	{width:"20%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'fuzzies' : ['code', 'username', 'linkman', 'telephone'],
        	'process' : function(html, cell) {
        		var status = cell.status;
        		var operate = "";
        		if (status == 1) {
        			html = html.replace("#status#", "正常");
        			operate = "<a href='javascript:paused(\"" + cell.id + "\")'>禁用</a>&nbsp;&nbsp;";
        		} else {
        			html = html.replace("#status#", "禁用");
        			operate = "<a href='javascript:active(\"" + cell.id + "\")'>激活</a>&nbsp;&nbsp;";
        		}
        		operate += ("<a href='javascript:reset(\"" + cell.id + "\")'>重置密码</a>" +
        			"&nbsp;&nbsp;<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>" +
        			"&nbsp;&nbsp;<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>");
        		return html.replace("#id#", operate);
        	}
        });
        $(document).ready(function() {
        	dptl.init().list(true);
        });
        /** 新增 **/
        function add() {
        	var url = 'url:${ctx}/manager/edit';
        	$.dialog($.extend(lhg, {
				width : '520px', height : '300px', 
				title : '添加管理', content : url
			}));
        }
        /** 编辑 **/
        function edit(id) {
        	var url = 'url:${ctx}/manager/edit?id=' + id;
        	$.dialog($.extend(lhg, {
				width : '520px', height : '300px', 
				title : '编辑管理', content : url
			}));
        }
        /** 激活 **/
        function active(id) {
        	$.lhg.confirm('是否确认激活账号？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/manager/active/' + id,
        			success : function(response) {
        				if (response.result == 1) {
        					dptl.list(true);
        				}
        			}
        		});
        	});
        }
        /** 禁用 **/
        function paused(id) {
        	$.lhg.confirm('是否确认禁用账号？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/manager/paused/' + id,
        			success : function(response) {
        				if (response.result == 1) {
        					dptl.list(true);
        				}
        			}
        		});
        	});
        }
		/** 重置 **/
        function reset(id) {
        	$.lhg.confirm('是否确认重置密码？',function() { 
        		$.LD.ajax({
        			url : "${ctx}/manager/reset/" + id,
        			success : function(response) {
        				if (response.result == 1) {
        					dptl.list(true);
        				}
        			}
        		});
        	});
        }
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/manager/lose/' + id,
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
	 <form action="${ctx}/manager/list" method="post">
	    <div id="content">
    		<div class="flag"> 
	    		<div class="location">管理列表</div>
	    		<div class="rightBtn">
	    			<a href="javascript:add();">添加管理</a>
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




	