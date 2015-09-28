<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
  <head>
    <title></title>
    <%@ include file="/jsp/script.jsp"%>
<script type="text/javascript" src="${js}/LD.sot/multiupf/init.js?ver=2"></script>
    <script type="text/javascript">
	    
    	$(document).ready(function() {
    		initValid();
    		initImages();
    		initUploads();
    	});
    	function setTextImager(url) {
	    	$("#textImager").css('background', 'url(' + url + ') no-repeat');
	    	$("#textImager").css('background-size', '100% 100%').html('');
	    }
	    
    	function initUploads() {
    		$("#upload").multiupf({
    			fileExts : '*.png;*.jpg', height : 31,
    			uploader : '${upload}&size=675x438',
	    		progress : function(data) { $("#textImager").html("图片上传中..."); }, 
	    		complete : function(response) {
	    			if (response.errcode == 0) {
		    			setTextImager(response.url);
		    			$("#image").val(response.url);
		    		} else {
		    			$.lhg.confirm(response.errmsg);
		    		}
	    		}
    	   	});
    	}
    	function initImages() {
    		if ($("#image").val() != '') {
	    		setTextImager($("#image").val());
	    	} else {
	    		setTextImager('${img}/default.png');
	    	}
    	}
    	function initValid() {
    		var $inputs = $("input");
    		$inputs.focus(function() {
    			$(this).parent().parent().find(".tip").html("*");
    		}).blur(function() {
    			valid($(this),otherValid);
    		});
    	}
    	function formValid() {
    		return validThese($(":text"),otherValid);
    	}
    	function otherValid($input) {
    		var id = $input.attr('id'), value = $input.val();
    		var $fir = $input.parent().parent().find(".fir");
			var fir = $fir.html().substring(0, $fir.html().length - 1);
			var $tip = $input.parent().parent().find(".tip");
    		var result = true;
			if(id=='integral'){
				if (!value.isPositive() && parseInt(value) != 0) {
					$tip.html("<font color='red'>" + fir + "必须是整数</font>");
					result = false;
				}
				if(value!=null&&value!=''&&value=='0'){
					$tip.html("<font color='red'>" + fir + "不能为0</font>");
					result = false;
				}
			}
    		return result;
    	}
    </script>
       	<style type="text/css">
   		.imager {
			margin: 0;
			padding: 0;
			width: 160px;
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
   	</style>
  </head>
  
  <body>
  	<form id="save_form" action="${ctx}/questionnaire/save" method="post">
    	<input type="hidden" id="id" name="id" value="${object.id }" />
    	<input type="hidden" id="image" name="image" value="${object.image }" />
    	<div id="content">
	    	<div class="data">
	    		<div class="form">
    				<div class="item h43">
	    				<div class="fir">问卷标题：</div>
	    				<div class="ipt">
	    					<input type="text" class="w260" id="title" name="title" maxlength="20"
	    						value="${object.title}" placeholder="请输入问卷标题"/>
	    				</div>
	    				<div class="tip">*</div>
	    			</div>
    				<div class="item h123">
			  			<div class="fir">问卷图片：</div>
			  			<div class="ipt">
				  			<div class="imager" id="textImager"></div>
		  					<div class="upload" id="upload"></div>
			  			</div>
			  			<div class="tip" id="TextImage" style="padding-top:55px;">建议上传：675*438</div>
		  		    </div>
		  		    <div class="item h43">
	    				<div class="fir">奖励金币：</div>
	    				<div class="ipt">
	    					<input type="text" class="w260" id="integral" name="integral" maxlength="20"
	    						value="${object.integral}" placeholder="请输入奖励金币"/>
	    				</div>
	    				<div class="tip">*</div>
	    			</div>
	    		</div>
	    	</div>
	    	<div class="pBtn">
	    		<a class="save orangeBg" href="javascript:lhgSave();">保&nbsp;&nbsp;存</a>
	    		<a class="back grayBg" href="javascript:lhgBack()">返&nbsp;&nbsp;回</a>
	    	</div>
    	</div>

    </form>
  </body>
</html>
