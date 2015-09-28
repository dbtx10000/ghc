<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<script type="text/javascript">
var row_index;
   	$(document).ready(function() {
   		initValid();
   		initData();
   		 row_index=document.getElementById('tb').rows.length-1;
   	});
	function formValid() {
		var $inputs = $("#seq,textarea");
   		return validThese($inputs);
   	}
	function initValid() {
		var $inputs = $("#seq,textarea");
		$inputs.focus(function() {
			$(this).parent().parent().find(".tip").html("*");
		}).blur(function() {
			valid($(this));
		});
	}
	function check(object){
		var value=$(object).val();
		var name=$(object).attr('name');
		if(value==''){
			$(object).attr('style','border:1px solid red');
			return false;
		}else {
			if(name=='optionSeq'){
				if (!value.isPositive() && parseInt(value) != 0) {
					$(object).attr('style','border:1px solid red');
						alert("序号只能是整数!");
						return false;
					}
			}
			$(object).attr('style','border:0px solid black');
			return true;
		}
	}
    function delete_row(object){
    	if(row_index<=2){
    		$.lhg.confirm("每道题目至少有2个选项!");
    		return ;
    	}else{
	    	row_index--;  
	   		$(object).parents("tr").remove();
    	}
    } 
    function addRow(){  
		    row_index++;  
		    var new_row=document.getElementById('tb').insertRow(row_index);  
		    new_row.setAttribute("id", row_index);   
		    var new_col=new_row.insertCell(0);  
		    new_col.innerHTML="<input type='text'  class='w100'  name='ordinal'  />";  
		    var new_col=new_row.insertCell(1);  
		    new_col.innerHTML="<input type='text'  class='w400'  name='optionName'  />";  
		    var new_col=new_row.insertCell(2);
		    new_col.innerHTML="<input type='text'  class='w100'  name='optionSeq'  />";
		    var new_col=new_row.insertCell(3);  
		    new_col.innerHTML="<a href='javascript:;' onclick='delete_row(this)'>删除</a>";  
	    }
	    
	    function save(url) {
	    	var $inputs = $("table input[type='text']");
	    	var flag=true;
	    	 for(var i=0;i<$inputs.length;i++){
	    		if(!check($inputs[i])){
	    			flag=false;
	    		}
	    	} 
			if (formValid()&&flag) {
				$.pop.lock(true);
				$("#save_form").ajaxSubmit({
					dataType: 'json',
					error : function() { 
						$.lhg.confirm("系统繁忙，请稍后..."); 
						$.pop.lock(false);
					},
					success: function(response) {
						$.pop.lock(false);
						if (response.result == 1) {
							$.lhg.confirm("数据已保存", function() {
								if (url == null) {
									location.reload(true);
								} else {
									location.href = url;
								}
							}, function() {
								if (url != null) {
									location.href = url;
								}
							});
						} else {
							$.lhg.confirm(response.message);
						}
					}
				});
			}
}

	 function initData() {
		 if ('${object.choose}' == 1) {
   			$("#choose").val(1);
			$("#left").addClass("selected");
   		} else {
   			$("#choose").val(0);
			$("#right").addClass("selected");
   		}
   		if ('${object.type}' == 0) {
   			$("#type").val(0);
			$("#left2").addClass("selected");
   		} else {
   			$("#type").val(1);
			$("#right2").addClass("selected");
   		}
   		
   		$("#left").click(function() {
			$("#choose").val(1);
			$("#right").removeClass("selected");
			$(this).addClass("selected");
		});
		$("#right").click(function() {
			$("#choose").val(0);
			$("#left").removeClass("selected");
			$(this).addClass("selected");
		});
		
		$("#left2").click(function() {
			$("#type").val(0);
			$("#right2").removeClass("selected");
			$(this).addClass("selected");
		});
		$("#right2").click(function() {
			$("#type").val(1);
			$("#left2").removeClass("selected");
			$(this).addClass("selected");
		});
   	}   
