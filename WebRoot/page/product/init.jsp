<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"18%", name:"产品名称", field:"name"},
        	{width:"08%", name:"产品分类", field:"typeId"},
        	{width:"08%", name:"总投资额", field:"totalMoney"},
        	{width:"08%", name:"剩余可投", field:"surplusMoney"},
        	{width:"08%", name:"进度", field:"progress"},
        	{width:"08%", name:"定购订单", field:"orderCount"},
        	{width:"08%", name:"购买方式", field:"buyType"},
        	{width:"08%", name:"状态", field:"status"},
        	{width:"26%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'fuzzies' : ['name'],
        	'process' : function(html, cell) {
        		var buyType = status = "";
        		if (cell.buyType == 1) {
        			buyType = "开放购买";
        		} else {
        			buyType = "F码购买";
        		}
        		if (cell.status == 0) {
        			status = "未开始";
        		} else if (cell.status == 1) {
        			status = "认购中";
        		} else if (cell.status == 2) {
        			status = "收益中";
        		} else {
        			status = "已结束";
        		}
        		html = html.replace("#status#", status);
        		html = html.replace("#buyType#", buyType);
        		html = html.replace("#typeId#", cell.productType.name);
        		if (cell.smallProduct == 0) {
        			html = html.replace("#totalMoney#", cell.totalMoney + "万元");
        			html = html.replace("#surplusMoney#", cell.surplusMoney + "万元");
        		} else {
	        		if(cell.type==2){
	        			html = html.replace("#totalMoney#", "无");
	        			html = html.replace("#surplusMoney#","无");
	        			html = html.replace("#progress#","无");
	        		}else{
	        			html = html.replace("#totalMoney#", cell.totalMoney + "元");
        				html = html.replace("#surplusMoney#", cell.surplusMoney + "元");
	        		}
        		}
        		html = html.replace("#orderCount#", "<a href='javascript:orderInit(\""+cell.id+"\","+cell.type+")'>" +cell.orderCount+ "</a>");
        		return html.replace("#id#", 
        			"<a href='${ctx}/wap/product/detail?id=" + cell.id + "' target='_blank'>预览</a>" +
        			"&nbsp;&nbsp;<a href='javascript:send(\""+cell.id+"\",1)'>产品上线推送</a>" +
        			"&nbsp;&nbsp;<a href='javascript:send(\""+cell.id+"\",2)'>收益到账推送</a>" +
        			"&nbsp;&nbsp;<a href='javascript:edit(\""+cell.id+"\","+cell.type+")'>编辑</a>&nbsp;&nbsp;" +
        			"<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>");
        	}
        });
        $(document).ready(function() {
        	dptl.init().list(true);
        });
        /** 新增 **/
        function add() {
        	location.href = '${ctx}/product/edit';
        }
        /** 编辑 **/
        function edit(id,type) {
	        if(type==2){
	        	location.href = '${ctx}/product/specialEdit?id=' + id;
	        }else{
	        	location.href = '${ctx}/product/edit?id=' + id;
	        }
        }
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/product/lose/' + id,
        			success : function(response) {
        				if (response.result == 1) {
        					dptl.list(true);
        				}
        			}
        		});
        	});
        }
        
        /** 推送产品上线消息模版 **/
        function send(id, type) {
        	if (type == 1) {
        		$.lhg.confirm('是否确认推送产品上线消息？',function() { 
	        		$.LD.ajax({
	        			url : '${ctx}/product/send/1?id=' + id,
	        			success : function(response) {
	        				if (response.result == 1) {
	        					$.lhg.confirm('推送成功');
	        				}
	        			}
	        		});
	        	});
        	} else {
        		$.lhg.confirm('是否确认推送收益到账消息？',function() { 
	        		$.LD.ajax({
	        			url : '${ctx}/product/send/2?id=' + id,
	        			success : function(response) {
	        				if (response.result == 1) {
	        					$.lhg.confirm('推送成功');
	        				}
	        			}
	        		});
	        	});
        	}
        }
        
        /** 定购订单页面 **/
        function orderInit(id,type) {
        	location.href = "${ctx}/order/init?productType="+type+"&productId=" + id;
        }
    </script>
  </head>
  
  <body>
	 <form action="${ctx}/product/list" method="post">
	 <c:if test="${typeId != null}"><input type="hidden" id="typeId" name="typeId" value="${typeId}" /></c:if>
	    <input type="hidden" id="type" name="type" value="${type}">
	    <div id="content">
    		<div class="flag"> 
	    		<div class="location">产品列表&nbsp;&nbsp;<a href="${ctx}/wap/product/list" target="_blank">http://<script>document.write(location.host);</script>${ctx}/wap/product/list</a></div>
	    		<div class="rightBtn">
	    			<c:if test="${type == null}"><a href="javascript:history.go(-1);">返回</a></c:if>
	    			<a href="javascript:add();">添加产品</a>
	    		</div>		    		
	    	</div>		    	
	    	<div class="tool">
	    		<div class="sear">
	  				<input type="text" name="keyword" placeholder="输入产品名称搜索"
	  					onkeydown="if (event.keyCode == 13) { dptl.list(false); }"/>
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




	