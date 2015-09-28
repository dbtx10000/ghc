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
   		initValid();
		initImagers();
   		initUploads();
   	});
	function formValid() {
		var $inputs = $("input:text");
   		return validThese($inputs);
   	}
	function initValid() {
		var $inputs = $("input:text");
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
 	<form id="save_form" action="${ctx}/award/save" method="post">
    	<input type="hidden" id="id" name="id" value="${object.id}" />
    	<input type="hidden" id="smallImage" name="smallImage" value="${object.smallImage}" /> 
    	<input type="hidden" id="bigImage" name="bigImage" value="${object.bigImage}" /> 
    	<div id="content">
	    	<div class="flag"> 
		    	<div class="location">${empty(object.id) ? '添加奖品' : '编辑奖品'}</div>
		    	<div class="rightBtn">
			    	<a href="${ctx}/award/init">返回奖品列表</a>
		    	</div>		    		
			</div>
			<!-- 开始 -->
			<div class="data">
				<div class="form">
					<div class="item h43">
						<div class="fir">名称：</div>
						<div class="ipt">
							<input type="text" class="w450" id="name" name="name"
								value="${object.name}" placeholder="请输入奖品名称(最多可输入50个字节)" />
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h96">
						<div class="fir">小图：</div>
						<div class="ipt">
							<div class="imager" id="imager_small" style="width: 83px;"></div>
							<div class="upload" id="upload_small"></div>
						</div>
					</div>
					<%--
					<div class="item h96">
						<div class="fir">大图：</div>
						<div class="ipt">
							<div class="imager" id="imager_big"></div>
							<div class="upload" id="upload_big"></div>
						</div>
					</div>
					--%>
					<div class="item h43">
						<div class="fir">数量：</div>
						<div class="ipt">
							<input type="text" class="w150" id="count" name="count"
								value="${object.count}" <c:if test="${object.id!=null}">readonly="readonly"</c:if> placeholder="请输入数量" />
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h125">
						<div class="fir">简介：</div>
						<div class="ipt">
							<textarea style="width: 360px; min-width: 360px; max-width: 360px; 
								height: 98px; min-height: 98px; max-height: 98px; line-height: normal;" 
								placeholder="请输入奖品简介(最多可输入255个字节)" maxlength="255" 
								name="intro">${object.intro}</textarea>
						</div>
					</div>
				</div>
			</div>
			<!-- 结束 -->
			<div class="pBtn">
				<a class="save orangeBg" href="javascript:htmSave('${ctx}/award/init');">保&nbsp;&nbsp;存</a>
				<a class="back grayBg" href="javascript:history.go(-1);">返&nbsp;&nbsp;回</a>
			</div>
		</div>
	</form>
</body>
</html>
