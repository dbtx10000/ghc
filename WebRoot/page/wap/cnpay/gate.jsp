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
<title>${snm}<c:if test="${!need_head}"> - 支付</c:if></title>
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
section .text .aPcard{width:100%;display:block;text-align:center;font-weight:bold;}
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
	var cardId = '';
	$(document).ready(function() {
		var $cards = $("#cards li.card");
		if ($cards != null) {
			$cards.click(function() {
				cardId = $(this).attr('card-id');
				$cards.find('span.chk').css({
					'color' : '#ccc', 'font-weight' : 'normal'
				});
				$(this).find('span.chk').css({
					'color' : 'red', 'font-weight' : 'bold'
				});
			});
		}
		$("#certType").val('${certType}');
		$('#openBankId').scroller({
			preset: 'select', 
			mode: 'scroller', 
			lang: 'zh',
			theme: 'android-holo light', 
			display: 'bottom', 
			animate: 'none',
			rows: 5,
		});
		$('#certType').scroller({
			preset: 'select', 
			mode: 'scroller', 
			lang: 'zh',
			theme: 'android-holo light', 
			display: 'bottom', 
			animate: 'none',
			rows: 3,
		});
	});
	function valid() {
		if (cardId.isEmpty()) {
			$.pop.tips("请选择银行卡");
			return false;
		}
		return true;
	}
	function sopen() {
		//先检查是否设置支付密码
		$.ios.ajax({
			url : '${ctx}/wap/user/exitpay?openid=${openid}',
			data : {},
			success : function(response) {
				var flag = response.result == 1;
				if(!flag) {
					$.pop.chio({
						text : '提示',
						note : '请您先设置支付密码',
						left : {
							text : '取消',
							call : function() {
								// operate
							}
						},
						rite : {
							text : '确认',
							call : function() {
								setpay();//跳向设置支付密码页面
							}
						}
					});
				} else {
					var url = '${ctx}/wap/cnpay/sopen?openid=%s&redirect_uri=%s';
					var redirect_uri = location.href.encode();
					location.href = url.format('${openid}', redirect_uri);
				}
			}  			
		});
	}
	
	function setpay() {
		var url = '${ctx}/wap/user/payset/1?openid=${openid}&redirect_uri=%s';
		url = url.format('${ctx}/wap/user/gotowx?openid=${openid}&from=bindcard'.encode().encode());
		location.href = url;
	}
	
	function spaid() {
		if (valid()) {
			if ('${hasPayPassword}' == 'false') {
				var link = '${ctx}/wap/user/payset/1?openid=%s&redirect_uri=%s';
				link = link.format('${openid}', location.href.encode().encode());
				$.pop.chio({
					'text' : '提示',
					'note' : '还未设置支付密码,是否前往设置?',
					'left' : {
						'text' : '否',
						'call' : function() {
							;
						}
					},
					'rite' : {
						'text' : '是',
						'call' : function() {
							location.href = link;
						}
					}
				});
			} else {
				iSafe(false);
			}
		}
	}
	function iSafe(auto, code) {
		var token = null;
		var link = '${ctx}/wap/user/payset/2?openid=%s&redirect_uri=%s';
		$.pop.safe({
			'imob' : '${mobile}',
			'send' : function(imob) {
				sends(imob);
			},
			'code' : code,
			'time' : 90,
			'auto' : auto,
			'isok' : function(code) {
				var url = '${ctx}/api/sms/isok?mobile=%s&type=%s&code=%s';
				var result = null;
				$.LD.ajax({
					url : url.format('${mobile}', 5, code),
					async : false, data : {},
					success : function(response) {
						result = response.result == 1;
						token = response.token;
					}
				});
				return result;
			},
			link : link.format('${openid}', location.href.encode().encode()),
			call : function(code, pswd) {
				var target = document.createElement("div");
				document.body.appendChild(target);
				var spinner = new Spinner(g_spinner_opt).spin(target);
				var overlay = iosOverlay({
					text	: '正在支付',
					spinner	: spinner
				});
				$.ajax({
					type : 'post', dataType : 'json', timeout : 6e4,
					url : '${ctx}/wap/cnpay/spaid?openid=${openid}',
					data : {
						payPassword : pswd, token : token,
						orderNo : '${order_no}', cardId : cardId
					},
					error : function(e) {
						window.setTimeout(function() {
							var l_fail_msg = '系统繁忙';
							overlay.update({
								icon 	: g_fail_ico,
								text	: l_fail_msg
							});
						}, 5e2);
						window.setTimeout(function() {
							overlay.hide();
						}, 1e3);
					},
					success : function(response) {
						if (response.result == 1) {
							window.setTimeout(function() {
								var l_succ_msg = '支付成功';
								overlay.update({
									icon 	: g_succ_ico,
									text	: l_succ_msg
								});
							}, 5e2);
						}
						window.setTimeout(function() {
							overlay.hide();
							window.setTimeout(function() {
								if (response.result == 1) {
									var url = '${ctx}/wap/cnpay/succ';
									url += '?orderNo=%s&openid=%s';
									url = url.format('${order_no}', '${openid}');
									location.href = url;
								} else {
									iTips(response, code);
								}
							}, 5e2);
						}, 1e3);
					}
				});
			}
		});
	}
	//发送验证码
	function sends(imob) {
		var url = '${ctx}/wap/user/exists?openid=${openid}&mobile=%s';
		$.LD.ajax({
			url : url.format(imob), async : false,
			success : function(response) {
				if (response.result != 1) {
					throw '手机号还未注册';
				} else {
					url = '${ctx}/api/sms/send?mobile=%s&type=%s&cost=${trans_amt}';
					$.LD.ajax({
						url : url.format(imob, 5), async : false,
						success : function(response) {
							if (response.result == 1) {
								$.pop.tips('短信验证码发送成功');
							} else {
								throw '发送频繁,请稍后...';
							}
						}
					});
				}
			}
		});
	}
	function iTips(response, code) {
		if (response.result == 2) {
			$.pop.chio({
				'text' : '提示',
				'note' : '支付密码错误,是否重新支付?',
				'left' : {
					'text' : '否',
					'call' : function() {
						;
					}
				},
				'rite' : {
					'text' : '是',
					'call' : function() {
						iSafe(false, code);
					}
				}
			});
		} else if (response.result == 3) {
			$.pop.chio({
				'text' : '提示',
				'note' : '还未设置支付密码,是否前往设置?',
				'left' : {
					'text' : '否',
					'call' : function() {
						;
					}
				},
				'rite' : {
					'text' : '是',
					'call' : function() {
						location.href = '${ctx}/wap/user/payset/2?openid=' +
							'${openid}&redirect_uri=' + location.href.encode();
					}
				}
			});
		} else {
			var msg = response.message;
			msg = unescape(msg.replace(/\\/gi, '%'));
			$.pop.tips(msg);
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
<section class="user" id="user">
	<div class="my">
		<img src="${img}/unionpay.png" />
		<h3 style="line-height:75px;padding-top:0;">银联支付</h3>
	</div>
	<ul class="text">
    	<li><span>支付单号</span><input type="text" id="orderNo" name="orderNo" value="${order_no}" readonly="readonly"></li>
        <li><span>支付金额</span><input type="text" id="transAmt" name="transAmt" value="<fmt:formatNumber pattern='0.00元' value='${trans_amt}' />" readonly="readonly"></li>
    </ul>
    <c:if test="${list != null && list.size() > 0}">
    	<p style="margin-left: 10px; font-size: 15px; font-weight: bold;">选择银行卡</p>
    </c:if>
   	<c:if test="${list != null && list.size() > 0}">
   		<ul class="text" id="cards">
   			<c:forEach var="cell" items="${list}">
				<li class="card" card-id="${cell.id}" style="text-align:right;"><span class="chk" style="color: #ccc;">√</span><span style="margin-left: 20px;">${cell.openBankName}</span>尾号${fn:substring(cell.cardNo, fn:length(cell.cardNo) - 4, fn:length(cell.cardNo))}</li>
			</c:forEach>
    	</ul>
   	</c:if>
   	<c:if test="${list.size() <= 0}">
    <ul class="text">
    	<li><a class="aPcard" href="javascript:sopen();">＋添加银行卡</a></li>
    </ul>
    </c:if>
	<!-- <ul class="text">
        <li><span>银行卡号</span><input id="cardNo" name="cardNo" type="text" placeholder="请输入银行卡号"></li>
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
        		<option value="0100">邮储银行</option>
        		<option value="0102">中国工商银行</option>
        		<option value="0103">中国农业银行</option>
        		<option value="0104">中国银行</option>
        		<option value="0301">交通银行</option>
        		<option value="0307">深发展银行</option>
        		<option value="0309">兴业银行</option>
        	</select>
        </li>
    </ul>
    <ul class="text"> 
    	<li><span>持卡人</span><input type="text" id="usrName" name="usrName" value="${usrName}" placeholder="请输入持卡人姓名"></li>
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
        <li><span>证件号</span><input id="certId" type="text" name="certId" value="${certId}" placeholder="请输入证件号"></li>
    </ul>-->
    <c:if test="${list != null}">
	    <a class="login greenBg" href="javascript:spaid();">确认支付</a>
    </c:if>
</section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>