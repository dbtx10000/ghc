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
    	function otherValid($input) {
    		var id = $input.attr('id'), value = $input.val();
    		var $fir = $input.parent().parent().find(".fir");
			var fir = $fir.html().substring(0, $fir.html().length - 1);
			var $tip = $input.parent().parent().find(".tip");
    		var result = true;
			if(id=='allCount'||id=='integral'){
				if (!value.isPositive() && parseInt(value) != 0) {
					$tip.html("<font color='red'>" + fir + "必须是整数</font>");
					result = false;
				}
				if(value!=null&&value!=''&&value=='0'){
					$tip.html("<font color='red'>" + fir + "不能为0</font>");
					result = false;
				}
			}
			 if(id=='integral'&&value!=null&&value!=''){
				$.LD.ajax({
       			url : '${ctx}/redPacket/checkWhetherExist?integral='+$("#integral").val(),
       			success : function(response) {
       				if (response.result != 1) {
       				$tip.html("<font color='red'>已存在该金币的红包</font>");
       					return false;
       				}
       			}
       			});
			} 
    		return result;
    	}
    	function formValid() {
    		return validThese($(":text"),otherValid);
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
  	<form id="save_form" action="${ctx}/redPacket/save" method="post">
    	<input type="hidden" id="id" name="id" value="${object.id }" />
    	<input type="hidden" id="image" name="image" value="${object.image }" />
    	<div id="content">
	    	<div class="data">
	    		<div class="form">
    				<div class="item h43">
	    				<div class="fir">红包标题：</div>
	    				<div class="ipt">
	    					<input type="text" class="w260" id="name" name="name" maxlength="20"
	    						value="${object.name}" placeholder="请输入红包标题"/>
	    				</div>
	    				<div class="tip">*</div>
	    			</div>
	    			<div class="item h43">
	    				<div class="fir">金币：</div>
	    				<div class="ipt">
	    					<input type="text" class="w260" id="integral" name="integral"  maxlength="20"
	    						value="${object.integral}" placeholder="请输入金币"/>
	    				</div>
	    				<div class="tip" id="integra">*</div>
	    			</div>
	    			<div class="item h43">
	    				<div class="fir">数量：</div>
	    				<div class="ipt">
	    					<input type="text" class="w260" id="allCount"  name="allCount" maxlength="20"
	    						value="${object.allCount}" placeholder="请输入投入数量"/>
	    				</div>
	    				<div class="tip" >*</div>
	    			</div>
	    				<div class="item h123">
			  			<div class="fir">红包图片：</div>
			  			<div class="ipt">
				  			<div class="imager" id="textImager"></div>
		  					<div class="upload" id="upload"></div>
			  			</div>
			  			<div class="tip" id="TextImage" style="padding-top:55px;">建议上传：675*438</div>
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
