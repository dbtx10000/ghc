<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<script type="text/javascript" src="${js}/LD.sot/multiupf/init.js?skin=image"></script>
<script type="text/javascript">
	function setImager1(url) {
		$("#imager1").css('background', 'url(' + url + ') no-repeat');
		$("#imager1").css('background-size', '100% 100%').html('');
	}
	function setImager2(url) {
		$("#imager2").css('background', 'url(' + url + ') no-repeat');
		$("#imager2").css('background-size', '100% 100%').html('');
	}
	$(document).ready(function() {
		initValid();
		initImages();
		initUploads();
	});
	function initValid() {
		$(":text").focus(function() {
			$(this).parent().parent().find(".tip").html("*");
		}).blur(function() {
			valid($(this));
		});
	}
	function formValid() {
		return validThese($(":text"));
	}
	function initUploads() {
		$("#upload1").multiupf({
			uploader : '${upload}?size=640x320',
			fileExts : '*.png;*.jpg;', fileDesc : '*.png;*.jpg;',
			progress : function(data) { $("#imager1").html("上传中..."); },
			complete : function(response) {
				if (response.errcode == 0) {
					setImager1(response.url);
					$("#logo").val(response.url);
				} else {
					$.lhg.confirm(response.errmsg);
				}
			}
		});
		$("#upload2").multiupf({
			uploader : '${upload}?size=640x320',
			fileExts : '*.png;*.jpg;', fileDesc : '*.png;*.jpg;',
			progress : function(data) { $("#imager2").html("上传中..."); },
			complete : function(response) {
				if (response.errcode == 0) {
					setImager2(response.url);
					$("#note").val(response.url);
				} else {
					$.lhg.confirm(response.errmsg);
				}
			}
		});
	}
	function initImages() {
		if ($("#logo").val() == '') {
			setImager1('${img}/default.png');
		} else {
			setImager1($("#logo").val());
		}
		if ($("#note").val() == '') {
			setImager2('${img}/default.png');
		} else {
			setImager2($("#note").val());
		}
	}
</script>
<style type="text/css">
body { 
	background: #fff; 
}
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
	<form id="save_form" action="${ctx}/productType/save" method="post">
		<input type="hidden" id="id" name="id" value="${object.id }" /> 
		<input type="hidden" id="logo" name="logo" value="${object.logo }" />
		<input type="hidden" id="note" name="note" value="${object.note }" />
		<div id="content-lhg">
			<div class="item h30">
				<div class="fir">分类名称：</div>
				<div class="ipt">
					<input type="text" class="w320" maxlength="50"
						id="name" name="name"  value="${object.name}" 
						placeholder="请输入分类名称(50字以内)" />
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h85">
				<div class="fir">分类图片1：</div>
				<div class="ipt">
					<div class="imager" id="imager1"></div>
					<div class="upload" id="upload1"></div>
				</div>
				<div class="tip" style="padding-top:55px;">建议上传：640*320</div>
			</div>
			<div class="item h85">
				<div class="fir">分类图片2：</div>
				<div class="ipt">
					<div class="imager" id="imager2"></div>
					<div class="upload" id="upload2"></div>
				</div>
				<div class="tip" style="padding-top:55px;">建议上传：640*320</div>
			</div>
			<div class="item h30">
				<div class="fir">分类排序：</div>
				<div class="ipt">
					<span class="sel" style="width:120px;"> 
						<select id="seq" name="seq" class="w120">
			  				<option value="0" <c:if test="${object.seq == 0}">selected="selected"</c:if>>0</option>
			  				<option value="1" <c:if test="${object.seq == 1}">selected="selected"</c:if>>1</option>
			  				<option value="2" <c:if test="${object.seq == 2}">selected="selected"</c:if>>2</option>
			  				<option value="3" <c:if test="${object.seq == 3}">selected="selected"</c:if>>3</option>
			  				<option value="4" <c:if test="${object.seq == 4}">selected="selected"</c:if>>4</option>
			  				<option value="5" <c:if test="${object.seq == 5}">selected="selected"</c:if>>5</option>
			  				<option value="6" <c:if test="${object.seq == 6}">selected="selected"</c:if>>6</option>
			  				<option value="7" <c:if test="${object.seq == 7}">selected="selected"</c:if>>7</option>
			  				<option value="8" <c:if test="${object.seq == 8}">selected="selected"</c:if>>8</option>
			  				<option value="9" <c:if test="${object.seq == 9}">selected="selected"</c:if>>9</option>
						</select>
					</span>
				</div>
			</div>
			<%--
			<div class="item h30">
				<div class="fir">分类简介：</div>
				<div class="ipt">
					<textarea style="width: 320px; min-width: 320px; 
						max-width: 320px; height: 120px; min-height: 120px; 
						max-height: 120px; line-height: normal;" 
						placeholder="请输入分类简介(最多可输入255个字节)" 
						name="note" maxlength="255">${object.note}</textarea>
				</div>
			</div>
			--%>
			<div class="popBtn">
				<a class="save greenBg" href="javascript:lhgSave()">保 存</a> 
				<a class="back grayBg" href="javascript:lhgBack()">返 回</a>
			</div>
		</div>
	</form>
</body>
</html>