</script>
<style type="text/css">
	.ordinal{
		width:15%
	}
	.name{
		width:55%
	}
	.seq{
		width:15%
	}
	#tb {
		border-top: 1px solid #ccc;
		border-right: 1px solid #ccc;
	}
	#tb tr td {
		height: 30px;
		border-left: 1px solid #ccc;
		border-bottom: 1px solid #ccc;
	}
	#tb tr td:last-child {
		text-align: center;
	}
</style>
</head>

<body>
 	<form id="save_form" action="${ctx}/topic/save" method="post">
    	<input type="hidden" id="id" name="id" value="${object.id}" />
    	<input type="hidden" id="questionnaireId" name="questionnaireId" value="${questionnaireId}" />
    	<input type="hidden" id="type" name="type"  /> 
    	<input type="hidden" id="choose" name="choose"  />
    	<div id="content">
	    	<div class="flag"> 
		    	<div class="location">${empty(object.id) ? '添加题目' : '编辑题目'}</div>
		    	<div class="rightBtn">
			    	<a href="javascript:history.go(-1);">返回题目列表</a>
		    	</div>		    		
			</div>
			<!-- 开始 -->
			<div class="data">
				<div class="form">
					<div class="item h75">
						<div class="fir">题目名称：</div>
						<div class="ipt">
							<textarea style="width: 360px;resize:none; min-width: 360px; max-width: 360px; 
								height: 50px; min-height: 50px; max-height: 98px; line-height: normal;" 
								placeholder="请输入题目名称(最多可输入100个字节)" maxlength="255" 
								name="name">${object.name}</textarea>
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h40">
						<div class="fir">是否必填：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left" class="left">是</a> 
								<a id="right" class="right">否</a>
							</div>
						</div>
					</div>
					<div class="item h40">
						<div class="fir">题目类型：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left2" class="left">单 选</a> 
								<a id="right2" class="right">多 选</a>
							</div>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">排序：</div>
						<div class="ipt">
							<input type="text" class="w120" id="seq" name="seq"
								value="${object.seq}" placeholder="请输入排序号" />
						</div>
						<div class="tip">说明：序号越小越靠前</div>
					</div>
					<table id="tb">
					<thead>
						<tr style="text-align: center" style="border: 1px solid #ccc;">
							<td class="ordinal">选项序号</td>
							<td class="name">选项答案</td>
							<td class="seq">排序</td>
							<td class="seq">操作</td>
						</tr>
					</thead>
					<c:choose>
						<c:when test="${optionList==null||optionList.size()<=0}">
						<c:forEach begin="1" end="2" >
						<tr>
							<td class="ordinal">
								<input type="text" class="w100" onblur='check(this)' name="ordinal" />
							</td>
							<td class="name">
								<input type="text" class="w400" onblur='check(this)' name="optionName" />
							</td>
							<td class="seq">
								<input type="text" class="w100" onblur='check(this)' name="optionSeq" />
							</td>
							<td class="seq" >
								<a href="javascript:;" onclick="delete_row(this);">删除</a>
							</td>
						</tr>
						</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach items="${optionList}" var="option" >
						  <tr>
						<td class="ordinal">
							<input type="text"  class="w50"  onblur='check(this)' name="ordinal"
								 value="${option.ordinal }" />
						</td>
						<td class="name">
							<input type="text" class="w400"  onblur='check(this)' name="optionName"
								value="${option.name }"/>
						</td>
						<td class="seq">
							<input type="text" class="w50"  onblur='check(this)' name="optionSeq"
								  value="${option.seq }"/>
						</td>
						<td class="seq">
							<a href="javascript:;" onclick="delete_row(this);">删除</a>
						</td>
						</tr>
						</c:forEach>
						</c:otherwise>
					</c:choose>
					</table>
				</div>
			</div>
			<!-- 结束 -->
			<div class="pBtn">
				<a class="save orangeBg" href="javascript:save('${ctx}/topic/init?questionnaireId=${questionnaireId }');">保&nbsp;&nbsp;存</a>
				<a class="back grayBg" href="javascript:;;" onclick='addRow()'>添加选项</a>
			</div>
		</div>
	</form>
</body>
</html>
