<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" href="${css }/ghc_beta_1.0.css">
<title>${snm}<c:if test="${!need_head}"> - 银行卡信息</c:if></title>
<style>
	
body {
	font-family: serif;
	background: #e1e0dd;
}
.user{padding-bottom:30px}
.user .my{ height:75px; }
#user  .my img{width:65px;top:5px;left:8px;height:auto;}
.user .config{margin:10px auto 0 auto;padding-bottom:15px;width:95%;background:#fff;border-top:4px solid #fe4023;border-bottom:1px solid #e4e4e4;line-height:32px}
.user .config h3{font-size:20px;text-align:center;border-bottom:1px solid #e4e4e4;line-height:38px}
.user .config p{padding:0 4%;font-size:16px;border-bottom:1px solid #e4e4e4;display:block;overflow:hidden;zoom:1;}
.user .config p span{float:right;}
.user .btn{margin:20px auto 10px auto ;width:92%;text-align:center; color:#fff; font-size:17px; line-height:37px; height:37px; display:block;background:#ef4023; border-radius:4px; -moz-border-radius:4px; -ms-border-radius:4px; -o-border-radius:4px; -webkit-border-radius:4px;}
.agreem{margin:0px auto;width:80%;display:block;line-height:30px;font-size:13px;}
.agreem a{color:#fe4023}
#agreemContent {position:absolute;top:0;left:0;padding-bottom:80px;display:none;background:#fff;z-index:99;}
#agreemContent{margin:0 auto;width:100%}
#agreemContent article{margin:8px auto  10px auto;padding:18px 8px 8px 8px;width:90%;background:#fff;box-shadow:0 5px 20px #000}
#agreemContent article p {margin:0 auto;font-size:12px;display:block;width:95%;text-indent:20px}
#agreemContent .count {text-align:center;}
#agreemContent .count span{position:absolute;top:0;left:0;width:20px;}
#agreemContent .lCount {margin-right:10px;font-weight:bold;}
.successBtn {position:fixed;bottom:0;left:0;z-index:999;padding:10px 0;margin:10px auto 0 auto;width:100%;border-top:1px solid #e4e4e4;display:block;overflow:hidden;zoom:1;background:#f6f6f6;}
.successBtn li{float:left;width:100%;height:40px;line-height:40px;}
.successBtn .btn{margin:0 auto;width:90%;display:block;text-align:center;color:#fff;}
</style>
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script>
	function lose() {
		$.pop.chio({
			text : '提示',
			note : '是否确认删除银行卡?',
			left : {
				text : '否',
				call : function() {
					// operate
				}
			},
			rite : {
				text : '是',
				call : function() {
					$.ios.ajax({
						url : '${ctx}/wap/user/unwrap?openid=${openid}&cardId=${object.id}',
						msg : { text : '正在删除', succ : '删除成功', fail : '删除失败', 'warn' : '系统繁忙' },
						success : function(response) {
							return { 
								flag : response.result == 1,
								call : function(flag) {
									if (flag) {
										location.href = '${ctx}/wap/user/mycard?openid=${openid}';
									}
								}
							};
						}
					});
				}
			}
		});
	} 
</script>
</head>
<body>
<c:if test="${need_head}">
	<header>
		银行卡信息
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<section class="user" id="user">
	<article class="config">
		<h3>银行卡信息</h3>
		<p>开户行<span>${object.openBankName}</span></p>
		<p>银行卡号<span>${object.cardNo}</span></p>
	</article>
	<article class="config">
			<h3>持卡人信息</h3>
			<p>持卡人姓名<span>${object.userName}</span></p>
			<p>性别<span>${object.gender == 'M' ? '男' : '女'}</span></p>
			<p>证件类型<span>身份证</span></p>
			<p>证件号<span>${object.certId}</span></p>
		</article>
	<a class="btn" href="javascript:lose();">删除银行卡</a>
</p>
</section>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>