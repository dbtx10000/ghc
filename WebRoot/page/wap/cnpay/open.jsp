<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta name="version" content="GoHigh v1.1 20150320" />
<meta name="author" content="zalon" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache" />
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>${snm}<c:if test="${!need_head}"> - 开户</c:if></title>
<link type="text/css" rel="stylesheet" href="${css}/ghc_beta_1.0.css" />
<link rel="stylesheet" type="text/css" href="${js}/mobiscroll/css/mobiscroll.icons.css" />
<link rel="stylesheet" type="text/css" href="${js}/mobiscroll/css/mobiscroll.scroller.css" />
<link rel="stylesheet" type="text/css" href="${js}/mobiscroll/css/mobiscroll.scroller.android-holo.css" />
<link rel="stylesheet" type="text/css" href="${js}/mobiscroll/css/mobiscroll.animation.css" />
<style>
.user .my{ height:75px; }
section .text { margin: 10px 0; }
section .text li { font-family: '黑体'; font-size: 15px; }
.select { margin-right: 10px }
.selected { background: none; text-align: right; }
#pswtype { right:24px; }
#user  .my img{width:65px;top:5px;left:8px;height:auto;}
.agreem{margin:10px auto 15px auto;width:80%;color:#ff6147;text-decoration: underline;text-align:center;display:block;line-height:40px;}
#agreemContent {position:absolute;top:0;left:0;padding:10px;padding-bottom:80px;display:none;background:#fff;z-index:99;}
.successBtn {position:fixed;bottom:0;left:0;z-index:999;padding:10px 0;margin:10px auto 0 auto;width:100%;border-top:1px solid #e4e4e4;display:block;overflow:hidden;zoom:1;background:#f6f6f6;}
.successBtn li{float:left;width:50%;height:40px;line-height:40px;}
.successBtn .btn{margin:0 auto;width:90%;display:block;text-align:center;color:#fff;}
.successBtn li:last-child{margin-right:0px;}
</style>
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script type="text/javascript" src="${js}/mobiscroll/js/mobiscroll.core.js"></script>
<script type="text/javascript" src="${js}/mobiscroll/js/mobiscroll.scroller.js" ></script>
<script type="text/javascript" src="${js}/mobiscroll/js/mobiscroll.select.js"></script>
<script type="text/javascript" src="${js}/mobiscroll/js/mobiscroll.scroller.android-holo.js"></script>
<script type="text/javascript" src="${js}/mobiscroll/js/i18n/mobiscroll.i18n.zh.js"></script>
<script>
	$(document).ready(function() {
		$('#openBankId').val('${form.openBankId}');
		$('#openBankId').scroller({
			preset: 'select', 
			mode: 'scroller', 
			lang: 'zh',
			theme: 'android-holo light', 
			display: 'bottom', 
			animate: 'none',
			rows: 5,
		});
		var certType = '${form == null ? certType : form.certType}';
		$('#certType').val(certType);
		$('#certType').scroller({
			preset: 'select', 
			mode: 'scroller', 
			lang: 'zh',
			theme: 'android-holo light', 
			display: 'bottom', 
			animate: 'none',
			rows: 5,
		});
		var gender = '${form.gender}';
		if (gender == '' && certType == '01') {
			var certId = '${form == null ? certId : form.certId}';
			if (certId != '' && certId.length > 2) {
				certId = certId.substring(certId.length - 2, certId.length - 1);
				certId = parseInt(certId);
				gender = certId % 2 == 1 ? 'M' : 'F';
			} else {
				gender = 'M';
			}
		} else {
			gender = 'M';
		}
		$('#gender').val(gender);
		$('#gender').scroller({
			preset: 'select', 
			mode: 'scroller', 
			lang: 'zh',
			theme: 'android-holo light', 
			display: 'bottom', 
			animate: 'none',
			rows: 5
		});
	});
	function valid() {
		var cardNo = $("#cardNo").val();
		if (cardNo.isEmpty()) {
			$.pop.tips("请输入银行卡号");
			return false;
		}
		var openBankId = $("#openBankId").val();
		if (openBankId == '0000') {
			$.pop.tips("请选择开户行");
			return false;
		}
		var userName = $("#userName").val();
		if (userName.isEmpty()) {
			$.pop.tips("请输入持卡人姓名");
			return false;
		}
		var gender = $("#gender").val();
		if (gender == '') {
			$.pop.tips("请选择持卡人性别");
			return false;
		}
		var mobile = $("#mobile").val();
		if (mobile.isEmpty()) {
			$.pop.tips("请输入预留手机号");
			return false;
		}
		if (!mobile.isMobile()) {
			$.pop.tips("预留手机号格式不正确");
			return false;
		}
		var certType = $("#certType").val();
		if (certType.isEmpty()) {
			$.pop.tips("请选择证件类型");
			return false;
		}
		var certId = $("#certId").val();
		if (certId.isEmpty()) {
			$.pop.tips("请输入证件号");
			return false;
		}
		if (certId == '1' && !certId.isIdCard()) {
			$.pop.tips("证件号格式不正确");
			return false;
		}
		var payPassword = $("#payPassword").val();
		if (payPassword == '') {
			$.pop.tips("请输入支付密码");
			return false;
		}
		return true;
	}
	
	function submit() {
		if (valid()) {
			$.ios.ajax({
				url : '${ctx}/wap/user/chkpay?openid=${openid}',
				data : {payPassword:$("#payPassword").val()},
				success : function(response) {
					var flag = response.result == 1;
					if(flag) {
						$("#openBankName").val($("#openBankId option:selected").text());
						$("#form").submit();
					} else {
						$.pop.tips("支付密码不正确");
					}
				}  			
			});
		}
	}
</script>
</head>

<body>
<c:if test="${need_head}">
	<header> 
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<form id="form" action="${ctx}/wap/cnpay/ssure?openid=${openid}" method="post">
	<input type="hidden" id="openBankName" name="openBankName" />
	<input type="hidden" id="redirect_uri" name="redirect_uri" value="${redirect_uri}" />
	<section class="user" id="user">
		<div class="my">
			<img src="${img}/unionpay.png" />
			<h3 style="line-height:75px;padding-top:0;">绑定银行卡</h3>
		</div>
		<ul class="text">
	    	<li><span>持卡人姓名</span><input type="text" id="userName" name="userName" value="${form == null ? usrName : form.userName}" placeholder="请输入持卡人姓名"></li>
	    	<li><span>持卡人性别</span>
	    		<select id="gender" name="gender">
	        		<option value="M">男</option>
	        		<option value="F">女</option>
	        	</select>
	    	</li>
	    	
	        <li><span>证件类型</span>
	        	<select id="certType" name="certType">
	        		<option value="01">身份证</option>
	        		<option value="02">军官证</option>
	        		<option value="03">护照</option>
	        		<option value="04">户口簿</option>
	        		<option value="05">回乡证</option>
	        		<option value="06">其他</option>
	        	</select>
	        </li>
	        <li><span>证件号</span><input id="certId" type="text" name="certId" value="${form == null ? certId : form.certId }" placeholder="请输入证件号"></li>
	    </ul>
		<ul class="text">
			<li><span>开户行</span>
	        	<select id="openBankId" name="openBankId">
	        		<option value="0000">请选择开户行</option>
	    			<option value="0308">招商银行</option>
	    			<option value="0105">中国建设银行</option>
	    			<option value="0302">中信银行</option>
	    			<option value="0303">中国光大银行</option>
	    			<option value="0306">广东发展银行</option>
	    			<option value="0305">中国民生银行</option>
	    			<option value="0410">中国平安银行</option>
	        		<!-- <option value="0100">邮储银行</option> -->
	        		<!-- <option value="0102">中国工商银行</option> -->
	        		<!-- <option value="0103">中国农业银行</option> -->
	        		<!-- <option value="0104">中国银行</option> -->
	        		<!-- <option value="0301">交通银行</option> -->
	        		<!-- <option value="0307">深发展银行</option> -->
	        		<!-- <option value="0309">兴业银行</option> -->
	        	</select>
	        </li>
	        <li><span>银行卡号</span><input id="cardNo" name="cardNo" type="text" value="${form.cardNo}" placeholder="请输入银行卡号"></li>
	        <li><span>预留手机号</span><input type="text" id="mobile" name="mobile" value="${form == null ? mobile : form.mobile}" placeholder="请输入预留手机号"></li>
	        <li><span>支付密码</span><input type="password" id="payPassword" name="payPassword" value="" placeholder="请输入支付密码"></li>
	    </ul>
	    
	    <a class="login greenBg" href="javascript:submit();">下一步</a>
	    <p style="text-align: center; color: red; font-size: 16px;">${errmsg}</p>
	</section>
</form>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>