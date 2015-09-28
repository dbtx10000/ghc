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
        	{width:"13%", name:"订单编号", field:"id"},
        	{width:"16%", name:"投资产品", field:"productId"},
        	{width:"07%", name:"下单者", field:"userId"},
        	{width:"14%", name:"下单时间", field:"createTime"},
        	{width:"08%", name:"投资额", field:"investMoney"},
        	{width:"10%", name:"支付金额", field:"payMoney"},
        	{width:"12%", name:"支付单号", field:"payNo"},
        	{width:"07%", name:"状态", field:"status"},
        	{width:"13%", name:"操作", field:"operate"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns, 'fuzzies' : ['id'],
        	'sortWay' : 'create_time desc',
        	'process' : function(html, cell) {
        		var status = "";
        		var operate = ""; 
        		if (cell.status == -1) {
        			status = "等待支付";
        			if(productType!=2){
        				operate += "<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>&nbsp;&nbsp;";
        			}
        			operate += "<a href='javascript:close(\"" + cell.id + "\")'>关闭</a>&nbsp;&nbsp;";
        		} else if (cell.status == 0) {
        			status = "支付定金";
        			if(productType!=2){
        				operate += "<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>&nbsp;&nbsp;";
        			}
        			operate += "<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>&nbsp;&nbsp;";
        			operate += "<a href='javascript:close(\"" + cell.id + "\")'>关闭</a>&nbsp;&nbsp;";
        		} else if (cell.status == 1) {
        			status = "支付成功";
        		} else {
        			status = "已关闭";
        		}
        		operate += "<a href='javascript:show(\"" + cell.id + "\")'>查看</a>";
        		html = html.replace("#investMoney#", cell.investMoney + "元");
        		html = html.replace("#status#", status);
        		if (cell.productType == 1) {
	        		html = html.replace("#payMoney#", parseInt(cell.investMoney - cell.useIntegral - cell.cashMoney) + '元');
        		} else {
        			if (cell.actualMoney > 0) {
		        		html = html.replace("#payMoney#", cell.actualMoney + '元');
        			} else {
		        		html = html.replace("#payMoney#", cell.useIntegral + '金币');
        			}
        		}
        		html = html.replace("#userId#", "<a href='${ctx}/users/user/show/" + cell.userId + "'>" + cell!=null&&cell.user!=null&&typeof(cell.user.realname) != "undefined"?cell.user.realname:"" + "</a>");
        		html = html.replace("#productId#", "<a href='javascript:editProduct(\""+cell.productId+"\","+cell.productType+")'>" +cell.product.name+ "</a>");
        		return html.replace("#operate#", operate);
        	}
        });
        $(document).ready(function() {
        	dptl.init().list(true);
        	$(".auxi select,.auxi1 select").change(function() {
        		dptl.list(false);
        	});
        });
        /** 编辑 **/
        function edit(id) {
        	var url = 'url:${ctx}/order/edit?id=' + id;
        	$.dialog($.extend(lhg, {
				width : '520px', height : '380px', 
				title : '编辑订单', content : url
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
        
        /** 关闭 **/
        function close(id) {
        	$.lhg.confirm('是否确认关闭订单？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/order/close/' + id,
        			success : function(response) {
        				if (response.result == 1) {
        					dptl.list(true);
        				}
        			}
        		});
        	});
        }
        
        /** 编辑产品页面 **/
        function editProduct(id,producttype) {
        	if(producttype==2){
	        	location.href = '${ctx}/product/specialEdit?id=' + id;
	        }else{
	        	location.href = '${ctx}/product/edit?id=' + id;
	        }
        }
        
        /** 查看订单 **/
        function show(id) {
        	location.href = '${ctx}/order/show?id=' + id;
        }
        
        /** 导出订单 **/
        function exportOrder(){
        	$("#queryForm").attr("target","_blank").attr("action","${ctx}/order/export").submit();
        	$("#queryForm").removeAttr("target","_blank").attr("action","${ctx}/order/list");
        }
    </script>
  </head>
  
  <body>
	 <form id="queryForm" action="${ctx}/order/list" method="post">
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
	    		<div class="location">订单列表</div>
	    			<div class="rightBtn">
	    				<a href="javascript:exportOrder()">订单导出</a>
			    		<c:if test="${productId != null || userId != null}">
				    		<a href="javascript:history.go(-1);">返回</a>
						</c:if>
					</div>
	    	</div>
	    	<div class="tool">
	    		<div class="sear" style="width:500px">
	  				<input type="text" name="keyword" placeholder="输入订单号搜索"
	  					onkeydown="if (event.keyCode == 13) { dptl.list(false); }"/>
	  				<input  style="margin-left:200px;width:120px;" id="startTime" name="startDate" type="text" placeholder="下单时间"  
	           		 onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" />
	  				<input  name="endDate" id="endTime" type="text" placeholder="下单时间" style="margin-left:360px;width:120px;"
	  				 onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" />
	  				<span style="margin-left:340px">至</span>
	  				<a href="javascript:;" style="right: -84px" onclick="dptl.list(false);">搜 索</a>
	  			</div>
	  			<div class="auxi" style="margin-left: 590px">
		  			<select name="status" id="status" class="w140">
		  				<option value="">全部状态</option>
		  				<option value="-1">等待支付</option>
		  				<!-- <option value="0">支付定金</option> -->
		  				<option value="1">支付成功</option>
		  				<option value="2">已关闭</option>
		  				<option value="3">等待支付+支付成功</option>
		  			</select>
		  		</div>
		  		<c:if test="${!empty(products)}">
		  			<div class="auxi1" style="margin-left: 700px">
			  			<select name="productId" id="productId" class="w140">
			  				<option value="">全部产品</option>
			  				<c:forEach var="product" items="${products}">
			  					<option value="${product.id}">${product.name}</option>
			  				</c:forEach>
			  			</select>
			  		</div>
		  		</c:if>
	    	</div>
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>




	