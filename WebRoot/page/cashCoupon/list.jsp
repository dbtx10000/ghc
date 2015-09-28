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
			{width:"20%", name:"使用者", field:"userName"},
			{width:"20%", name:"产品名称", field:"productName"},
        	{width:"10%", name:"额度", field:"money"},
        	{width:"20%", name:"使用条件", field:"useCondition"},
        	{width:"10%", name:"状态", field:"status"},
        	{width:"20%", name:"有效截至时间", field:"vaildEndTime"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'sortWay' : 'create_time desc',
        	'fuzzies' : ['userName','productName'],
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
        	$(".auxi select,.auxi1 select").change(function() {
        		dptl.list(false);
        	});
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
	    <div id="content">
    		<div class="flag bt10"> 
	    		<div class="location">代金券列表</div>
	    	</div>
	    	<div class="tool">
	    		<div class="sear" style="width:500px">
	  				<input type="text" name="keyword" placeholder="输入关键词搜索"
	  					onkeydown="if (event.keyCode == 13) { dptl.list(false); }"/>
	  				<input  style="margin-left:200px;width:120px;" id="startTime" name="startDate" type="text" placeholder="有效期"  
	           		 onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" />
	  				<input  name="endDate" id="endTime" type="text" placeholder="有效期" style="margin-left:360px;width:120px;"
	  				 onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" />
	  				<span style="margin-left:340px">至</span>
	  				<a href="javascript:;" style="right: -84px" onclick="dptl.list(false);">搜 索</a>
	  			</div>
	  			<div class="auxi" style="margin-left: 590px">
		  			<select name="status" id="status" class="w140">
		  				<option value="">全部状态</option>
		  				<option value="0">未获取</option>
		  				<option value="1">未使用</option>
		  				<option value="2">已使用</option>
		  				<option value="3">以过期</option>
		  			</select>
		  		</div>
	    	</div>
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>