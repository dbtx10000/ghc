<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<script type="text/javascript" src="${js}/kindeditor/kindeditor.js"></script>
<script type="text/javascript" src="${js}/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${js}/LD.sot/multiupf/init.js?skin=image"></script>
<script type="text/javascript">
	function setImager(url) {
		$(".imager").css('background', 'url(' + url + ') no-repeat');
		$(".imager").css('background-size', '100% 100%').html('');
	}
	$(document).ready(function() {
		initData();
		initValid();
		initImages();
		initUploads();
		initValid();
		initEditor();
	});
	function initData() {
		//是否显示收益分配方式
   		if ('${object.allotTypeShow}' == 1) {
   			$("#allotTypeShow").val(1);
			$("#left1").addClass("selected");
   		} else {
   			$("#allotTypeShow").val(0);
			$("#right1").addClass("selected");
   		}
   		$("#left1").click(function() {
			$("#allotTypeShow").val(1);
			$("#right1").removeClass("selected");
			$(this).addClass("selected");
		});
		$("#right1").click(function() {
			$("#allotTypeShow").val(0);
			$("#left1").removeClass("selected");
			$(this).addClass("selected");
		});
		//是否显示起息日
   		if ('${object.startTimeShow}' == 1) {
   			$("#startTimeShow").val(1);
			$("#left2").addClass("selected");
   		} else {
   			$("#startTimeShow").val(0);
			$("#right2").addClass("selected");
   		}
   		$("#left2").click(function() {
			$("#startTimeShow").val(1);
			$("#right2").removeClass("selected");
			$(this).addClass("selected");
		});
		$("#right2").click(function() {
			$("#startTimeShow").val(0);
			$("#left2").removeClass("selected");
			$(this).addClass("selected");
		});
		//是否显示期限
   		if ('${object.endTimeShow}' == 1) {
   			$("#endTimeShow").val(1);
			$("#left3").addClass("selected");
   		} else {
   			$("#endTimeShow").val(0);
			$("#right3").addClass("selected");
   		}
   		$("#left3").click(function() {
			$("#endTimeShow").val(1);
			$("#right3").removeClass("selected");
			$(this).addClass("selected");
		});
		$("#right3").click(function() {
			$("#endTimeShow").val(0);
			$("#left3").removeClass("selected");
			$(this).addClass("selected");
		});
		//是否显示预期年化收益
   		if ('${object.expectIncomeShow}' == 1) {
   			$("#expectIncomeShow").val(1);
			$("#left4").addClass("selected");
   		} else {
   			$("#expectIncomeShow").val(0);
			$("#right4").addClass("selected");
   		}
   		$("#left4").click(function() {
			$("#expectIncomeShow").val(1);
			$("#right4").removeClass("selected");
			$(this).addClass("selected");
		});
		$("#right4").click(function() {
			$("#expectIncomeShow").val(0);
			$("#left4").removeClass("selected");
			$(this).addClass("selected");
		});
		//年化收益率是否浮动
   		if ('${object.incomeFloat}' == 1) {
   			$("#incomeFloat").val(1);
			$("#left5").addClass("selected");
   		} else {
   			$("#incomeFloat").val(0);
			$("#right5").addClass("selected");
   		}
   		$("#left5").click(function() {
			$("#incomeFloat").val(1);
			$("#right5").removeClass("selected");
			$(this).addClass("selected");
		});
		$("#right5").click(function() {
			$("#incomeFloat").val(0);
			$("#left5").removeClass("selected");
			$(this).addClass("selected");
		});
		//关联产品自定义项目信息
		if ('${object.id}' != '') {
			$.LD.ajax({
    			url : '${ctx}/product/listProject?productId=${object.id}',
    			success : function(response) {
    				if (response.result == 1) {
    					var projects = response.data;
	    				for (var i = 0; i < projects.length; i++) {
	    					add(projects[i].name,projects[i].note);
	    				}
    				}
    			}
    		});
		}
   	}
   	
	function initValid() {
		var $input = $(":text,#typeId,#subscribeMoney,#actualPayMoney").not("#allotType").not("#startTime").not("#endTime").not("#expectIncome").not("#integral").not("#contractTime").not("#incomeDays").not("#incomeStartTime").not("#incomeEndTime");
		$input.focus(function() {
			$(this).parent().parent().find(".tip").html("*");
		}).blur(function() {
			valid($(this),otherValid);
		});
	}
	function formValid() {
		var result = validThese($(":text,#typeId,#zdyname,#zdynote,#subscribeMoney,#actualPayMoney").not("#allotType").not("#startTime").not("#endTime").not("#expectIncome").not("#integral").not("#contractTime").not("#incomeDays").not("#incomeStartTime").not("#incomeEndTime"),otherValid);
		if (result) {
			$("textarea[name='productNote']").val(editor1.html());
			$("textarea[name='allotNote']").val(editor2.html());
			// $("textarea[name='contractNote']").val(editor3.html());
		}
		return result;
	}
	function otherValid($input) {
    		var id = $input.attr('id'), value = $input.val();
    		var result = true;
			if(id=='subscribeMoney'||id=='actualPayMoney'){
			var $fir = $input.parent().parent().find(".fir");
			var fir = $fir.html().substring(0, $fir.html().length - 1);
			var $tip = $input.parent().parent().find(".tip");
				if (!value.isPositive()) {
					$tip.html("<font color='red'>" + fir + "必须是整数</font>");
					result = false;
				}
			}
    		return result;
    	}
	function initUploads() {
		$(".upload").multiupf({
			uploader : '${upload}?size=640x320',
			fileExts : '*.png;*.jpg;', fileDesc : '*.png;*.jpg;',
			progress : function(data) { $(".imager").html("上传中..."); },
			complete : function(response) {
				if (response.errcode == 0) {
					setImager(response.url);
					$("#logo").val(response.url);
				} else {
					$.lhg.confirm(response.errmsg);
				}
			}
		});
	}
	function initImages() {
		if ($("#logo").val() != '') {
			setImager($("#logo").val());
		} else {
			setImager('${img}/default.png');
		}
	}
	var editor1;
	var editor2;
	var editor3;
	function initEditor() {
		KindEditor.ready(function(K) {
			editor1 = K.create('textarea[name="productNote"]', {
				uploadJson : '${ke_upload}',
				formatUploadUrl : false
			});
		});
		KindEditor.ready(function(K) {
			editor2 = K.create('textarea[name="allotNote"]', {
				uploadJson : '${ke_upload}',
				formatUploadUrl : false
			});
		});
		/* KindEditor.ready(function(K) {
			editor3 = K.create('textarea[name="contractNote"]', {
				uploadJson : '${ke_upload}',
				formatUploadUrl : false
			});
		}); */
	}
	
	/** 添加自定义项目文本框 **/
	function add(name, note) {
		if (name.isEmpty() && note.isEmpty()) {
			//新增
			var $inputs = $(
			"<div class='item h45'>" + 
				"<div class='fir'>自定义项目：</div>" + 
			   	"<div class='ipt'>" + 
			   		"<input type='text' style='width: 170px;' id='zdyname' name='zdyname' maxlength='20'" + 
			   			"value='' placeholder='请输入自定义名称(20字以内)'/>" + 
			   			"<span>&nbsp;</span>" + 
			   		"<input type='text' style='width: 300px;' id='zdynote' name='zdynote' maxlength='50'" + 
			   			"value='' placeholder='请输入自定义内容(50字以内)'/>&nbsp;&nbsp;<a href='javascript:;'>删除</a>" + 
			   	"</div>" + 
	   			"<div class='tip'>*</div>" + 
	  		"</div>");
    		$inputs.find(".ipt").find("a").click(function() { $(this).parent().parent().remove(); }); 
			$("#add_btn").before($inputs);
		} else {
			//编辑
			var $inputs = $(
			"<div class='item h43'>" + 
				"<div class='fir'>自定义项目：</div>" + 
			   	"<div class='ipt'>" + 
			   		"<input type='text' style='width: 170px;' id='zdyname' name='zdyname' maxlength='20'" + 
			   			"value='"+name+"' placeholder='请输入自定义名称(20字以内)'/>" + 
			   			"<span>&nbsp;</span>" + 
			   		"<input type='text' style='width: 300px;' id='zdynote' name='zdynote' maxlength='50'" + 
			   			"value='"+note+"' placeholder='请输入自定义内容(50字以内)'/>&nbsp;&nbsp;<a href='javascript:;'>删除</a>" + 
			   	"</div>" + 
	   			"<div class='tip'>*</div>" + 
	  		"</div>");
    		$inputs.find(".ipt").find("a").click(function() { $(this).parent().parent().remove(); }); 
			$("#add_btn").before($inputs);
		}
	}
