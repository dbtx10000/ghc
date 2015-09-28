<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
        	{width:"20%", name:"名称", field:"relate"},
        	{width:"15%", name:"类型", field:"relateType"},
        	{width:"14%", name:"剩余数量/投放数量", field:"count"},
        	{width:"6%", name:"基数", field:"basic"},
        	{width:"10%", name:"中奖机率", field:"winProbability"},
        	{width:"20%", name:"添加时间", field:"createTime"},
        	{width:"15%", name:"操作", field:"id"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'sortWay' : 'relate_type, create_time desc',
        	'colSort' : false,
        	'process' : function(html, cell) {
        	var operate ='';
        		if(cell.relateType == '1'){
        			html = html.replace("#relateType#",  '红包');
        		}else if(cell.relateType == '2'){
        			html = html.replace("#relateType#",  '奖品');
        		}
        		html = html.replace("#relate#", cell.relate.name);
        		var count = cell.count+'/'+(cell.count+cell.winCount);
        		html = html.replace("#count#", count);
        		html = html.replace("#winProbability#", cell.winProbability + "%");
        		operate += "&nbsp;<a href='javascript:edit(\"" + cell.id + "\")'>编辑</a>" +
        			"&nbsp;<a href='javascript:lose(\"" + cell.id + "\")'>删除</a>";
        		return html.replace("#id#", operate);
        	}
        });

        $(document).ready(function() {
        	dptl.init().list(true);
        	$(".auxi select").change(function() {
        		dptl.list(false);
        	});
        });

        /** 导入红包 **/
        function addRedPacket() {
        	var url = 'url:${ctx}/jackpot/redPacketInit?productId=${productId}';
        	$.dialog($.extend(lhg, {
				width : '1024px', height : '510px', 
				title : '导入红包', content : url
			}));
        }
         /** 导入奖品 **/
        function addAward() {
        	var url = 'url:${ctx}/jackpot/awardInit?productId=${productId}';
        	$.dialog($.extend(lhg, {
				width : '1024px', height : '510px', 
				title : '导入奖品', content : url
			}));
        }
        /** 编辑 **/
        function edit(id) {
        	var url = 'url:${ctx}/jackpot/input?id=' + id;
        	$.dialog($.extend(lhg, {
				width : '600px', height : '300px', 
				title : '编辑', content : url
			}));
        }
        
        
        /** 删除 **/
        function lose(id) {
        	$.lhg.confirm('是否确认删除？',function() { 
        		$.LD.ajax({
        			url : '${ctx}/jackpot/lose/' + id,
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
  	<form action="${ctx}/jackpot/page" method="post">
  	<input type="hidden" name="productId" value="${productId}">
    	<div id="content">
	    	<div class="flag bt10"> 
		    	<div class="location">奖品列表</div>
		    	<div class="rightBtn">
		    		<a href="javascript:addAward();">导入奖品</a>
		    		<a href="javascript:addRedPacket();">导入红包</a>
		    	</div>	    		
		 	</div>	
	    	 <div class="tool">
	  			<div class="auxi" style="margin-left: 0px;">
		  			<select name="relateType" id="relateType" class="w120">
		  				<option value="">全部类型</option>
		  					<option value="1">红包</option>
		  					<option value="2">奖品</option>
		  			</select>
		  		</div>
	    	</div> 
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
    	</div>
    </form>
  </body>
</html>