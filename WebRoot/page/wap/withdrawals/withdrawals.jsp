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
  <title>提现</title>
  <link type="text/css" rel="stylesheet" href="${css}/balance.css" />
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
  <script>
    function getAll(t){
      var checked=$(t).hasClass('check');
      if(checked){
        $(t).removeClass('check').addClass('uncheck');
        $("#write").val("");
        $("#write").removeAttr("readonly");
      }else{
        $(t).removeClass('uncheck').addClass('check');
        var allMoney=$("#money").html();
        $("#write").val(allMoney);
        
        $("#write").attr("readonly","readonly");
      }
    }
    /**确认提现**/
    function submit() {
    	 var money = $("#write").val();
    	 var surplusMoney = $("#money").val();
		if (!money.isEmpty()) {
			if(money != parseFloat(money)||parseFloat(money)==0){
				$.pop.tips("金额格式不正确!");
				return;
			}else{
				if(money>surplusMoney){
					$.pop.tips("余额不足!");
					return;
				}else{
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
		}else{
			$.pop.tips("请输入金额!");
			return;
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
				$(".confirm").attr("href","#");
				
				var target = document.createElement("div");
				document.body.appendChild(target);
				var spinner = new Spinner(g_spinner_opt).spin(target);
				var overlay = iosOverlay({
					text	: '正在处理',
					spinner	: spinner
				});
				$.ajax({
					type : 'post', dataType : 'json', timeout : 6e4,
					url : '${ctx}/wap/withdrawals/sure?openid=${openid}&userId=${userId}&money='+$("#write").val(),
					data : {
						payPassword : pswd
					},
					error : function(e) {
						$(".confirm").attr("href","javascript:submit();");
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
						$(".confirm").attr("href","javascript:submit();");
						if (response.result == 1) {
							window.setTimeout(function() {
								var l_succ_msg = '处理成功';
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
									var url = '${ctx}/wap/withdrawals/success?openid=${openid}&money='+$("#write").val();
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
		} else if(response.result == -1){
			location.href = '${ctx}/wap/recharge/fail?openid=${openid}';
		}else{
			var msg = response.message;
			msg = unescape(msg.replace(/\\/gi, '%'));
			$.pop.tips(msg);
		}
	}
  </script>
</head>
<!-- /*
  依次为： className
  招商银行 cmcpic
  建设银行 ccbpic
  光大银行 cebpic
  广发银行 cgbpic
  中信银行 citicpic
  民生银行 cmbcpic
  工商银行 icbcpic
  平安银行 pinganpic
*/ -->
<body>
  <c:if test="${need_head}">
	    <header>
	      提现
	      <a href="javascript:history.go(-1);" class="back">返回</a>
	    </header>
    </c:if>
   <div class="bank">
      <p class="banknumber">
      	<c:choose>
	   		<c:when test="${card.openBankId=='0102'}"><span class="bankpic cmcpic"></span></c:when>
			<c:when test="${card.openBankId=='0105'}"><span class="bankpic ccbpic"></span></c:when>
			<c:when test="${card.openBankId=='0302'}"><span class="bankpic citicpic"></span></c:when>
			<c:when test="${card.openBankId=='0303'}"><span class="bankpic cebpic"></span></c:when>
			<c:when test="${card.openBankId=='0305'}"><span class="bankpic cmbcpic"></span></c:when>
			<c:when test="${card.openBankId=='0306'}"><span class="bankpic cgbpic"></span></c:when>
			<c:when test="${card.openBankId=='0308'}"><span class="bankpic cmbpic"></span></c:when>
			<c:when test="${card.openBankId=='0410'}"><span class="bankpic pinganpic"></span></c:when>
		</c:choose>
      ${card.openBankName }<span>（尾号**${fn:substring(card.cardNo, fn:length(card.cardNo) - 4, fn:length(card.cardNo))}）</span></p>
   </div>
   <div class="bankcash">
    <ul class="bankcashlist">
      <li>
         <p>全部提现</p>
         <a class="cashcheck uncheck" href="javascript:void(0);" onclick="getAll(this)"></a>
      </li>
      <li>
         <p>提现金额</p>
         <input id="write"  class="inputmoney" type="number" placeholder="请输入金额"/>
      </li>
    </ul>
   </div>
   <p class="pbalance">当前账户余额<span id="money">${surplusBalance}</span>元</p>
   <a class="confirm" href="javascript:submit();">确认转出</a>
   <p class="tipnumb">今天还可以转出<span>${withdrawalsNumber}</span>次</p>
</body>
</html>
