<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
    <script type="text/javascript" src="${js}/kindeditor/kindeditor.js"></script>
    <script type="text/javascript" src="${js}/LD.sot/multiupf/init.js?skin=image"></script>
    <script type="text/javascript">
	    
	    function setImageImager(url) {
	    	$("#imageImager").css('background', 'url(' + url + ') no-repeat');
	    	$("#imageImager").css('background-size', '100% 100%').html('');
	    }
	    
    	$(document).ready(function() {
    		initValid();
    		initEditor();
			initImages();
    		initUploads();
    		initData();
    	});
    	
    	function initValid() {
    		$("#title").focus(function() {
    			$(this).parent().parent().find(".tip").html("*");
    		}).blur(function() {
    			valid($(this));
    		});
    	}
    	
    	function formValid() {
    	if($("#type").val()==1){
    	$("textarea[name='content']").val(editor.html());
    		return validThese($(":text"));
    	}else{
    	  $("textarea[name='content']").val(editor.html());
    		return validThese($("#title"));
    	}
    		
    	}
    	
    	function initUploads() {
    		$("#imageUpload").multiupf({
    			fileExts : '*.png;*.jpg', height : 31,
    			uploader : '${upload}&size=960x365',
	    		progress : function(data) { $("#imageImager").html("图片上传中..."); }, 
	    		complete : function(response) {
	    			if (response.errcode == 0) {
	    				setImageImager(response.url);
	    				$("#image").val(response.url);
	    			} else {
		    			$.lhg.confirm(response.errmsg);
		    		}
	    		}
    		});
    	}
    	
    	function initImages() {
	    	if ($("#image").val() != '') {
	    		setImageImager($("#image").val());
	    	} else {
	    		setImageImager('${img}/default320.png');
	    	}
    	}
    	
    	var editor;
    	function initEditor() {
    		KindEditor.ready(function(K) {
				editor = K.create('textarea[name="content"]', {
					uploadJson : '${ke_upload}',
					formatUploadUrl : false
				});
			});
    	}
    	
    	function initData() {
    		if ('${object.type}' == 1) {
    			$("#type").val(1);
				$("#right").addClass("selected");
    		} else {
    			$("#type").val(2);
				$("#left").addClass("selected");
				$("#append").hide();
    		}
			$("#right").click(function() {
				$("#type").val(1);
				$("#left").removeClass("selected");
				$(this).addClass("selected");
				 $("#append").show();
			});
    		$("#left").click(function() {
				$("#type").val(2);
				$("#right").removeClass("selected");
				$(this).addClass("selected");
				$("#append").hide();
			});
    	}
    	
    </script>
   	<style type="text/css">
   		.imager {
			margin: 0;
			padding: 0;
			width: 110px;
			height: 100px;
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
		#map {
			position: absolute; 
			margin-top: 44px; 
			right: 0px; 
			width: 420px; 
			height: 240px;
		}
		#map img {
			width: 100%; 
			height: 100%; 
			border: none;
		}
   	</style>
  </head>
  
  <body>
  	<form id="save_form" action="${ctx}/advert/save" method="post">
    	<input type="hidden" id="id" name="id" value="${object.id }" />
    	<input type="hidden" id="image" name="image" value="${object.image }" />
    	<input type="hidden" id="type" name="type" value="${object.type}" />
   
    	<div id="content">
	    	<div class="flag"> 
			    	<div class="location">添加广告</div>
			    	<div class="rightBtn">
			    			<a href="${ctx}/advert/init">返回广告列表</a>
			    	</div>		    		
			 </div>
	    	<div class="data">
	    		<div class="form">
	    			<div class="item h43">
						<div class="fir">广告位置：</div>
						<div class="ipt">
							<span class="sel"> 
								<select name="position" class="w140">
									<option value="1" ${object.position == 1 ? 'selected' : ''}>首页</option>
								</select>
							</span>
						</div>
					</div>
    				<div class="item h43">
	    				<div class="fir">广告名称：</div>
	    				<div class="ipt">
	    					<input type="text" class="w200" id="title" name="title" maxlength="50"
	    						value="${object.title }" placeholder="请输入广告名称"/>
	    				</div>
	    				<div class="tip">*</div>
	    			</div>
			  		<div class="item h103">
			  			<div class="fir">广告图片：</div>
			  			<div class="ipt">
		  					<div class="imager" id="imageImager"></div>
		  					<div class="upload" id="imageUpload"></div>
			  			</div>
			  			<div class="tip" style="padding-top:55px;">建议上传：640*220</div>
			  		</div>
			  		<div class="item h43">
						<div class="fir">内容类型：</div>
						<div class="ipt">
							<div class="radio">
								<a id="left" class="left">图文</a> <a id="right" class="right">外链</a>
							</div>
						</div>
					</div>
				 	<div class="item h43" id="append">
	    				 <div class="fir">链接网站：</div>
	    				<div class="ipt">
	    					<input type="text" class="w500" id="url" name="url" maxlength="255"
	    						value="${object.url }" placeholder="请输入链接网址"/> 
	    				</div> 
	    				<div class="tip">*</div>
	    			</div>
			  		<div class="item h43">
	    				<div class="fir">排序：</div>
	    				<div class="ipt">
	    				<span class="sel">
		    					<select id="weight" name="weight" class="w120">
		    						<option value="1" ${object.weight==1 ? 'selected':'' }>&nbsp;1&nbsp;</option>
		    						<option value="2" ${object.weight==2 ? 'selected':'' }>&nbsp;2&nbsp;</option>
		    						<option value="3" ${object.weight==3 ? 'selected':'' }>&nbsp;3&nbsp;</option>
		    						<option value="4" ${object.weight==4 ? 'selected':'' }>&nbsp;4&nbsp;</option>
		    						<option value="5" ${object.weight==5 ? 'selected':'' }>&nbsp;5&nbsp;</option>
		    						<option value="6" ${object.weight==6 ? 'selected':'' }>&nbsp;6&nbsp;</option>
		    						<option value="7" ${object.weight==7 ? 'selected':'' }>&nbsp;7&nbsp;</option>
		    						<option value="8" ${object.weight==8 ? 'selected':'' }>&nbsp;8&nbsp;</option>
		    						<option value="9" ${object.weight==9 ? 'selected':'' }>&nbsp;9&nbsp;</option>
		    						<option value="10" ${object.weight==10 ? 'selected':'' }>&nbsp;10</option>
		    					</select>
	    					</span>
	    				</div>
	    			</div>
			  		<div class="item" style="height: 350px;">
	    				<div class="fir">广告内容：</div>
	    				<div class="ipt">
	    					<textarea style="width: 700px; height: 333px;" id="content" name="content">${object.content}</textarea>
	    				</div>
	    			</div>
	    		</div>
	    	</div>
	    	<div class="pBtn">
    		<a class="save orangeBg" href="javascript:htmSave('${ctx}/advert/init');">保&nbsp;&nbsp;存</a>
    		<a class="back grayBg" href="${ctx}/advert/init">返&nbsp;&nbsp;回</a>
    	</div>
    	</div>

    </form>
  </body>
</html>
