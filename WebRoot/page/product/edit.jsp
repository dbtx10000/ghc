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
		//设置是否可以抽奖
   		if ('${object.jackpot}' == 1) {
   			$("#jackpot").val(1);
			$("#left6").addClass("selected");
   		} else {
   			$("#jackpot").val(0);
			$("#right6").addClass("selected");
   		}
   		$("#left6").click(function() {
			$("#jackpot").val(1);
			$("#right6").removeClass("selected");
			$(this).addClass("selected");
		});
		$("#right6").click(function() {
			$("#jackpot").val(0);
			$("#left6").removeClass("selected");
			$(this).addClass("selected");
		});
		//设置抽奖获取金币是否按比例
   		if ('${object.gainByScale}' == 1) {
   			$("#gainByScale").val(1);
			$("#left7").addClass("selected");
   		} else {
   			$("#gainByScale").val(0);
			$("#right7").addClass("selected");
   		}
   		$("#left7").click(function() {
			$("#gainByScale").val(1);
			$("#right7").removeClass("selected");
			$(this).addClass("selected");
		});
		$("#right7").click(function() {
			$("#gainByScale").val(0);
			$("#left7").removeClass("selected");
			$(this).addClass("selected");
		});
		//设置是否可以使用代金券
   		if ('${object.canUseCoupon}' == 1) {
   			$("#canUseCoupon").val(1);
			$("#left8").addClass("selected");
   		} else {
   			$("#canUseCoupon").val(0);
			$("#right8").addClass("selected");
   		}
   		$("#left8").click(function() {
			$("#canUseCoupon").val(1);
			$("#right8").removeClass("selected");
			$(this).addClass("selected");
		});
		$("#right8").click(function() {
			$("#canUseCoupon").val(0);
			$("#left8").removeClass("selected");
			$(this).addClass("selected");
		});
		//设置收益日期类型
   		if ('${object.incomeType}' != 2) {
   			$("#incomeType").val(1);
			$("#left9").addClass("selected");
			$("#income_type_1").show();
			$("#income_type_2").hide();
   		} else {
   			$("#incomeType").val(2);
			$("#right9").addClass("selected");
			$("#income_type_1").hide();
			$("#income_type_2").show();
   		}
   		$("#left9").click(function() {
			$("#incomeType").val(1);
			$("#right9").removeClass("selected");
			$(this).addClass("selected");
			$("#income_type_1").show();
			$("#income_type_2").hide();
		});
		$("#right9").click(function() {
			$("#incomeType").val(2);
			$("#left9").removeClass("selected");
			$(this).addClass("selected");
			$("#income_type_1").hide();
			$("#income_type_2").show();
		});
		//设置抽奖
		if ('${object.game}' == 1) {
   			$("#game").val(1);
			$("#leftGame").addClass("selected");
   		} else {
   			$("#game").val(0);
			$("#rightGame").addClass("selected");
   		}
   		$("#leftGame").click(function() {
			$("#game").val(1);
			$("#rightGame").removeClass("selected");
			$(this).addClass("selected");
		});
		$("#rightGame").click(function() {
			$("#game").val(0);
			$("#leftGame").removeClass("selected");
			$(this).addClass("selected");
		});
		//设置是否是小额投资产品
   		if ('${object.smallProduct}' != 1) {
   			$("#smallProduct").val(0);
			$("#left10").addClass("selected");
   		} else {
   			$("#smallProduct").val(1);
			$("#right10").addClass("selected");
   		}
   		$("#left10").click(function() {
			$("#smallProduct").val(0);
			$("#right10").removeClass("selected");
			$(this).addClass("selected");
			$("#totalMoney,#flingMoney,#increaseMoney,#maxMoney").val('');
			$("#unit_1,#unit_2,#unit_3,#unit_4").html('万');
			$("#unit_5").html('/&nbsp;万元');
		});
		$("#right10").click(function() {
			$("#smallProduct").val(1);
			$("#left10").removeClass("selected");
			$(this).addClass("selected");
			$("#totalMoney,#flingMoney,#increaseMoney,#maxMoney").val('');
			$("#unit_1,#unit_2,#unit_3,#unit_4,#unit_5").html('');
		});
		//设置是否仅线上支付
		if ('${object.payType}' != 1) {
   			$("#payType").val(0);
			$("#rightPay").addClass("selected");
   		} else {
   			$("#payType").val(1);
			$("#leftPay").addClass("selected");
   		}
   		$("#leftPay").click(function() {
			$("#payType").val(1);
			$("#rightPay").removeClass("selected");
			$(this).addClass("selected");
		});
		$("#rightPay").click(function() {
			$("#payType").val(0);
			$("#leftPay").removeClass("selected");
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
		var $input = $(":text,#typeId").not("#allotType").not("#startTime").not("#endTime").not("#expectIncome").not("#integral").not("#contractTime").not("#incomeDays").not("#incomeStartTime").not("#incomeEndTime");
		$input.focus(function() {
			$(this).parent().parent().find(".tip").html("*");
		}).blur(function() {
			valid($(this));
		});
	}
	function formValid() {
		var result = validThese($(":text,#typeId,#zdyname,#zdynote").not("#allotType").not("#startTime").not("#endTime").not("#expectIncome").not("#integral").not("#contractTime").not("#incomeDays").not("#incomeStartTime").not("#incomeEndTime"));
		if (result) {
			$("textarea[name='productNote']").val(editor1.html());
			$("textarea[name='allotNote']").val(editor2.html());
			// $("textarea[name='contractNote']").val(editor3.html());
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
		<input type="hidden" id="canUseCoupon" name="canUseCoupon" value="" />
		<input type="hidden" id="incomeType" name="incomeType" value="" />
		<input type="hidden" id="smallProduct" name="smallProduct" value="" />
		<input type="hidden" id="type" name="type" value="1" />
		<input type="hidden" id="game" name="game" value="" />
		<input type="hidden" id="payType" name="payType" value="" />
		<div id="content">
			<div class="flag">
				<div class="location">添加产品</div>
				<div class="rightBtn">
					<a href="${ctx}/product/init">返回产品列表</a>
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
						<div class="fir">购买方式：</div>
						<div class="ipt">
							<span class="sel"> 
								<select id="buyType" name="buyType" class="w140">
									<option value="1" ${object.buyType == 1 ? 'selected' : ''}>开放购买</option>
									<option value="2" ${object.buyType == 2 ? 'selected' : ''}>F码购买</option>
								</select> 
							</span>
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
    				<div class="item h43">
						<div class="fir">收益期类型：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left9" class="left">固定收益日期</a><a id="right9" class="right">认购开始收益</a>
							</div>
						</div>
					</div>
					<div class="item h43" id="income_type_1">
						<div class="fir">收益日期：</div>
	    				<div class="ipt">
	    					<input type="text" style="width: 135px;" id="incomeStartTime" name="incomeStartTime" maxlength="20"
	    						value='<fmt:formatDate pattern='yyyy-MM-dd' value="${object.incomeStartTime}"/>' placeholder="请输入收益开始时间" 
	    						onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'incomeEndTime\')}',dateFmt:'yyyy-MM-dd',readOnly:true})"/>
	    						<span>至</span>
	    					<input type="text" style="width: 135px;" id="incomeEndTime" name="incomeEndTime" maxlength="20"
	    						value='<fmt:formatDate pattern='yyyy-MM-dd' value="${object.incomeEndTime}"/>' placeholder="请输入收益结束时间" 
	    						onfocus="WdatePicker({minDate:'#F{$dp.$D(\'incomeStartTime\')}',dateFmt:'yyyy-MM-dd',readOnly:true})"/>
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
						<div class="fir">是否小额投资：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left10" class="left">否</a><a id="right10" class="right">是</a>
							</div>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">产品总金额：</div>
						<div class="ipt">
							<input type="text" class="w135" maxlength="10"
								id="totalMoney" name="totalMoney" value="${object.totalMoney}" 
								placeholder="请输入产品总金额" />&nbsp;&nbsp;<span id="unit_1"><c:if test="${object.smallProduct != 1}">万</c:if></span>元
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">起投金额：</div>
						<div class="ipt">
							<input type="text" class="w135" maxlength="10"
								id="flingMoney" name="flingMoney" value="${object.flingMoney}" 
								placeholder="请输入起投金额" />&nbsp;&nbsp;<span id="unit_2"><c:if test="${object.smallProduct != 1}">万</c:if></span>元
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">递增金额：</div>
						<div class="ipt">
							<input type="text" class="w135" maxlength="10"
								id="increaseMoney" name="increaseMoney" value="${object.increaseMoney}" 
								placeholder="请输入递增金额" />&nbsp;&nbsp;<span id="unit_3"><c:if test="${object.smallProduct != 1}">万</c:if></span>元
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">最高投资金额：</div>
						<div class="ipt">
							<input type="text" class="w135" maxlength="10"
								id="maxMoney" name="maxMoney"  value="${object.maxMoney}" 
								placeholder="请输入最高投资金额" />&nbsp;&nbsp;<span id="unit_4"><c:if test="${object.smallProduct != 1}">万</c:if></span>元
						</div>
						<div class="tip">*</div>
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
						<div class="fir">是否浮动：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left5" class="left">是</a><a id="right5" class="right">否</a>
							</div>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">可使用代金券：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left8" class="left">是</a><a id="right8" class="right">否</a>
							</div>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">金币使用限制：</div>
						<div class="ipt">
							<span class="sel"> 
								<select name="useIntegralType" class="w140">
									<option value="0" ${object.useIntegralType == 0 ? 'selected' : ''}>全部</option>
									<c:forEach var="cell" items="${integralTypes}">
										<option value="${cell.id}" ${object.useIntegralType == cell.id ? 'selected' : ''}>${cell.name}</option>
									</c:forEach>
								</select>
							</span>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">金币使用限制：</div>
						<div class="ipt">
							<input type="text" class="w50" id="integralLimit" 
								name="integralLimit" value="${object.integralLimit}" 
								placeholder="金币" />&nbsp;&nbsp;金币&nbsp;<span id="unit_5"><c:if test="${object.smallProduct != 1}">/&nbsp;万元</c:if></span>
						</div>
						<div class="tip">*</div>
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
					<div class="item h43">
						<div class="fir">开户行：</div>
						<div class="ipt">
							<input type="text" class="w500" maxlength="50"
								id="bankName" name="bankName"  value="${object.bankName}" 
								placeholder="请输入开户行(50字以内)" />
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">账户名称：</div>
						<div class="ipt">
							<input type="text" class="w500" maxlength="50"
								id="accountName" name="accountName"  value="${object.accountName}" 
								placeholder="请输入账户名称(50字以内)" />
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">帐号：</div>
						<div class="ipt">
							<input type="text" class="w500" maxlength="50"
								id="account" name="account"  value="${object.account}" 
								placeholder="请输入帐号(50字以内)" />
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">可得金币：</div>
						<div class="ipt">
							<input type="text" class="w100" maxlength="11"
								id="integral" name="integral" value="${object.integral}" 
								placeholder="请输入可得金币" />
						</div>
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
					<div class="item" style="height: 360px;">
						<div class="fir">电子合同：</div>
						<div class="ipt">
							<textarea style="width: 700px; height: 333px;" 
								id="contractNote" name="contractNote">${object.contractNote}</textarea>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">合同签署日期：</div>
	    				<div class="ipt">
							<input type="text" style="width: 135px;" id="contractTime" name="contractTime" maxlength="20"
		   						value='<fmt:formatDate pattern='yyyy-MM-dd' value="${object.contractTime}"/>' placeholder="请输入合同签署日期" 
		   						onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})"/>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">是否可抽奖：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left6" class="left">是</a><a id="right6" class="right">否</a>
							</div>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">按投资比例：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left7" class="left">是</a><a id="right7" class="right">否</a>
							</div>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">是否可游戏：</div>
						<div class="ipt">
							<div class="radio">
								<a id="leftGame" class="left">是</a><a id="rightGame" class="right">否</a>
							</div>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">仅线上支付：</div>
						<div class="ipt">
							<div class="radio">
								<a id="leftPay" class="left">是</a><a id="rightPay" class="right">否</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="pBtn">
				<a class="save orangeBg"
					href="javascript:htmSave('${ctx}/product/init?type=1');">保&nbsp;&nbsp;存</a>
				<a class="back grayBg" href="javascript:history.go(-1)">返&nbsp;&nbsp;回</a>
			</div>
		</div>
	</form>
</body>
</html>
