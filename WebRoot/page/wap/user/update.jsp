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
<title>${snm}<c:if test="${!need_head}"> - 完善信息</c:if></title>
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
		$('#credentialsType').val('${object.credentialsType}');
		$('#credentialsType').scroller({
			preset: 'select', 
			mode: 'scroller', 
			lang: 'zh',
			theme: 'android-holo light', 
			display: 'bottom', 
			animate: 'none',
			rows: 3,
		});
		$(".login").click(function() {
			var realname = $("#realname").val();
			if (realname.isEmpty()) {
				$.pop.tips("请输入姓名");
				return;
			}
			if (!realname.isName()) {
				$.pop.tips("姓名格式不正确");
				return;
			}
			var credentialsType = $("#credentialsType").val();
			if (credentialsType.isEmpty()) {
				$.pop.tips("请输选择证件类型");
				return;
			}
			var credentialsCode = $("#credentialsCode").val();
			if (credentialsCode.isEmpty()) {
				$.pop.tips("请输入证件号");
				return;
			}
			if (credentialsType == '1' && !credentialsCode.isIdCard()) {
				$.pop.tips("身份证格式不正确");
				return;
			}
			var email = $("#email").val();
			if (email.isNotBlank() && !email.isEmail()) {
				$.pop.tips("邮箱格式不正确");
				return;
			}
			var msg, url = '${ctx}/wap/user/%s?openid=${openid}';
			if ('${mode}' == '1') {
				url = url.format('regist');
				msg = {
					text : '正在注册', succ : '注册成功',
					fail : '注册失败', warn : '系统繁忙'
				};
			} else {
				url = url.format('update');
				msg = {
					text : '正在更新', succ : '更新成功',
					fail : '更新失败', warn : '系统繁忙'
				};
			}
			$.ios.ajax({
				url : url, msg : msg, data : {
					'mobile' : $("#mobile").val(),
					'password' : '${object.password}',
					'pid' : '${object.pid}',
					'salerId' : '${salerId}',
					'token' : '${token}',
					'realname' : realname,
					'credentialsType' : credentialsType,
					'credentialsCode' : credentialsCode,
					'address' : $("#address").val(),
					'email' : email
				},
				success : function(response) {
					return {
						flag : response.result == 1,
						call : function(flag) {
							if (flag) {
								forward(response);
							}
						}
					};
				}
			});		
		});
	});
	function forward(response) {
		if (response.data != null) {
			location.href = '${ctx}' + response.data + '?openid=${openid}';
		} else {
			var redirect_uri = '${redirect_uri}';
			if (redirect_uri.isEmpty()) {
				if ('${mode}' == '1') {
					redirect_uri = '${ctx}/wap/index?openid=${openid}';
				} else {
					redirect_uri = '${ctx}/wap/user/center?openid=${openid}';
				}
			} else {
				redirect_uri = '${redirect_uri}'.decode();
				if (redirect_uri.indexOf('openid=') == -1) {
					if (redirect_uri.indexOf('?') > -1) {
						redirect_uri += '&openid=${openid}';
					} else {
						redirect_uri += '?openid=${openid}';
					}
				}
			}
			location.href = redirect_uri;
		}
	}
</script>
</head>

<body>
<c:if test="${need_head}">
	<header>
		完善资料
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<section class="user">
	<div class="my" style="border:none;background:#ff6147;">
		<c:if test="${union == null}">
	   		<img src="${img}/pic_default.png" />
		</c:if>
		<c:if test="${union != null}">
	   		<img src="${union.headimgurl}" />
		</c:if>
	    <h3 style="line-height:75px;padding-top:0;"><c:if test="${object.type != 1}">普通用户</c:if><c:if test="${object.type == 1}">VIP用户</c:if></h3>
   </div>
	<ul class="text">
    	<li><span>姓 名</span><input id="realname" name="realname" type="text" value="${object.realname}" placeholder="请输入姓名"></li>
        <!-- 为选择证件时 -->
        <li><span>证件类型</span>
        	<select id="credentialsType" name="credentialsType">
        		<option value="01">身份证</option>
        		<option value="02">军官证</option>
        		<option value="03">护照</option>
        		<option value="04">户口簿</option>
        		<option value="05">回乡证</option>
        		<option value="90">港澳通行证</option>
        		<option value="06">其他</option>
        	</select>
        </li>
        <li><span>证件号码</span><input id="credentialsCode" name="credentialsCode" type="text" value="${object.credentialsCode}" placeholder="请输入证件号码"></li>
    </ul>
    <ul class="text">
    	<li><span>电 话</span><input id="mobile" name="mobile" type="text" value="${object.mobile}" disabled="disabled"></li>
        <li><span>地 址</span><input id="address" name="address" value="${object.address}" type="text" placeholder="请输入地址"></li>
        <li><span>邮 箱</span><input id="email" name="email" type="text" value="${object.email}" placeholder="请输入邮箱"></li>
    </ul>
    <a class="login greenBg" href="javascript:;">
    	<c:choose>
    		<c:when test="${mode == 1}">
    			<c:choose>
    				<c:when test="${unv == 'true'}">
    					<c:choose>
    						<c:when test="${empty(object.pid)}">
    							<c:choose>
		    						<c:when test="${unv_for_own == 'true'}">
		    							提交审核
		    						</c:when>
		    						<c:otherwise>
		    							立即注册
		    						</c:otherwise>
		    					</c:choose>
    						</c:when>
    						<c:otherwise>
    							<c:choose>
		    						<c:when test="${unv_for_inv == 'true'}">
		    							提交审核
		    						</c:when>
		    						<c:otherwise>
		    							立即注册
		    						</c:otherwise>
		    					</c:choose>
    						</c:otherwise>
    					</c:choose>
    				</c:when>
    				<c:otherwise>
    					立即注册
    				</c:otherwise>
    			</c:choose>
    		</c:when>
    		<c:otherwise>
    			完善信息
    		</c:otherwise>
    	</c:choose>
    </a>
</section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>