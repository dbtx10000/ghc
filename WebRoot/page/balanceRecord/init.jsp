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
        	{width:"10%", name:"类型", field:"type"},
        	{width:"10%", name:"交易金额", field:"money"},
        	{width:"10%", name:"当前余额", field:"afterBalance"},
            {width:"20%", name:"交易时间", field:"createTime"},
        	{width:"10%", name:"状态", field:"status"},
        	{width:"20%", name:"备注", field:"note"},
        	{width:"20%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'sortWay' : 'create_time desc',
        	'process' : function(html, cell) {
        		var operate=statusName='';
        		if (cell.type == 1) {
	        		html = html.replace("#type#", "充值");
        		}else if (cell.type == 2) {
	        		html = html.replace("#type#", "提现");
        		}else if (cell.type == 3|| cell.type == 4) {
	        		html = html.replace("#type#", "收款");
        		}else if (cell.type == 5) {
	        		html = html.replace("#type#", "购买产品");
        		}
        		if(cell.status==1){
        			statusName="提交申请";
        		}else if(cell.status==2){
        			statusName="处理中";
        		}else if(cell.status==3){
        			statusName="处理成功";
        		}else if(cell.status==4){
        			statusName="处理失败";
        		}
        		html = html.replace("#status#", statusName);
        		operate += "<a href='javascript:view(\"" + cell.id + "\")'>查看</a>";
    			return html.replace("#id#", operate);
        	}
        });

        $(document).ready(function() {
        	dptl.init().list(true);
        	$(".auxi select").change(function() {
        		dptl.list(true);
        	});
        });
        
        /** 查看 **/
        function view(id) {
        	var url = 'url:${ctx}/balanceRecord/view?id=' + id;
        	$.dialog($.extend(lhg, {
				width : '400px', height : '200px', 
				title : '交易详情', content : url
			}));
        }
    </script>
  </head>
  
  <body>
  	<form action="${ctx}/balanceRecord/page" method="post">
    	<div id="content">
	    	<div class="flag"> 
		    	<div class="location">余额记录列表</div>   		
		 	</div>	
	    	<div class="tool">
	    		<div class="sear" style="width:500px">
	    			<input  style="margin-left:0px;width:120px;" id="startTime" name="startDate" type="text" placeholder="交易时间"  
	           		 onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" />
	  				<input  name="endDate" id="endTime" type="text" placeholder="交易时间" style="margin-left:150px;width:120px;"
	  				 onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" />
	  				<span style="margin-left:135px">至</span>
	  				<a href="javascript:;" style="right: 130px" onclick="dptl.list(false);">搜 索</a>
	  			</div>
  			<div class="auxi" style="margin-left:380px">
	  			<select name=type id="type" class="w120">
	  				<option value="">全部类型</option>
					<option value="1">充值</option>
					<option value="2">提现</option>
					<option value="3">收益回款</option>
					<option value="4">本金回款</option>
					<option value="5">购买产品</option>
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