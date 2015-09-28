<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"25%", name:"投资产品", field:"productName"},
        	{width:"15%", name:"投资时间", field:"investTime"},
        	{width:"10%", name:"投资金额", field:"investMoney"},
        	{width:"10%", name:"收益金额", field:"incomeMoney"},
        	{width:"20%", name:"收益期限", field:"incomeTime"},
        	{width:"08%", name:"状态", field:"status"},
        	{width:"12%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'process' : function(html, cell) {
        		var status = operate = "";
        		switch(cell.status) {
        			case 1 : status = "申请中"; break;
        			case 2 : status = "持有中"; break;
        			case 3 : status = "已结束"; break;
        		}
        		var unit = ['元', '元'];
        		if (cell.investMoney > 0) {
        			html = html.replace("#investMoney#", cell.investMoney + unit[1]);
        		}
        		if (cell.incomeMoney > 0) {
        			html = html.replace("#incomeMoney#", cell.incomeMoney + unit[0]);
        		}
        		if (cell.incomeType == 1) {
	        		var start_time = cell.incomeStartTime.substr(0, 10);
	        		var end_time = cell.incomeEndTime.substr(0, 10);
	       			html = html.replace("#incomeTime#", start_time + " 至 " + end_time);
        		} else {
        			if (cell.status == 1) {
		       			html = html.replace("#incomeTime#", cell.incomeDays + "天");
        			} else {
        				var start_time = cell.incomeStartTime.substr(0, 10);
    	        		var end_time = cell.incomeEndTime.substr(0, 10);
    	       			html = html.replace("#incomeTime#", start_time + " 至 " + end_time);
        			}
        		}
        		operate += "<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>&nbsp;";
        		operate += "&nbsp;<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>";
        		return html.replace("#id#", operate).replace("#status#", status);
        	}
        });
        $(document).ready(function() {
        	dptl.init().list(true);
        });
        /** 编辑 **/
        function edit(id) {
        	var url = 'url:${ctx}/users/user/invest/edit/${user.id}';
        	var title = '添加投资记录';
        	if (id != null) {
        		url += '?id=' + id;
        		title = '编辑投资记录';
        	}
        	$.dialog($.extend(lhg, {
				width : '500px', height : '540px', 
				title : title, content : url
			}));
        }
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/users/user/invest/lose/' + id,
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
	 <form action="${ctx}/users/user/invest/page" method="post">
	 	<input type="hidden" name="userId" value="${user.id}" />
	    <div id="content">
    		<div class="flag"> 
	    		<div class="location">投资记录列表</div>
	    		<div class="rightBtn">
	    			<a href="javascript:history.go(-1);">返回</a>
	    			<a href="javascript:edit();">添加投资记录</a>
	    		</div>		    		
	    	</div>
	    	<div class="tool">
		  		用户姓名：${user.realname}&nbsp;&nbsp;&nbsp;&nbsp;
		  		&nbsp;&nbsp;&nbsp;&nbsp;手机号码：${user.mobile}
	    	</div>
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>




	