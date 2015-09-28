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
        	{width:"10%", name:"银行名称", field:"openBankName"},
        	{width:"20%", name:"银行卡号", field:"cardNo"},
        	{width:"10%", name:"姓名", field:"userName"},
        	{width:"20%", name:"身份证号", field:"certId"},
        	{width:"10%", name:"手机号", field:"mobile"},
        	{width:"10%", name:"类型", field:"status"},
        	{width:"20%", name:"操作时间", field:"createTime"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'fuzzies' : ['cardNo'],
        	'sortWay' : 'create_time desc',
        	'process' : function(html, cell) {
        		if (cell.status == 1) {
	        		html = html.replace("#status#", "绑定");
        		}else if (cell.status == 2) {
	        		html = html.replace("#status#", "解绑");
        		}
    			return html;
        	}
        });

        $(document).ready(function() {
        	dptl.init().list(true);
        	$(".auxi select").change(function() {
        		dptl.list(true);
        	});
        });
    </script>
  </head>
  
  <body>
  	<form action="${ctx}/cardBindRecord/page" method="post">
    	<div id="content">
	    	<div class="flag"> 
		    	<div class="location">银行卡记录列表</div>   		
		 	</div>	
	    	<div class="tool">
	    		<div class="sear" style="width:500px">
	    			<input type="text" name="keyword" placeholder="输入银行卡号进行搜索"
	  					onkeydown="if (event.keyCode == 13) { dptl.list(false); }"/>
	    			<input  style="margin-left:200px;width:120px;" id="startTime" name="startDate" type="text" placeholder="操作时间"  
	           		 onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" />
	  				<input  name="endDate" id="endTime" type="text" placeholder="操作时间" style="margin-left:350px;width:120px;"
	  				 onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" />
	  				<span style="margin-left:335px">至</span>
	  				<a href="javascript:;" style="right: -75px" onclick="dptl.list(false);">搜 索</a>
	  			</div>
  			<div class="auxi" style="margin-left:580px">
	  			<select name=status id="status" class="w120">
	  				<option value="">全部类型</option>
					<option value="1">绑定</option>
					<option value="2">解绑</option>
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