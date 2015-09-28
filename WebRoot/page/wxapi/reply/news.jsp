<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <style type="text/css">
    	.block_table {
    		width: 99%; 
    		height: 32px;
			line-height: 32px;
			margin-left: 0.5%; 
    		margin: 10px 0 0 0;
			font-size: 12px;
    	}
    	.block_table li.tab {
    		float: left;
    		width: 200px;
    		border-radius: 32px 32px 0 0;
    		border: 1px solid #e1e4e9;
    		text-align: center;
    		border-bottom: none;
    		cursor: pointer;
    		position: relative;
    	}
    	.block_table li.sel {
    		background-color: #f5f5f5;
    	}
    	.block_table li.btn {
    		background: #ed5565; 
    		border-bottom: 3px #da4453 solid; 
    		color: #fff; 
    		padding: 3px 16px;
    		height: 22px;
    		line-height: 22px;
    		text-align: center;
    		float: right;
    		font-size: 12px;
    		cursor: pointer;
    	}
    	.input_table {
    		width: 99%; 
			margin-left: 0.5%; 
    		border: 1px solid #e1e4e9; 
			background-color: #f5f5f5;
			font-size: 12px;
			padding: 10px 0;
			margin-top: 1px;
    	}
    </style>
    <script type="text/javascript">
    	function change(num) {
    		var url = '${ctx}/wxapi/reply/init/${mode}';
    		location.href = (url + '?type=' + num);
    	}
    	var columns = [
        	{width:"25%", name:"标题", field:"title"},
        	{width:"25%", name:"封面", field:"picUrl"},
        	{width:"25%", name:"类型", field:"type"},
        	{width:"25%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'process' : function(html, cell) {
        		if (cell.type == 1) {
        			html = html.replace("#type#", "外链");
        		} else if (cell.type == 2) {
        			html = html.replace("#type#", "图文");
        		}
        		var image = "<a href='javascript:show(\"" + cell.picUrl + "\");'>" +
        			"<img style='margin-top:8px' src='" + cell.picUrl + "' width='60' height='60'/></a>";
        		html = html.replace("#picUrl#", image);
        		var operate = (
        			"<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>&nbsp;" +
        			"&nbsp;<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>"
        		);
        		return html.replace("#id#", operate);
        	}
        });
        $(document).ready(function() {
        	dptl.init().list(true);
        });
        /** 编辑 **/
        function edit(id) {
        	var url = '${ctx}/wxapi/reply/news/edit/${object.id}';
        	url += '?mode=${mode}&type=${type}';
        	if (id != null) {
        		url += ('&id=' + id);
        	}
        	location.href = url;
        }
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/wxapi/reply/news/lose/' + id,
        			success : function(response) {
        				if (response.result == 1) {
        					dptl.list(false);
        				}
        			}
        		});
        	});
        }
        /** 预览 **/
        function show(image) {
        	$.dialog($.extend(lhg, { title : '预览', lock : true, 
			    content : '<img src="' + image + '" width="640" height="300" />'
			}));
        }
        function tset() {
        	$.LD.ajax({
        		url : '${ctx}/wxapi/reply/tset/${object.id}?type=${type}',
        		success : function(response) {
        			var msg = response.message;
        			if (response.result == 1) {
        				$.lhg.confirm(msg, 
	        				function() {
	 		       				location.reload(true);
	        				}, function() {
	 		       				location.reload(true);
	        				}
	        			);
        			} else {
        				$.lhg.confirm(msg);
        			}
        		}
        	});
        }
    </script>
  </head>
  
  <body>
	 <form action="${ctx}/wxapi/reply/news/page" method="post">
    	<input type="hidden" name="replyId" value="${object.id}" />
    	<div id="content">
	    	<div class="flag"> 
		    	<div class="location">
		    		<c:if test="${mode == 1}">关注时回复</c:if>
		    		<c:if test="${mode == 2}">无应答回复</c:if>
		    	</div>
			</div>
			<ul class="block_table" style="margin-left: 0.5%;">
				<li onclick="change(1);" class="tab" style="z-index: 0;">文&nbsp;本${object.type == 1 ? '&nbsp;(&nbsp;启&nbsp;用&nbsp;)' : ''}</li>
				<li onclick="change(6);" class="tab sel" style="margin-left: -10px; z-index: 1;">图&nbsp;文${object.type == 6 ? '&nbsp;(&nbsp;启&nbsp;用&nbsp;)' : ''}</li>
				<li onclick="tset();" class="radius3 btn w80" style="margin-right: -2px;">发&nbsp;布</li>
				<li onclick="edit();" class="radius3 btn w80 mr5">添加图文</li>
			</ul>
			<div class="input_table">
				<table id="list_table" class="w99p" style="margin-left: 0.5%;"></table>
			</div>
		</div>
    </form>
  </body>
</html>




	