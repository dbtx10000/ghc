<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<script type="text/javascript">
	var columns = [
		{width:"20%", name:"菜单", field:"name"},
    	{width:"10%", name:"级别", field:"level"},
    	{width:"07%", name:"类型", field:"type"},
    	{width:"07%", name:"排序", field:"weight"},
    	{width:"36%", name:"返回", field:"value"},
    	{width:"20%", name:"操作", field:"id"}
    ];
    var dptl = new DPTLister({
    	'columns' : columns,
    	'process' : function(html, cell) {
    		var operate = (
    			"<a href='javascript:edit(\"" + cell.id + "\", \"" + 
    			cell.pid + "\", " + cell.level + ")'>编辑</a>&nbsp;&nbsp;" +
    			"<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>"
    		);
    		if (cell.level == 1) {
    			operate = ("<a href='javascript:edit(\"\", \"" + 
    				cell.id + "\", 2);'>添加子菜单<a>&nbsp;&nbsp;" + operate);
    			html = html.replace("#name#", cell.name + "　　");
    			html = html.replace("#level#", "一级菜单");
    		} else {
    			html = html.replace("#name#", "　　" + cell.name);
    			html = html.replace("#level#", "二级菜单");
    		}
    		if (cell.type == 'view') {
    			html = html.replace("#type#", "链　接");
    			html = html.replace("#value#", cell.url);
    		} else {
    			html = html.replace("#type#", "关键字");
    			html = html.replace("#value#", cell.key);
    		}
    		return html.replace("#id#", operate);
    	}
    });
    $(document).ready(function() {
    	dptl.init().list(true);
    });
    /** 编辑 **/
    function edit(id, pid, level) {
    	var url = '${ctx}/wxapi/menus/edit/' + level;
    	var title = '';
    	if (id != null && id != '') {
    		url += ('?id=' + id + '&pid=' + pid);
    		title = '编辑菜单';
    	} else {
    		url += ('?pid=' + pid);
    		if (level == 1) {
    			title = '添加一级菜单';
    		} else {
    			title = '添加二级菜单';
    		}
    	}
    	url = 'url:' + url;
       	$.dialog($.extend(lhg, {
			width : '560px', height : '260px', 
			title : title, content : url
		}));
    }
    /** 删除 **/
    function lose(id) {
    	$.lhg.confirm('是否确认删除？',function() { 
    		$.LD.ajax({
    			url : '${ctx}/wxapi/menus/lose/' + id,
    			success : function(response) {
    				if (response.result == 1) {
    					dptl.list(true);
    				}
    			}
    		});
    	});
    }
   	/** 发布 **/
   	function gnrt() {
   		$.LD.ajax({
   			url : '${ctx}/wxapi/menus/gnrt',
   			success : function(response) {
   				var msg = '发布';
   				if (response.result == 1) {
   					msg += '成功';
   				} else {
   					msg += '失败';
   				}
   				$.lhg.confirm(msg);
   			}
   		});
   	}
</script>
</head>
  
<body>
<form action="${ctx}/wxapi/menus/page" method="post">
	<input type="hidden" name="mode" value="${mode}" />
		<div id="content">
	  		<div class="flag bt10"> 
		   		<div class="location">自定义菜单</div>
		   		<div class="rightBtn">
		   			<a href="javascript:gnrt();">发&nbsp;布</a>
		   			<a href="javascript:edit('', 0, 1);">添加一级菜单</a>
		   		</div>		
		   	</div>		    	
		   	<div class="data bt10">
		   		<table id="list_table" class="w100p"></table>
		   	</div>
	  	</div>
	</form>
</body>
</html>




	