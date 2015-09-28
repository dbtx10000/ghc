<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript">
    	var columns = [
    		{width:"10%", name:"<input id='all' type='checkbox'/>", field:"all"},
        	{width:"20%", name:"红包名称", field:"name"},
        	{width:"10%", name:"奖励金币", field:"integral"},
        	{width:"20%", name:"剩余数量", field:"residueCount"},
        	{width:"20%", name:"投入数量", field:"allCount"},
        	{width:"20%", name:"基数", field:"basic"}
        ];
        var dptl = new DPTLister({
        	'columns' : columns,
        	'fuzzies' : ['name'],
        	'sortWay' : 'id desc',
        	'colSort' : false,
        	'process' : function(html, cell) {
        		html = html.replace("#all#","<input type='checkbox'  value="+cell.id+" name='ids' />");
        		html = html.replace("#integral#",cell.integral+"<input type='hidden' id='"+cell.id+"integral' value="+cell.integral+" name='integra' />");
        		html = html.replace("#allCount#","<input type='text' id='"+cell.id+"' name='count' maxlength='8' onkeyup='checkNum(\""+cell.id+"\","+cell.residueCount+")' />");
        		return html.replace("#basic#","<input type='text' id='"+cell.id+"s' name='basic' maxlength='8' onkeyup='checkNums(\""+cell.id+"\")' /");
        	}
        });
        function checkNum(id,allNum){
        	if((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105) || event.keyCode == 8 || event.keyCode == 13){
        		//判断只能打入数字
        		if($("#"+id).val() <= allNum){
        		
        		}else{
        			$("#"+id).val(allNum);
        		}
			}else{
        		$("#"+id).val(0);
			}
        }
        
        function checkNums(id){
        	if((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105) || event.keyCode == 8 || event.keyCode == 13){
        		//判断只能打入数字
			}else{
        		$("#"+id+"s").val(0);
			}
        }
        
        $(document).ready(function() {
        	dptl.init().list(true);
        	initSelectall();
        });

        
        /** 全选事件 **/
        function initSelectall(){
        	$("#all").click(function(){
				if($("#all").get(0).checked==true){
					var items=document.getElementsByName("ids");
					for(var i=0;i<items.length;i++){
						items[i].checked=true;
					}
				}else{
					var items=document.getElementsByName("ids");
					for(var i=0;i<items.length;i++){
						items[i].checked=false;
					}
				}	
			});
        }
        
        
        function save(){
			var items=document.getElementsByName("ids");
			var b=false;
			var bb=true;
			for(var i=0;i<items.length;i++){
				if(items[i].checked==true){
					$("#"+items[i].value).attr('name','count');
					$("#"+items[i].value+"s").attr('name','basic');
					$("#"+items[i].value+"integral").attr('name','integra');
					b=true;
					if( $("#"+items[i].value).val() == "" || $("#"+items[i].value).val() == 0||$("#"+items[i].value+"s").val() == "" || $("#"+items[i].value+"s").val() == 0){
						bb=false;
					}
				}else{
					//没选中就移除他们的name，避免后台收到的数组混乱
					$("#"+items[i].value).removeAttr("name");
					$("#"+items[i].value+"s").removeAttr("name");
					$("#"+items[i].value+"integral").removeAttr("name");
					
				}
			}
			if(b && bb){
				$("#inputForm").attr("action", "${ctx}/jackpot/redPacketSave").ajaxSubmit({
					dataType: 'json',
					error : function() { 
						$.lhg.confirm("系统繁忙，请稍后..."); 
						$.pop.lock(false);
					},
					success: function(response) {
						$.pop.lock(false);
						if (response.result == 1) {
							getLhgParent().dptl.list(false);
							lhgBack();
						} else {
							$.lhg.confirm(response.message);
						}
					}
				});
			}else{
				alert("请选择红包并且输入投入数量和基数");
			}
		}
    </script>
    <style type="text/css">
    	body { background-color: #fff; }
    </style>
  </head>
  
  <body>
  	<form id="inputForm" action="${ctx}/jackpot/redPacketPage" method="post">
  		<input type="hidden" name="productId" value="${productId}" />
  		<input type="hidden" name="pageSize" value="8" />
    	<div id="content">
    		<div class="tool">
	    		<div class="sear">
	  				<input type="text" name="keyword" placeholder="输入红包名称搜索"
	  					onkeydown="if (event.keyCode == 13) { dptl.list(false); }"/>
	  				<a href="javascript:;;" onclick="dptl.list(false)">搜 索</a>
	  			</div>
	    	</div>
	    	<div class="data bt10">
	    		<table id="list_table" class="w100p"></table>
	    	</div>
	    	<div class="popBtn">
				<a class="save orangeBg" href="javascript:save()">保 存</a> <a
					class="back grayBg" href="javascript:lhgBack()">返 回</a>
			</div>
    	</div>
    </form>
  </body>
</html>