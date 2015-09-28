<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<script type="text/javascript" src="${js}/kindeditor/kindeditor.js"></script>
<script type="text/javascript" src="${js}/LD.sot/multiupf/init.js?ver=2"></script>
<script type="text/javascript">
    function setImager(url) {
    	$("#imager").css('background', 'url(' + url + ') no-repeat');
    	$("#imager").css('background-size', '100% 100%').html('');
    }
   	$(document).ready(function() {
   		// initData();
   		initValid();
		initImages();
   		initUploads();
   		initEditor();
   	});
	function formValid() {
        $("textarea[name='detail']").val(editor.html()); 
   		return validThese($("#title"));
   	}
	function initValid() {
		$("#title").focus(function() {
			$(this).parent().parent().find(".tip").html("*");
		}).blur(function() {
			valid($(this));
		});
	}
   	function initUploads() {
   		$("#upload").multiupf({
   			uploader : '${upload}?size=360x200_200x200',
   			fileExts : '*.png;*.jpg;', fileDesc : '*.png;*.jpg;',
    		progress : function(data) { $("#imager").html("上传中..."); }, 
    		complete : function(response) {
    			if (response.errcode == 0) {
    				$("#picUrl").val(response.url);
    				setImager(response.url);
    			} else {
	    			$.lhg.confirm(response.errmsg);
	    		}
    		}
   		});
   	}
   	function initImages() {
    	if ('${object.picUrl}' == '') {
    		setImager('${img}/default.png');
    	} else {
    		setImager('${object.picUrl}');
    	}
   	}
   	/* function initData() {
   		if ('${object.type}' != 2) {
   			$("#type").val(1);
			$("#left").addClass("selected");
			$("#cont").hide();
			$("#url").show();
   		} else {
   			$("#type").val(2);
			$("#right").addClass("selected");
			$("#cont").show();
			$("#url").hide();
   		}
   		$("#left").click(function() {
			$("#type").val(1);
			$("#right").removeClass("selected");
			$(this).addClass("selected");
			$("#cont").hide();
			$("#url").show();
		});
		$("#right").click(function() {
			$("#type").val(2);
			$("#left").removeClass("selected");
			$(this).addClass("selected");
			$("#cont").show();
			$("#url").hide();
		});
   	} */
   	var editor;
   	function initEditor() {
   		KindEditor.ready(function(K) {
			editor = K.create('textarea[name="detail"]', {
				uploadJson : '${ke_upload}',
				formatUploadUrl : false
			});
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
 	<form id="save_form" action="${ctx}/article/save" method="post">
    	<input type="hidden" id="id" name="id" value="${object.id }" />
    	<input type="hidden" id="picUrl" name="picUrl" value="${object.picUrl}" /> 
    	<%-- <input type="hidden" id="type" name="type" value="${object.type}" /> --%>
    	<input type="hidden" id="type" name="type" value="2" />
    	<div id="content">
	    	<div class="flag"> 
		    	<div class="location">${empty(object.id) ? '添加图文' : '编辑图文'}</div>
		    	<div class="rightBtn">
			    	<a href="${ctx}/article/init">返回图文列表</a>
		    	</div>		    		
			</div>
			<!-- 开始 -->
			<div class="data">
				<div class="form">
					<div class="item h43">
						<div class="fir">标题：</div>
						<div class="ipt">
							<input type="text" class="w450" id="title" name="title"
								value="${object.title}" placeholder="请输入标题" />
						</div>
						<div class="tip">*</div>
					</div>
					<div class="item h96">
						<div class="fir">封面：</div>
						<div class="ipt">
							<div class="imager" id="imager"></div>
							<div class="upload" id="upload"></div>
						</div>
						<div class="tip" style="padding-top:55px;">大图360x200|小图200x200</div>
					</div>
					<div class="item h125">
						<div class="fir">简介：</div>
						<div class="ipt">
							<textarea style="width: 360px; min-width: 360px; max-width: 360px; 
								height: 98px; min-height: 98px; max-height: 98px; line-height: normal;" 
								placeholder="请输入简介(最多可输入255个字节)" maxlength="255" 
								name="description">${object.description}</textarea>
						</div>
					</div>
					<div class="item h43">
						<div class="fir">排序：</div>
						<div class="ipt">
							<span class="sel" style="width:120px;"> 
								<select id="weight" name="weight" class="w120">
					  				<option value="0" <c:if test="${object.weight == 0}">selected="selected"</c:if>>0</option>
					  				<option value="1" <c:if test="${object.weight == 1}">selected="selected"</c:if>>1</option>
					  				<option value="2" <c:if test="${object.weight == 2}">selected="selected"</c:if>>2</option>
					  				<option value="3" <c:if test="${object.weight == 3}">selected="selected"</c:if>>3</option>
					  				<option value="4" <c:if test="${object.weight == 4}">selected="selected"</c:if>>4</option>
					  				<option value="5" <c:if test="${object.weight == 5}">selected="selected"</c:if>>5</option>
					  				<option value="6" <c:if test="${object.weight == 6}">selected="selected"</c:if>>6</option>
					  				<option value="7" <c:if test="${object.weight == 7}">selected="selected"</c:if>>7</option>
					  				<option value="8" <c:if test="${object.weight == 8}">selected="selected"</c:if>>8</option>
					  				<option value="9" <c:if test="${object.weight == 9}">selected="selected"</c:if>>9</option>
								</select>
							</span>
						</div>
					</div>
					<!-- <div class="item h43">
						<div class="fir">类型：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left" class="left">外&nbsp;链</a> 
								<a id="right" class="right">图&nbsp;文</a>
							</div>
						</div>
					</div>
					<div class="item h43" id="url">
						<div class="fir">链接：</div>
						<div class="ipt">
							<input type="text" class="w450" id="url" name="url"
								value="${object.url}" placeholder="请输入链接" />
						</div>
					</div> -->
			  		<div id="cont" class="item" style="height: 450px;">
	    				<div class="fir">内容：</div>
	    				<div class="ipt">
	    					<textarea style="width: 700px; height: 433px;" 
	    						id="detail" name="detail">${object.detail}</textarea>
	    				</div>
	    			</div>
				</div>
			</div>
			<!-- 结束 -->
			<div class="pBtn">
				<a class="save orangeBg" href="javascript:htmSave('${ctx}/article/init');">保&nbsp;&nbsp;存</a>
				<a class="back grayBg" href="javascript:history.go(-1);">返&nbsp;&nbsp;回</a>
			</div>
		</div>
	</form>
</body>
</html>
