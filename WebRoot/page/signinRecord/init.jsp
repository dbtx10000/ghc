<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"30%", name:"用户名", field:"userName"},
        	{width:"40%", name:"签到时间", field:"createTime"},
        	{width:"30%", name:"获得金币", field:"integral"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'sortWay' : 'create_time desc',
        	'colSort' : false,
        	'fuzzies':'userName',
        	'process' : function(html, cell) {
        		return html;
        	}
        });

        $(document).ready(function() {
        	dptl.init().list(true);
        });
        function detail(signinId,userId){
        	location.href='${ctx}/signinRecord/detail?signinId='+signinId+'&userId='+userId;
        }
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/signinRecord/lose/' + id,
        			success : function(response) {
        				if (response.result == 1) {
        					dptl.list(false);
        				}
        			}
        		});
        	});
        }
    </script>
  </head>
  
  <body>
  	<form action="${ctx}/signinRecord/page" method="post">
    	<div id="content">
	    	<div class="flag bt10"> 
		    	<div class="location">签到记录</div>
		    	<div class="rightBtn">
		    	</div>	
		 	</div>	
		 	<div class="tool">
				<div class="sear">
	  				<input type="text" name="keyword" placeholder="输入用户名搜索"
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