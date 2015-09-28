<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<script type="text/javascript" src="${js}/kindeditor/kindeditor.js"></script>
<script type="text/javascript" src="${js}/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${js}/LD.sot/multiupf/init.js?ver=2"></script>
<script type="text/javascript">
    function setImagerSmall(url) {
    	$("#imager_small").css('background', 'url(' + url + ') no-repeat');
    	$("#imager_small").css('background-size', '100% 100%').html('');
    }
    function setImagerBig(url) {
    	$("#imager_big").css('background', 'url(' + url + ') no-repeat');
    	$("#imager_big").css('background-size', '100% 100%').html('');
    }
   	$(document).ready(function() {
   		// initData();
   		initValid();
		initImagers();
   		initUploads();
   		initEditor();
   	});
	function formValid() {
		var $inputs = $("#name,#stocknum,#limitnum,#integral");
   		return validThese($inputs);
   	}
	function initValid() {
		var $inputs = $("#name,#stocknum,#limitnum,#integral");
		$inputs.focus(function() {
			$(this).parent().parent().find(".tip").html("*");
		}).blur(function() {
			valid($(this));
		});
	}
   	function initUploads() {
   		$("#upload_small").multiupf({
   			uploader : '${upload}',
   			fileExts : '*.png;*.jpg;', fileDesc : '*.png;*.jpg;',
    		progress : function(data) { $("#imager_small").html("上传中..."); }, 
    		complete : function(response) {
    			if (response.errcode == 0) {
    				$("#smallImage").val(response.url);
    				setImagerSmall(response.url);
    			} else {
	    			$.lhg.confirm(response.errmsg);
	    		}
    		}
   		});
   		$("#upload_big").multiupf({
   			uploader : '${upload}',
   			fileExts : '*.png;*.jpg;', fileDesc : '*.png;*.jpg;',
    		progress : function(data) { $("#image_big").html("上传中..."); }, 
    		complete : function(response) {
    			if (response.errcode == 0) {
    				$("#bigImage").val(response.url);
    				setImagerBig(response.url);
    			} else {
	    			$.lhg.confirm(response.errmsg);
	    		}
    		}
   		});
   	}
   	function initImagers() {
    	if ('${object.smallImage}' == '') {
    		setImagerSmall('${img}/default.png');
    	} else {
    		setImagerSmall('${object.smallImage}');
    	}
    	if ('${object.bigImage}' == '') {
    		setImagerBig('${img}/default.png');
    	} else {
    		setImagerBig('${object.bigImage}');
    	}
   	}
   	function initData() {
   		if ('${object.type}' != 2) {
   			$("#type").val(1);
			$("#left").addClass("selected");
   		} else {
   			$("#type").val(2);
			$("#right").addClass("selected");
   		}
   		$("#left").click(function() {
			$("#type").val(1);
			$("#right").removeClass("selected");
			$(this).addClass("selected");
		});
		$("#right").click(function() {
			$("#type").val(2);
			$("#left").removeClass("selected");
			$(this).addClass("selected");
		});
   	}
</script>
<style type="text/css">
	.imager {
		margin: 0;
		padding: 0;
		width: 166px;
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
 	<form id="save_form" action="${ctx}/gifts/igift/save" method="post">
    	<input type="hidden" id="id" name="id" value="${object.id}" />
    	<input type="hidden" id="smallImage" name="smallImage" value="${object.smallImage}" /> 
    	<input type="hidden" id="bigImage" name="bigImage" value="${object.bigImage}" /> 
    	<input type="hidden" id="type" name="type" value="${object.type == null ? 1 : object.type}" />
    	<div id="content">
	    	<div class="flag"> 
		    	<div class="location">${empty(object.id) ? '添加礼品' : '编辑礼品'}</div>
		    	<div class="rightBtn">
			    	<a href="${ctx}/gifts/igift/init">返回礼品列表</a>
		    	</div>		    		
			</div>
			<!-- 开始 -->
			<div class="data">
				<div class="form">
					<div class="item h43">
						<div class="fir">名称：</div>
						<div class="ipt">
							<input type="text" class="w450" id="name" name="name"
								value="${object.name}" placeholder="请输入礼品名称(最多可输入50个字节)" />
						</div>
						<div class="tip">*</div>
					</div>
					<!-- <div class="item h43">
						<div class="fir">类型：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left" class="left">实　物</a> 
								<a id="right" class="right">电子券</a>
							</div>
						</div>
					</div> -->
					<div class="item h96">
						<div class="fir">小图：</div>
						<div class="ipt">
							<div class="imager" id="imager_small" style="width: 83px;"></div>
							<div class="upload" id="upload_small"></div>
						</div>
					</div>
					<div class="item h96">
						<div class="fir">大图：</div>
						<div class="ipt">
							<div class="imager" id="imager_big"></div>
							<div class="upload" id="upload_big"></div>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">日期：</div>
	    				<div class="ipt">
	    					<input type="text" style="width: 135px;" id="startTime" name="startTime" maxlength="20"
	    						value='<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss' value="${object.startTime}"/>' placeholder="请输换购开始时间" 
	    						onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})"/>
	    						<span>至</span>
	    					<input type="text" style="width: 135px;" id="endTime" name="endTime" maxlength="20"
	    						value='<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss' value="${object.endTime}"/>' placeholder="请输入换购结束时间" 
	    						onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})"/>
	    				</div>
    					<div class="tip">*</div>
    				</div>
					<div class="item h43">
						<div class="fir">库存：</div>
						<div class="ipt">
							<input type="text" class="w150" id="stocknum" name="stocknum"
								value="${object.stocknum}" placeholder="请输入库存数" />
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">金币：</div>
						<div class="ipt">
							<input type="text" class="w150" id="integral" name="integral"
								value="${object.integral}" placeholder="请输入换购所需金币数" />
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h43">
						<div class="fir">限购：</div>
						<div class="ipt">
							<input type="text" class="w150" id="limitnum" name="limitnum"
								value="${object.limitnum}" placeholder="请输入每人限购次数" />
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h125">
						<div class="fir">简介：</div>
						<div class="ipt">
							<textarea style="width: 360px; min-width: 360px; max-width: 360px; 
								height: 98px; min-height: 98px; max-height: 98px; line-height: normal;" 
								placeholder="请输入礼品简介(最多可输入255个字节)" maxlength="255" 
								name="intro">${object.intro}</textarea>
						</div>
					</div>
					<div class="item h125">
						<div class="fir">须知：</div>
						<div class="ipt">
							<textarea style="width: 360px; min-width: 360px; max-width: 360px; 
								height: 98px; min-height: 98px; max-height: 98px; line-height: normal;" 
								placeholder="请输入换购须知(最多可输入255个字节)" maxlength="255" 
								name="notes">${object.notes}</textarea>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">排序：</div>
						<div class="ipt">
							<input type="text" class="w120" id="weight" name="weight"
								value="${object.weight}" placeholder="请输入排序号" />
						</div>
						<div class="tip">说明：序号越小越靠前</div>
					</div>
				</div>
			</div>
			<!-- 结束 -->
			<div class="pBtn">
				<a class="save orangeBg" href="javascript:htmSave('${ctx}/gifts/igift/init');">保&nbsp;&nbsp;存</a>
				<a class="back grayBg" href="javascript:history.go(-1);">返&nbsp;&nbsp;回</a>
			</div>
		</div>
	</form>
</body>
</html>
