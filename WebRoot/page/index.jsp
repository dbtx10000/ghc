<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${snm}</title>
<%@ include file="/jsp/script.jsp"%>
<link type="text/css" rel="stylesheet" href="${ctx}/css/index.css" />
<script type="text/javascript"> 
	/** 退出系统 **/
    function logout() {
    	$.lhg.confirm("是否确认退出系统？",function() { 
    		$.LD.ajax({
    			url : "${ctx}/manager/logout",
    			success : function(response) {
    				if (response.result == 1) {
    					window.top.location.href = "${ctx}/login";
    				}
    			}
    		});
    	});
    }
    /** 修改密码 **/
	function repswd() {
    	var url = 'url:${ctx}/repswd';
     	$.dialog($.extend(lhg, {
			width : '510px', height : '220px', 
			title : '修改密码', content : url
		}));
    }
</script>
</head>
<body class="showmenu">
	<div class="header" style="overflow:visible;position:absolute;z-index:8;">
		<h1><a href="#"><img src="${img}/pic_logo.jpg"/></a><p>${snm}管理系统</p></h1>
	    <div class="wel">
	    	 <p class="link"><span>您好 ${linkman}，欢迎使用 ${snm}管理系统！</span><a class="password" href="javascript:repswd();" title="修改密码">修改密码</a>  <a class="exit" href="javascript:logout();" title="退出系统">退出系统</a></p>
	    </div>
	</div>
	<div class="main">
		<div class="left">
	         <div class="menu" id="menu">
	            <iframe src="${ctx}/left" name="menu" frameborder="0" scrolling="no"></iframe>
	         </div>
	    </div>
	    <div class="right">
	    	<iframe src="${ctx}/right" name="right_frame" id="right_frame" 
	    		frameborder="0" scrolling="auto" width="100%" height="100%"></iframe>
	    </div>
	</div>
</body>
</html>