</script>
<style type="text/css">
.imager {
	margin: 0;
	padding: 0;
	width: 83px;
	height: 83px;
	float: left;
	background-color: #fff;
	text-align: center;
	vertical-align: middle;
	line-height: 81px;
	color: #000;
}
.upload {
	margin: 0;
	padding: 0;
	width: 83px;
	height: 31px;
	float: left;
	margin-left: 18px;
	margin-top: 52px;
}
</style>
</head>

<body>
	<form id="save_form" action="${ctx}/product/save" method="post">
		<input type="hidden" id="id" name="id" value="${object.id }" /> 
		<input type="hidden" id="logo" name="logo" value="${object.logo }" />
		<input type="hidden" id="allotTypeShow" name="allotTypeShow" value="" />
		<input type="hidden" id="startTimeShow" name="startTimeShow" value="" />
		<input type="hidden" id="endTimeShow" name="endTimeShow" value="" />
		<input type="hidden" id="expectIncomeShow" name="expectIncomeShow" value="" />
		<input type="hidden" id="incomeFloat" name="incomeFloat" value="" />
		<input type="hidden" id="jackpot" name="jackpot" value="" />
		<input type="hidden" id="gainByScale" name="gainByScale" value="" />
		<input type="hidden" id="type" name="type" value="2" />
		<input type="hidden" id="smallProduct" name="smallProduct" value="" />
		<div id="content">
			<div class="flag">
				<div class="location">添加产品</div>
				<div class="rightBtn">
					<a href="javascript:history.go(-1)">返回</a>
				</div>
			</div>
			<div class="data">
				<div class="form">
					<div class="item h43">
						<div class="fir">产品名称：</div>
						<div class="ipt">
							<input type="text" class="w500" maxlength="50"
								id="name" name="name"  value="${object.name}" 
								placeholder="请输入产品名称(50字以内)" />
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">控制状态：</div>
						<div class="ipt">
							<span class="sel"> 
								<select id="controlStatus" name="controlStatus" class="w140">
									<option value="1" ${object.controlStatus == 1 ? 'selected' : ''}>开放购买</option>
									<option value="2" ${object.controlStatus == 2 ? 'selected' : ''}>关闭购买</option>
									<option value="3" ${object.controlStatus == 3 ? 'selected' : ''}>到期退出</option>
								</select> 
							</span>
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">产品分类：</div>
						<div class="ipt">
							<span class="sel"> 
								<select id="typeId" name="typeId" class="w140">
									<option value="">请选择产品分类</option>
									<c:forEach items="${productTypeList}" var="list">
										<option value="${list.id }" ${object.typeId == list.id ? 'selected' : ''}>${list.name }</option>
									</c:forEach>
								</select> 
							</span>
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">认购日期：</div>
	    				<div class="ipt">
	    					<input type="text" style="width: 135px;" id="subscribeStartTime" name="subscribeStartTime" maxlength="20"
	    						value='<fmt:formatDate pattern='yyyy-MM-dd' value="${object.subscribeStartTime}"/>' placeholder="请输入认购开始时间" 
	    						onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'subscribeEndTime\')}',dateFmt:'yyyy-MM-dd',readOnly:true})"/>
	    						<span>至</span>
	    					<input type="text" style="width: 135px;" id="subscribeEndTime" name="subscribeEndTime" maxlength="20"
	    						value='<fmt:formatDate pattern='yyyy-MM-dd' value="${object.subscribeEndTime}"/>' placeholder="请输入认购结束时间" 
	    						onfocus="WdatePicker({minDate:'#F{$dp.$D(\'subscribeStartTime\')}',dateFmt:'yyyy-MM-dd',readOnly:true})"/>
	    				</div>
    					<div class="tip">*</div>
    				</div>
    				<div class="item h43" id="income_type_2">
						<div class="fir">认购成功后：</div>
						<div class="ipt">
							<input type="text" class="w50" maxlength="10"
								id="incomeDays" name="incomeDays" value="${object.incomeDays}" 
								placeholder="天数" />&nbsp;&nbsp;天内收益
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h96">
						<div class="fir">产品图片：</div>
						<div class="ipt">
							<div class="imager"></div>
							<div class="upload"></div>
						</div>
						<div class="tip" style="padding-top:55px;">建议上传：640*320</div>
					</div>
					<div class="item h43">
						<div class="fir">年化收益率：</div>
						<div class="ipt">
							<input type="text" class="w135" maxlength="5"
								id="income" name="income"  value="${object.income}" 
								placeholder="请输入预期年化收益" />&nbsp;&nbsp;%
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">认购金额：</div>
						<div class="ipt">
							<input type="text" class="w135" maxlength="10"
								id="subscribeMoney" name="subscribeMoney" value="${object.subscribeMoney}" 
								placeholder="请输入认购金额" />&nbsp;&nbsp;<span id="unit_2"></span>元
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">实际投资金额：</div>
						<div class="ipt">
							<input type="text" class="w135" maxlength="10"
								id="actualPayMoney" name="actualPayMoney" value="${object.actualPayMoney}" 
								placeholder="请输入实际投资金额" />&nbsp;&nbsp;<span id="unit_3"></span>元
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">是否浮动：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left5" class="left">是</a><a id="right5" class="right">否</a>
							</div>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">预期年化收益：</div>
						<div class="ipt">
							<input type="text" class="w500" maxlength="50"
								id="expectIncome" name="expectIncome"  value="${object.expectIncome}" 
								placeholder="请输入预期年化收益(50字以内)" />
						</div>
					</div>
					<div class="item h43">
						<div class="fir">是否显示：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left4" class="left">是</a><a id="right4" class="right">否</a>
							</div>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">收益分配方式：</div>
						<div class="ipt">
							<input type="text" class="w500" maxlength="50"
								id="allotType" name="allotType"  value="${object.allotType}" 
								placeholder="请输入收益分配方式(50字以内)" />
						</div>
					</div>
					<div class="item h43">
						<div class="fir">是否显示：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left1" class="left">是</a><a id="right1" class="right">否</a>
							</div>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">起息日：</div>
						<div class="ipt">
	    					<input type="text" class="w500" maxlength="50"
								id="startTime" name="startTime" value="${object.startTime}" 
								placeholder="请输入起息日(50字以内)" />
						</div>
					</div>
					<div class="item h43">
						<div class="fir">是否显示：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left2" class="left">是</a><a id="right2" class="right">否</a>
							</div>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">期限：</div>
						<div class="ipt">
							<input type="text" class="w500" maxlength="50"
								id="endTime" name="endTime"  value="${object.endTime}" 
								placeholder="请输入期限(50字以内)" />
						</div>
					</div>
					<div class="item h43">
						<div class="fir">是否显示：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left3" class="left">是</a><a id="right3" class="right">否</a>
							</div>
						</div>
					</div>
					<div class="item h40 mt5" id="add_btn">
						<a class="radius3 orangeBg" style="padding: 8px 64px;" href="javascript:add('','');">添加自定义项目[+]</a>
					</div>
					<div class="item h125">
						<div class="fir">产品简介：</div>
						<div class="ipt">
							<textarea style="width: 360px; min-width: 360px; max-width: 360px; 
								height: 98px; min-height: 98px; max-height: 98px; line-height: normal;" 
								placeholder="请输入产品简介(最多可输入255个字节)" maxlength="255" 
								id="intro" name="intro">${object.intro}</textarea>
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item" style="height: 350px;">
						<div class="fir">产品介绍：</div>
						<div class="ipt">
							<textarea style="width: 700px; height: 333px;" 
								id="productNote" name="productNote">${object.productNote}</textarea>
						</div>
					</div>
					<div class="item" style="height: 350px;">
						<div class="fir">分配计划：</div>
						<div class="ipt">
							<textarea style="width: 700px; height: 333px;" 
								id="allotNote" name="allotNote">${object.allotNote}</textarea>
						</div>
					</div>
				</div>
			</div>
			<div class="pBtn">
				<a class="save orangeBg"
					href="javascript:htmSave('${ctx}/product/specialInit?type=2');">保&nbsp;&nbsp;存</a>
				<a class="back grayBg" href="javascript:history.go(-1)">返&nbsp;&nbsp;回</a>
			</div>
		</div>
	</form>
</body>
</html>
