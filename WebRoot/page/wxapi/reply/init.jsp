<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"25%", name:"关键字", field:"tags"},
        	{width:"25%", name:"消息类型", field:"type"},
        	{width:"25%", name:"查询次数", field:"queryCount"},
        	{width:"25%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'fuzzies' : ['tags'],
        	'process' : function(html, cell) {
        		var operate = "<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>&nbsp;";
        		if (cell.type == 1) {
        			html = html.replace("#type#", "文本");
        		} else if (cell.type == 6) {
        			html = html.replace("#type#", "图文");
        			operate += "&nbsp;<a href='javascript:news(\"" + cell.id + "\")'>图文列表</a>&nbsp;";
        		}
        		operate += ("&nbsp;<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>");
        		return html.replace("#id#", operate);
        	}
        });
        $(document).ready(function() {
        	dptl.init().list(true);
        });
        /** 编辑 **/
        function edit(id) {
        	var url = '${ctx}/wxapi/reply/edit/${mode}';
        	var title = '添加回复';
        	if (id != null) {
        		url += ('?id=' + id);
        		title = '编辑回复';
        	}
        	url = 'url:' + url;
        	$.dialog($.extend(lhg, {
				width : '550px', height : '300px', 
				title : title, content : url
			}));
        }
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/wxapi/reply/lose/' + id,
        			success : function(response) {
        				if (response.result == 1) {
        					dptl.list(true);
        				}
        			}
        		});
        	});
        }
      	/** 图文 **/
      	function news(id) {
        	location.href = '${ctx}/wxapi/reply/news/init/' + id;
        }
    </script>
  </head>
  
  <body>
	 <form action="${ctx}/wxapi/reply/page" method="post">
	 	<input type="hidden" name="mode" value="${mode}" />
	    <div id="content">
    		<div class="flag"> 
	    		<div class="location">自定义回复</div>
	    		<div class="rightBtn">
	    			<a href="javascript:edit();">添加回复</a>
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




	