<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"16%", name:"F码", field:"fcode"},
        	{width:"10%", name:"创建者", field:"createUser"},
        	{width:"16%", name:"创建时间", field:"createTime"},
        	{width:"16%", name:"有效截至", field:"endTime"},
        	{width:"08%", name:"状态", field:"status"},
        	{width:"10%", name:"使用者", field:"userId"},
        	{width:"16%", name:"使用产品", field:"productId"},
        	{width:"08%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'sortWay' : 'status, create_time desc',
        	'process' : function(html, cell) {
        		if (cell.status == 0) {
        			html = html.replace("#status#", "未使用");
        		} else {
        			html = html.replace("#status#", "已使用");
        		}
        		html = html.replace("#createUser#", cell.manager != null ? cell.manager.linkman : '');
        		html = html.replace("#userId#", cell.user.realname);
        		html = html.replace("#productId#", "<a href='javascript:editProduct(\"" + cell.productId + "\")'>" +cell.product.name+ "</a>");
        		return html.replace("#id#", "<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>");
        	}
        });
        $(document).ready(function() {
        	dptl.init().list(true);
        });
        /** 新增 **/
        function add() {
        	var url = 'url:${ctx}/fcode/edit';
        	$.dialog($.extend(lhg, {
				width : '420px', height : '260px', 
				title : '生成F码', content : url
			}));
        }
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/fcode/lose/' + id,
        			success : function(response) {
        				if (response.result == 1) {
        					dptl.list(true);
        				}
        			}
        		});
        	});
        }
        
        /** 编辑产品页面 **/
        function editProduct(id) {
        	location.href = '${ctx}/product/edit?id=' + id;
        }
    </script>
  </head>
  
  <body>
	 <form action="${ctx}/fcode/list" method="post">
	    <div id="content">
    		<div class="flag bt10"> 
	    		<div class="location">F码列表</div>
	    		<div class="rightBtn">
	    			<a href="javascript:add();">生成F码</a>
	    		</div>		    		
	    	</div>
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>




	