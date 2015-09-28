<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"20%", name:"开户人", field:"userName"},
        	{width:"20%", name:"证件类型", field:"certType"},
        	{width:"20%", name:"证件号", field:"certId"},
        	{width:"20%", name:"开户行", field:"openBankName"},
        	{width:"20%", name:"银行卡号", field:"cardNo"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'sortWay' : 'create_time desc',
        	'process' : function(html, cell) {
        		var certType = "";
        		switch(cell.certType) {
        			case '01' : 
        				certType = "身份证"; 
        				break;
        			case '02' : 
        				certType = "军官证"; 
        				break;
        			case '03' : 
        				certType = "护照"; 
        				break;
        			case '04' : 
        				certType = "户口簿"; 
        				break;
        			case '05' : 
        				certType = "回乡证"; 
        				break;
        			case '06' : 
        				certType = "其他"; 
        				break;
        		}
        		html = html.replace("#certType#", certType);
        		return html;
        	}
        });
        $(document).ready(function() {
        	dptl.init().list(true);
        });
        
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/cardBind/lose/' + id,
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
	 <form action="${ctx}/cardBind/list" method="post">
	 <input type="hidden" id="userId" name="userId" value="${userId }"/>
	    <div id="content">
    		<div class="flag bt10"> 
	    		<div class="location">银行卡列表</div>
	    		<div class="rightBtn">
	    			<a href="javascript:history.go(-1);">返回</a>
	    		</div>		    		
	    	</div>
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>