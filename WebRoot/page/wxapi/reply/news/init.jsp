<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"25%", name:"标题", field:"title"},
        	{width:"25%", name:"封面", field:"picUrl"},
        	{width:"25%", name:"类型", field:"type"},
        	{width:"25%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'process' : function(html, cell) {
        		if (cell.type == 1) {
        			html = html.replace("#type#", "外链");
        		} else if (cell.type == 2) {
        			html = html.replace("#type#", "图文");
        		}
        		var image = "<a href='javascript:show(\"" + cell.picUrl + "\");'>" +
        			"<img style='margin-top:8px' src='" + cell.picUrl + "' width='60' height='60'/></a>";
        		html = html.replace("#picUrl#", image);
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
        /** 编辑 **/
        function edit(id) {
        	var url = '${ctx}/wxapi/reply/news/edit/${replyId}';
        	if (id != null) {
        		url += ('?id=' + id);
        	}
        	location.href = url;
        }
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/wxapi/reply/news/lose/' + id,
        			success : function(response) {
        				if (response.result == 1) {
        					dptl.list(true);
        				}
        			}
        		});
        	});
        }
        /** 预览 **/
        function show(image) {
        	$.dialog($.extend(lhg, { title : '预览', lock : true, 
			    content : '<img src="' + image + '" width="640" height="300" />'
			}));
        }
    </script>
  </head>
  
  <body>
	 <form action="${ctx}/wxapi/reply/news/page" method="post">
	 	<input type="hidden" name="replyId" value="${replyId}" />
	    <div id="content">
    		<div class="flag bt10"> 
	    		<div class="location">图文列表</div>
	    		<div class="rightBtn">
	    			<a href="javascript:edit();">添加图文</a>
	    		</div>		
	    	</div>		    	
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>




	