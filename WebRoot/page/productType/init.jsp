<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"20%", name:"分类名称", field:"name"},
        	{width:"20%", name:"添加时间", field:"createTime"},
        	{width:"20%", name:"产品数量", field:"productCount"},
        	{width:"20%", name:"排序", field:"seq"},
        	{width:"20%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'sortWay' : 'seq, create_time desc',
        	'process' : function(html, cell) {
        		html = html.replace("#productCount#", 
        		"<a href='${ctx}/product/init?typeId=" + cell.id + "'>" + cell.productCount + "</a>");
        		return html.replace("#id#", "<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>" +
        			"&nbsp;&nbsp;<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>");
        	}
        });
        $(document).ready(function() {
        	dptl.init().list(true);
        });
        /** 编辑 **/
        function edit(id) {
        	var url = '${ctx}/productType/edit';
        	var title = '添加分类';
        	if (id != null) {
        		url += ('?id=' + id);
        		title = '编辑分类';
        	}
        	url = 'url:' + url;
        	$.dialog($.extend(lhg, {
				width : '550px', height : '400px', 
				title : title, content : url
			}));
        }
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/productType/lose/' + id,
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
	 <form action="${ctx}/productType/list" method="post">
	    <div id="content">
    		<div class="flag bt10"> 
	    		<div class="location">产品分类列表</div>
	    		<div class="rightBtn">
	    			<a href="javascript:edit();">添加分类</a>
	    		</div>		    		
	    	</div>
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>




	