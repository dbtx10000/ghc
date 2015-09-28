<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"20%", name:"额度", field:"money"},
        	{width:"20%", name:"使用条件", field:"useCondition"},
        	{width:"20%", name:"状态", field:"status"},
        	{width:"20%", name:"有效截至时间", field:"vaildEndTime"},
        	{width:"20%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'sortWay' : 'status, create_time desc',
        	'process' : function(html, cell) {
        		var status = "";
        		switch(cell.status) {
        			case 0 : 
        				status = "<font color='#000'>未获取</font>"; 
        				break;
        			case 1 : 
        				status = "未使用"; 
        				break;
        			case 2 : 
        				status = "<font color='green'>已使用</font>"; 
        				break;
        			case 3 : 
        				status = "<font color='#900'>已过期</font>"; 
        				break;
        		}
        		html = html.replace("#status#", status);
        		html = html.replace("#money#", cell.money + "元");
        		html = html.replace("#useCondition#", cell.useCondition + "万元及以上可以使用");
        		return html.replace("#id#", "<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>");
        	}
        });
        $(document).ready(function() {
        	dptl.init().list(true);
        });
        /** 新增 **/
        function add() {
        	var url = 'url:${ctx}/cashCoupon/edit?userId=${user.id}';
        	$.dialog($.extend(lhg, {
				width : '420px', height : '260px', 
				title : '赠送代金券', content : url
			}));
        }
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/cashCoupon/lose/' + id,
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
	 <form action="${ctx}/cashCoupon/page" method="post">
	 <input type="hidden" id="userId" name="userId" value="${user.id }"/>
	    <div id="content">
    		<div class="flag bt10"> 
	    		<div class="location">代金券列表</div>
	    		<div class="rightBtn">
	    			<a href="javascript:history.go(-1);">返回</a>
	    			<a href="javascript:add();">赠送代金券</a>
	    		</div>		    		
	    	</div>
	    	<div class="tool">
	    		<font>
	    			用户名：${user.realname }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用户类型：
	    			<c:if test="${user.type == 1 }">VIP用户</c:if>
	    			<c:if test="${user.type == 2 }">普通用户</c:if>
	    			<c:if test="${user.type == 3 }">销售人员</c:if>
	    		</font>
	    	</div>
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>