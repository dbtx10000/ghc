<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript" src="${js}/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">
    	var columns = [
        	{width:"15%", name:"订单编号", field:"orderNo"},
        	{width:"12%", name:"用户账号", field:"username"},
        	{width:"08%", name:"用户姓名", field:"realname"},
        	{width:"15%", name:"订单名称", field:"giftname"},
        	{width:"07%", name:"换购金币", field:"integral"},
        	{width:"07%", name:"换购数量", field:"nums"},
        	{width:"14%", name:"下单时间", field:"createTime"},
        	{width:"07%", name:"状态", field:"status"},
        	{width:"15%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns, 'sortWay' : 'create_time desc',
        	'fuzzies' : ['orderNo','username','mobile','realname','giftname'],
        	'process' : function(html, cell) {
        		var operate = "<a href='javascript:show(" + cell.id + ")'>查看</a>";
        		if (cell.status == 0) {
        			html = html.replace("#status#", "已关闭");
        		} else {
        			if (cell.gifttype == 1) {
	        			if (cell.status == 1) {
	        				html = html.replace("#status#", "<font color='red'>未发货</font>");
	        				operate += "&nbsp;&nbsp;<a href='javascript:send(" + cell.id + ")'>发货</a>";
	        				operate += "&nbsp;&nbsp;<a href='javascript:icls(" + cell.id + ")'>关闭</a>";
	        			} else if (cell.status == 2) {
	        				html = html.replace("#status#", "<font color='black'>已发货</font>");
	        				operate += "&nbsp;&nbsp;<a href='javascript:sget(" + cell.id + ")'>签收</a>";
	        			} else {
	        				html = html.replace("#status#", "<font color='green'>已收货</font>");
	        			}
	        		} else if (cell.gifttype == 2) {
	        			if (cell.status == 1) {
	        				html = html.replace("#status#", "未使用");
	        				// operate += "&nbsp;&nbsp;<a href='javascript:lose(" + cell.id + ")'>关闭</a>";
	        			} else {
	        				html = html.replace("#status#", "已使用");
	        			}
	        		}
        		}
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
        /** 发货 **/
        function send(id) {
        	$.lhg.confirm('是否确认发货？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/gifts/order/save',
        			data : { id : id, status : 2},
        			success : function(response) {
        				if (response.result == 1) {
        					dptl.list(true);
        				}
        			}
        		});
        	});
        }
        /** 发货 **/
        function sget(id) {
        	$.lhg.confirm('是否确认签收？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/gifts/order/save',
        			data : { id : id, status : 3},
        			success : function(response) {
        				if (response.result == 1) {
        					dptl.list(true);
        				}
        			}
        		});
        	});
        }
        /** 关闭 **/
        function icls(id) {
        	$.lhg.confirm('是否确认关闭订单？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/gifts/order/icls/' + id,
        			success : function(response) {
        				if (response.result == 1) {
        					dptl.list(true);
        				}
        			}
        		});
        	});
        }
        /** 查看**/
        function show(id) {
        	location.href = '${ctx}/gifts/order/show?id=' + id;
        }
        /** 导出用户 **/
        function exportOrder() {
        	$("#queryForm").attr("target", "_blank").attr("action", "${ctx}/gifts/order/export").submit();
        	$("#queryForm").removeAttr("target", "_blank").attr("action", "${ctx}/gifts/order/page");
        }
    </script>
  </head>
  
  <body>
	 <form id="queryForm" action="${ctx}/gifts/order/page" method="post">
	    <div id="content">
    		<div class="flag"> 
	    		<div class="location">订单列表</div>
	    		<div class="rightBtn">
	    			<a href="javascript:exportOrder()">订单导出</a>
	    		</div>
	    	</div>		    	
	    	<div class="tool">
	    		<div class="sear" style="width:500px">
	  				<input type="text" name="keyword" placeholder="输入关键字搜索"
	  					onkeydown="if (event.keyCode == 13) { dptl.list(false); }"/>
	  				<input  style="margin-left:200px;width:120px;" id="startTime" name="startDate" type="text" placeholder="下单时间"  
	           		 onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" />
	  				<input  name="endDate" id="endTime" type="text" placeholder="下单时间" style="margin-left:360px;width:120px;"
	  				 onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" />
	  				<span style="margin-left:340px">至</span>
	  				<a href="javascript:;" style="right:-85px" onclick="dptl.list(false);">搜 索</a>
	  			</div>
	    	</div>
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>




	