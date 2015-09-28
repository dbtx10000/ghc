<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"10%", name:"用户类型", field:"type"},
        	{width:"06%", name:"姓名", field:"realname"},
        	{width:"09%", name:"手机", field:"mobile"},
        	{width:"06%", name:"银行卡", field:"cards"},
        	{width:"07%", name:"总资产", field:"assets"},
        	{width:"07%", name:"总收益", field:"income"},
        	{width:"07%", name:"金币数", field:"integral"},
        	{width:"06%", name:"代金券", field:"cashCoupons"},
        	{width:"07%", name:"订单数", field:"orders"},
        	{width:"07%", name:"好友数", field:"friend"},
        	{width:"06%", name:"状态", field:"status"},
        	{width:"22%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'fuzzies' : ['username','realname'],
        	'process' : function(html, cell) {
        		return process(html, cell);
        	}
        });
       
        function process(html, cell) {
        	var status = operate = type = "";
       		/* operate += "<a href='${ctx}/users/user/invest/init/" + cell.id + "'>投资记录</a>&nbsp;&nbsp;";
       		operate += "<a href='javascript:give(\"" + cell.id + "\");'>赠送金币</a>&nbsp;&nbsp;";
       		operate += "<a href='javascript:edit(\"" + cell.id + "\");'>编辑</a>&nbsp;&nbsp;"; */
       		switch (cell.type) {
       			case 1 : type = "VIP用户"; break;
       			case 2 : type = "普通用户"; break;
       			case 3 : type = "销售人员"; break;
       		}
       		html = html.replace("#type#", type);
        	html = html.replace("#cards#", "<a href='${ctx}/cardBind/init?userId=" + cell.id + "'>" + cell.cards + "</a>");
       		html = html.replace("#orders#", "<a href='${ctx}/order/init?userId=" + cell.id + "'>" + cell.orders + "</a>");
       		var unit = ['元', '元'];
       		var assets = cell.assets, income = cell.income;
       		if (assets > 0) {
       			html = html.replace("#assets#", assets + unit[1]);
       		}
       		if (income > 0) {
       			income = income.toFixed(2);
       			html = html.replace("#income#", income + unit[0]);
       		}
       		switch(cell.status) {
       			case 0 : 
       				status = "<font color='#000'>未激活</font>"; 
       				break;
       			case 1 : 
       				status = "待审核"; 
       				break;
       			case 2 : 
       				status = "使用中"; 
       				break;
       			case 3 : 
       				status = "<font color='#900'>已禁用</font>"; 
       				break;
       		}
       		operate += "<a href='javascript: toSaler(\"" + cell.id + "\")'>成为销售</a>";
       		html = html.replace("#cashCoupons#", "<a href='javascript:cashCouponInit(\"" + cell.id + "\");'>" + cell.cashCoupons + "</a>");
       		var friend = cell.friend;
       		if (cell.pid != null && cell.pid != '') {
       			friend ++;
       		}
       		html = html.replace("#friend#", "<a href='javascript:friendInit(\"" + cell.id + "\");'>" + friend + "</a>");
       		return html.replace("#id#", operate).replace("#status#", status);
        }
        $(document).ready(function() {
        	dptl.init().list(true);
        	if ('${pid}' != '' && '${parent.pid}' != '') {
	        	parent_dptl.init().list(true);
        	}
        	$(".auxi select,.auxi1 select").change(function() {
        		dptl.list(false);
        	});
        });
        
        /** 赠送金币 **/
        function give(id) {
        	var url = '${ctx}/users/user/give?id=' + id;
        	var title = '赠送金币';
        	url = 'url:' + url;
        	$.dialog($.extend(lhg, {
				width : '360px', height : '180px', 
				title : title, content : url
			}));
        }
        
        /** 代金券列表 **/
        function cashCouponInit(id) {
        	location.href = '${ctx}/cashCoupon/init?userId=' + id;
        }
        
        /** 好友列表 **/
        function friendInit(id) {
        	location.href = '${ctx}/users/user/init?pid=' + id;
        }
        
        function toSaler(id) {
        		$.lhg.confirm('确定要成为销售？',function() {
        		$.LD.ajax({
        			url : '${ctx}/saler/beSaler?userId=' + id,
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
   	<div id="content">
    	<div class="flag bt10"> 
	    	<div class="location">用户列表</div>
	    	<div class="rightBtn">
	    		<a href="javascript: history.go(-1);">返回</a>
	    	</div>		    		
		</div>
		<c:if test="${pid != null && !empty(parent.pid)}">
			<form id="parent_form" action="${ctx}/users/user/only?id=${parent.pid}" method="post">
				<div class="tool" style="padding-bottom: 0px;">邀请人信息：</div>
				<div class="data">
		    		<table id="parent_list_table" class="w100p"></table>
		    	</div>
		    </form>
	    </c:if>
    	<form id="queryForm" action="${ctx}/saler/page/vip" method="post">
  			<c:if test="${pid != null}"><input type="hidden" id="pid" name="pid" value="${pid}" /></c:if>
	    	<div class="tool">
	    		<div class="sear">
	  				<input type="text" name="keyword" placeholder="输入关键字进行搜索"
	  					onkeydown="if (event.keyCode == 13) { dptl.list(false); }"/>
	  				<a href="javascript:;" onclick="dptl.list(false);">搜 索</a>
	  			</div>
	  			<div class="auxi">
	  				<select name="status" class="w120">
		  				<option value="">全部状态</option>
		  				<option value="0">未激活</option>
		  				<c:if test="${unv == 'true'}">
		  					<option value="1">待审核</option>
		  				</c:if>
		  				<option value="2">使用中</option>
		  				<option value="3">已禁用</option>
		  			</select>
	  			</div>
	  			<div class="auxi1">
	  				<select name="type" class="w120">
		  				<option value="">全部类型</option>
		  				<option value="1">VIP用户</option>
		  				<option value="2">普通用户</option>
		  				<option value="3">销售员</option>
		  			</select>
	  			</div>
	    	</div>
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
	    </form>
   	</div>
  </body>
</html>