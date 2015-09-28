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
<title>${snm}<c:if test="${!need_head}"> - 绑定信息确认</c:if></title>
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
.agreem{margin:0px auto;width:100%;display:block;line-height:24px;font-size:13px;}
.agreem a{color:#ff6147;/* text-decoration: underline; */}
.regist{position:relative;top:-10px;left:14%;display:inline-block;text-align:center;width:80%;}
.flat{position:absolute;top:1px;left:-20px;width:20px;height:20px;display:inline-block;background-image: url(${img}/flat@2x.png);-webkit-background-size: 176px 22px;background-size: 176px 22px;}
.pos{position:absolute;top:0px;left:0;} 
.checked{background-position: -22px 0;}
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
	function agreementH() {
		$("#agreemContent").hide();
	}
	function agreementS() {
		$("#agreemContent").show();
	}
	
	function save() {
		var checked=$("#resgreem").attr("checked");
		if (checked=="checked") {
			$("#form").submit();
		} else {
			var content="<p style='line-height:30px;'>请阅读并同意<br/>《资金代扣授权与承诺书》</p>";
			$.pop.tips(content);
			return;
		}
	}
</script>
</head>
<body>
<c:if test="${need_head}">
	<header>
		绑定信息确认
		<a href="javascript:history.go(-1);" class="back">返回</a>
	</header>
</c:if>
<form id="form" action="${ctx}/wap/cnpay/sopen?openid=${openid}" method="post">
	<input type="hidden" id="cardNo" name="cardNo" value="${form.cardNo }"/>
	<input type="hidden" id="mobile" name="mobile" value="${form.mobile }"/>
	<input type="hidden" id="userName" name="userName" value="${form.userName }"/>
	<input type="hidden" id="certType" name="certType" value="${form.certType }"/>
	<input type="hidden" id="certId" name="certId" value="${form.certId }"/>
	<input type="hidden" id="gender" name="gender" value="${form.gender }"/>
	<input type="hidden" id="openBankId" name="openBankId" value="${form.openBankId }"/>
	<input type="hidden" id="openBankName" name="openBankName" value="${form.openBankName }"/>
	<input type="hidden" id="redirect_uri" name="redirect_uri" value="${redirect_uri }"/>
	<section class="user" id="user">
		<div class="my">
			<img src="${img }/unionpay.png" />
			<h3 style="line-height:75px;padding-top:0;">绑定银行卡－信息确认</h3>
		</div>
		<article class="config">
			<h3>个人信息</h3>
			<p>持卡人姓名<span>${form.userName }</span></p>
			<p>性别<span>${form.gender == 'M' ? '男' : '女' }</span></p>
			<p>证件类型<span>身份证</span></p>
			<p>证件号<span>${form.certId }</span></p>
		</article>
		<article class="config">
			<h3>银行卡信息</h3>
			<p>开户行<span>${form.openBankName }</span></p>
			<p>银行卡号<span>${form.cardNo }</span></p>
			<p>预留手机号码<span>${form.mobile }</span></p>
		</article>
		<a class="btn" href="javascript:save()">下一步</a>
		<p class="regist ">
    		<span class="flat checked"></span>
    		<input type="checkbox" id="resgreem" checked="checked" style="display:none;">
    		<span class="agreem pos">我已阅读并同意<a style="text-align:left;"  href="javascript:agreementS();">《资金代扣授权与承诺书》</a></span>
    	</p>
		<!-- <p><span class="agreem pos" >下一步默认同意<a style="text-align:left;"  href="javascript:agreementS();">《资金代扣授权与承诺书》</a></span>
    </p> -->
	</section>
	<section id="agreemContent" class="about">
		<article style="font-family: '黑体';">
			<h4 style="text-align: center;">资金代扣授权与承诺书</h4>
			<br>
			<p>授权人姓名：<span id="showRealName">${user.realname }</span></p>
			<p>身份证号：<span id="showCertId">${user.credentialsCode }</span></p>
			<p>高和畅用户名：${user.username}</p>
			<p>被授权人：天津畅和股权投资基金管理有限公司（下简称“畅和基金”）</p>
			<p>授权人就其向畅和基金指定的第三方托管账户进行资金代扣的相关事宜向畅和基金授权如下：</p>
			<p>一、授权人授权畅和基金以代扣指令的方式通过畅和基金指定的银行/第三方支付机构从授权人银行账户（如本授权书第二条所述）中代为扣收相关款项，该等款项用于授权人向畅和基金指定的第三方托管账户进行认购基金份额/受益权/债权/有限合伙份额等金融产品投资款的缴纳。</p>
			<p>二、授权人的银行账户如下：</p>
			<p>户名：<span id="showUserName">${form.userName }</span></p>
			<p>账号：<span id="showCardNo">${form.cardNo }</span></p>
			<p>开户银行：<span id="showBankName">${form.openBankName }</span></p>
			<p>三、授权人知晓并同意，本授权书自授权人在畅和基金的互联网在线平台高和畅在线点击“确认”时生效，授权人确认由畅和基金通过畅和基金指定的银行/第三方支付机构从授权人的银行账户中代扣相当于授权人认购基金份额/受益权/债权/有限合伙份额等金融产品投资款的款项。授权人已经通过本授权书确认用以代扣上述款项的银行账户信息。在代扣的过程中，畅和基金根据本授权书提供的银行账户信息进行相关操作，无需再向授权人确认银行账户信息和密码。本授权书一经生效即不可撤销。授权人确认并承诺，畅和基金根据本授权书的约定所采取的全部行动和措施的法律后果均由授权人承担。</p>
			<p>四、授权人知晓并同意，因受授权人银行账户状态、银行、第三方支付机构及网络等原因所限, 本授权书项下的代扣金额可能会通过多次代扣交易方可完成,畅和基金不对代扣服务的资金到账时间做任何承诺。畅和基金或畅和基金指定的银行/第三方支付机构仅根据本授权书所述的授权范围进行相关操作, 畅和基金或畅和基金指定的银行或第三方支付机构无义务对其根据本授权书的约定所采取的全部行动和措施的时效性和结果承担任何责任。 </p>
			<p>特此授权。 </p>
		</article>
		<ul class="successBtn">
		   	<li><a class="btn orangeBg" href="javascript:agreementH();">返回</a></li>
		   	<!-- <li><a class="btn redBg" href="javascript:spaid();">支付</a></li> -->
		</ul>
	</section>
</form>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>