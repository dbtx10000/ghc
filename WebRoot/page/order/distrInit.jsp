<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript" src="${js}/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">
   		var productType = parseInt('${productType}');
    	var columns = [
        	{width:"10%", name:"产品类型", field:"productType"},
        	{width:"12%", name:"产品名称", field:"productName"},
        	{width:"07%", name:"姓名", field:"userName"},
        	{width:"09%", name:"开户行", field:"openBankId"},
        	{width:"15%", name:"银行卡号", field:"cardNo"},
        	{width:"07%", name:"投资金额", field:"investMoney"},
        	{width:"07%", name:"支付金额", field:"actualMoney"},
        	{width:"07%", name:"收益金额", field:"incomeMoney"},
        	{width:"09%", name:"还款金额", field:"payMoney"},
        	{width:"8%", name:"返款日", field:"repayTime"},
        	{width:"15%", name:"操作", field:"operate"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns, 'fuzzies' : ['id'],
        	'sortWay' : 'create_time desc',
        	'process' : function(html, cell) {
        		var operate = "",actualMoney="";
        		html = html.replace("#userName#", cell.order.userLinkman);
        		html = html.replace("#cardNo#", cell.order.cardNo);
        		html = html.replace("#openBankId#", cell.order.openBankId);
        		html = html.replace("#investMoney#", cell.investMoney + "元");
        		html = html.replace("#incomeMoney#", cell.incomeMoney + "元");
        		if (cell.order.productType == 1) {
        			actualMoney = parseInt(cell.order.investMoney - cell.order.useIntegral - cell.order.cashMoney);
	        		html = html.replace("#actualMoney#",  actualMoney + '元');
        		} else {
        			if (cell.order.actualMoney > 0) {
        				actualMoney = cell.order.actualMoney;
		        		html = html.replace("#actualMoney#", cell.order.actualMoney + '元');
        			} else {
        				actualMoney = 0;
		        		html = html.replace("#actualMoney#", cell.order.useIntegral + '金币');
        			}
        		}
        		var payMoney = actualMoney + cell.incomeMoney;
        		html = html.replace("#payMoney#", payMoney.toFixed(2) + "元");
        		if(cell.repayTime != null) {
        			html = html.replace("#repayTime#",cell.repayTime.substr(0,10));
        		}
        		operate += "<a href='javascript:show(\"" + cell.id + "\",1)'>推送消息</a>&nbsp;"+
        		"<a href='javascript:show(\""+cell.id+"\",2)'>查看</a>";
        		return html.replace("#operate#", operate);
        	}
        });
        
        
        $(document).ready(function() {
        	dptl.init().list(true);
        	$(".auxi1 select").change(function() {
        		dptl.list(false);
        	});
        	$("#type").change(function() {
        	var typeId = $("#type").find("option:selected").val();
        	if(typeId != '') {
        		$.LD.ajax({
        			url : '${ctx}/distr/getProduct?typeId='+typeId,
        			success : function(response) {
        				if (response.result == 1) {
        					if(response.data != null) {
        						$("#productId").empty();
	        					jQuery.each(response.data, function(i,item){     
	                				$("#productId").append("<option value='"+item.id+"'>"+item.name+"</option>");    
	            				});
        					}
        				}
        			}
        		});
        	} else {
        		$("#productId").empty();
        		$("#productId").append("<option value = ''>选择产品</option>");
        		dptl.list(false);
        	}
        });
       });
       
        
        /** 查看 **/
        function show(id,type) {
        	var url = 'url:${ctx}/distr/distrInput?id='+id+'&type='+type;
        	var title = "推送",height = "480px";
        	if(type==2) {
        		title = "查看";
        		height = "450px";
        	}
        	$.dialog($.extend(lhg, {
				width : '520px', height : height,
				title : title, content : url
			}));
        }
        
        /** 导出数据 **/
        function exportData(){
        	$("#queryForm").attr("target","_blank").attr("action","${ctx}/distr/export").submit();
        	$("#queryForm").removeAttr("target","_blank").attr("action","${ctx}/distr/list");
        }
        
        function sendAll() {
        	var productId = $("#productId").val();
        	var startTime = $("#startTime").val();
        	var endTime = $("#endTime").val();
        	$.lhg.confirm('是否确认推送收益到账消息？',function() { 
	        		$.LD.ajax({
	        			url : '${ctx}/distr/sendAll?productId='+productId+'&startTime='+startTime+'&endTime='+endTime,
	        			success : function(response) {
	        				if (response.result == 1) {
	        					$.lhg.confirm('推送成功');
	        				}
	        			}
	        		});
	        	});
        }
    </script>
    
 <style type="text/css">

</style>

 </head>
  
  <body>
	 <form id="queryForm" action="${ctx}/distr/list" method="post">
	 	<c:if test="${productId != null}">
	 		<input type="hidden" id="productId" name="productId" value="${productId}"/>
	 	</c:if>
	 	<c:if test="${userId != null}">
	 		<input type="hidden" id="userId" name="userId" value="${userId}"/>
	 	</c:if>
	 	<c:if test="${productType != null}">
	 		<input type="hidden" id="productType" name="productType" value="${productType}"/>
	 	</c:if>
	    <div id="content">
    		<div class="flag bt10"> 
	    		<div class="location">分配管理</div>
	    			<div class="rightBtn">
	    				<a href="javascript:exportData()">数据导出</a>
				    	<a href="javascript:sendAll();">全部推送</a>
					</div>
	    	</div>
	    	
	    	<div class="tool">
	    		<div class="auxi" style="margin-left: 400px;">
		  			<select name="type" id="type" class="w140">
		  				<option value="">选择类型</option>
		  				<c:forEach items="${productTypes}" var="type2">
		  					<option value="${type2.id}">${type2.name}</option>
		  				</c:forEach>
		  			</select>
		  		</div>
		  		
    			<div  class="auxi1" style="margin-left: 510px;">
		  			<select name="productId" id="productId" class="w140">
		  				<option value="">选择产品</option>
		  			</select>
		  		</div>
		  		
	    		<div class="sear" style="width:390px;">
	  			<input type="text" style="width: 125px;margin-left: 2px;" id="startTime" name="startTime" maxlength="20"
						value='<fmt:formatDate pattern='yyyy-MM-dd' value="${object.startTime}"/>' placeholder="请输入开始时间" 
						onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd',readOnly:true})"/>
						<span style="margin-left: 142px;">至</span>
	    		<input type="text" style="width: 125px;margin-left: 157px;" id="endTime" name="endTime" maxlength="20"
					value='<fmt:formatDate pattern='yyyy-MM-dd' value="${object.endTime}"/>' placeholder="请输入结束时间" 
					onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',dateFmt:'yyyy-MM-dd',readOnly:true})"/>
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




	