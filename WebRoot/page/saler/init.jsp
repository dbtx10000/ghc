<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"20%", name:"姓名", field:"realname"},
        	{width:"20%", name:"手机", field:"mobile"},
        	{width:"20%", name:"客户", field:"userCount"},
        	{width:"40%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'fuzzies' : ['realname','mobile'],
        	'process' : function(html, cell) {
        		return process(html, cell);
        	}
        });
       
        function process(html, cell) {
        	var operate = "";
        	operate += "<a href='javascript:qrcode(\"" + cell.id + "\");'>二维码</a>&nbsp;&nbsp;";
       		operate += "<a href='javascript:edit(\"" + cell.id + "\");'>编辑</a>&nbsp;&nbsp;";
       		operate += "<a href='javascript:lose(\"" + cell.id + "\");'>删除</a>&nbsp;&nbsp;";
       		return html.replace("#id#", operate);
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
        
        
        /** 编辑 **/
        function edit(id) {
        	var url = 'url:${ctx}/saler/input?id='+id;
        	$.dialog($.extend(lhg, {
				width : '480px', height : '210px', 
				title : '编辑', content : url
			}));
        }
        
        
        /** 二维码 **/
        function qrcode(id) {
        	var cotent = ('${lctx}/wap/user/regist?salerId=' + id).encode();
        	var url = '${qrcode}?content=' + cotent + '&sidelen=384';
        	$.dialog($.extend(lhg, {
        		title : '二维码', lock : true, 
        		padding : '0px 36px 0px 36px',
			    content : '<img src="' + url + '" width="384" height="384" />'
			}));
        }
        
        function add(id) {
        	window.location = '${ctx}/saler/add';
        }
        
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() {
        		$.LD.ajax({
        			url : '${ctx}/saler/lose/' + id,
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
	    	<div class="location">销售列表</div>
	    	<div class="rightBtn">
	    		<a href="javascript:add();">添加销售用户</a>
	    	</div>		    		
		</div>
		<c:if test="${pid != null && !empty(parent.pid)}">
			<form id="parent_form" action="${ctx}/users/user/only?id=${parent.pid}" method="post">
				<div class="tool" style="padding-bottom: 0px;">邀请人信息：</div>
				<div class="data">
		    		<table id="parent_list_table" class="w100p"></table>
		    	</div>
		    </form>s
	    </c:if>
    	<form id="queryForm" action="${ctx}/saler/page" method="post">
  			<c:if test="${pid != null}"><input type="hidden" id="pid" name="pid" value="${pid}" /></c:if>
	    	<div class="tool">
	    		<div class="sear">
	  				<input type="text" name="keyword" placeholder="输入关键字进行搜索"
	  					onkeydown="if (event.keyCode == 13) { dptl.list(false); }"/>
	  				<a href="javascript:;" onclick="dptl.list(false);">搜 索</a>
	  			</div>
	    	</div>
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
	    </form>
   	</div>
  </body>
</html>
