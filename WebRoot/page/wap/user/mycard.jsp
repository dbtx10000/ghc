<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="version" content="goHigh  2015">
    <meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
    <meta http-equiv="x-dns-prefetch-control" content="on" />
	<link type="text/css" rel="stylesheet" href="${css}/bankcard.css" />
	<title>${snm}<c:if test="${!need_head}"> - 我的银行卡</c:if></title>
	<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
	<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script type="text/javascript">
	function bind() {
		var url = '${ctx}/wap/cnpay/sopen?openid=${openid}&redirect_uri=%s';
		location.href = url.format(location.href.encode().encode());
	}
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
<style>
	
body {
	font-family: serif;
	background: #e1e0dd;
}
.cardList{margin:10px auto;width:100%;display: block;background:#fff}

.cardList ul{margin:0 auto;width:92%}

.cardList ul li{cursor:pointer;width:100%;border-bottom:1px solid #e4e4e4;display:block;overflow:hidden;zoom: 1;background: #fff url("${img}/icon_more_1.png") no-repeat scroll right 13px / 44px auto;}

.cardList ul li:last-child{border:none;}

.cardList ul li .img{width:188px;height:36px; margin-top:18px; float:left;}

.cardList ul li .name{float:right;margin-right:30px; line-height:72px;font-weight: 500;}

.btn{width:100%;text-align:center; color:#fff; font-size:17px; line-height:44px; height:44px; display:block;background:#ef4023; }

.noCard{margin-top:100px;font-weight:bold;font-size:12px;text-align:center;color:#8e8e8e;}

</style>
</head>

<body class="bankcard">
	<!-- 
		背景图片：                  银行LOGO className：
		CCB_bg.png     建设银行       CCBpic
		CEB_bg.png     光大银行       CEBpic
		CGB_bg.png     广发银行       CGBpic
		CITIC_bg.png   中信银行       CITICpic
		CMB_bg.png     招商银行       CMBpic
		CMBC_bg.png    民生银行       CMBCpic
		ICBC_bg.png    工商银行       ICBCpic
		pingan_bg.png  平安银行		 pinganpic
	-->
	<!-- 有绑卡  S -->
	<c:if test="${card!=null}">
		<div class="cardBg">
			<c:choose>
				<c:when test="${card.openBankId=='0102'}"><img src="${img}/bankcard/ICBC_bg.png" alt=""></c:when>
				<c:when test="${card.openBankId=='0105'}"><img src="${img}/bankcard/CCB_bg.png" alt=""></c:when>
				<c:when test="${card.openBankId=='0302'}"><img src="${img}/bankcard/CITIC_bg.png" alt=""></c:when>
				<c:when test="${card.openBankId=='0303'}"><img src="${img}/bankcard/CEB_bg.png" alt=""></c:when>
				<c:when test="${card.openBankId=='0305'}"><img src="${img}/bankcard/CMBC_bg.png" alt=""></c:when>
				<c:when test="${card.openBankId=='0306'}"><img src="${img}/bankcard/CGB_bg.png" alt=""></c:when>
				<c:when test="${card.openBankId=='0308'}"><img src="${img}/bankcard/CMB_bg.png" alt=""></c:when>
				<c:when test="${card.openBankId=='0410'}"><img src="${img}/bankcard/pingan_bg.png" alt=""></c:when>
			</c:choose>
		</div>
	    <div class="card">
	        <h5 class="bankname">
	        	<!-- logo -->
	       		<c:choose>
				<c:when test="${card.openBankId=='0102'}"><span class="bank ICBCpic"></span></c:when>
				<c:when test="${card.openBankId=='0105'}"><span class="bank CCBpic"></span></c:when>
				<c:when test="${card.openBankId=='0302'}"><span class="bank CITICpic"></span></c:when>
				<c:when test="${card.openBankId=='0303'}"><span class="bank CEBpic"></span></c:when>
				<c:when test="${card.openBankId=='0305'}"><span class="bank CMBCpic"></span></c:when>
				<c:when test="${card.openBankId=='0306'}"><span class="bank CGBpic"></span></c:when>
				<c:when test="${card.openBankId=='0308'}"><span class="bank CMBpic"></span></c:when>
				<c:when test="${card.openBankId=='0410'}"><span class="bank pinganpic"></span></c:when>
			</c:choose>${card.openBankName }
	       	</h5>
	       	<%--<a href="#" class="tips">
	            <!--提示内容： 解绑银行卡时，请确保账户余额为0，无在途交易且持有产品均已届返款日 -->
	        </a>
	        --%><p class="numb"><span>**** **** **** </span>${fn:substring(card.cardNo, fn:length(card.cardNo) - 4, fn:length(card.cardNo))}</p>
	        <!-- 解绑btn -->
	        <%--<a href="javascript:lose();" class="jiebang">解绑</a>
	    --%></div>
    </c:if>
	<!-- 有绑卡  E -->
	
    <!-- 没有绑卡时  S -->
    <c:if test="${card==null}">
	    <p class="tips">亲~您还没有绑定银行卡哦~</p>
	    <a href="javascript:bind();" class="addbutton">+ 添加银行卡</a>
    </c:if>
    <!-- 没有绑卡时  E -->
    
</body>
</html>
