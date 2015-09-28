<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"20%", name:"手机", field:"userAccount"},
        	{width:"20%", name:"用户名", field:"userName"},
        	{width:"30%", name:"获得时间", field:"createTime"},
        	{width:"20%", name:"红包来源", field:"sourceName"},
        	{width:"10%", name:"获得金币", field:"integral"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'sortWay' : 'create_time desc',
        	'colSort' : false,
        	'fuzzies':'user_account,source_name',
        	'process' : function(html, cell) {
        		return html;
        	}
        });

        $(document).ready(function() {
        	dptl.init().list(true);
        });
    </script>
  </head>
  
  <body>
  	<form action="${ctx}/redPackageRecord/page" method="post">
    	<div id="content">
	    	<div class="flag bt10"> 
		    	<div class="location">红包记录</div>
		    	<div class="rightBtn">
		    	</div>	
		 	</div>	
		 	<div class="tool">
				<div class="sear">
	  				<input type="text" name="keyword" placeholder="输入手机号/红包来源搜索"
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