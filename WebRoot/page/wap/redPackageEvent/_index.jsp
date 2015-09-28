<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width , initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>高和畅 - 发金币</title>
<link type="text/css" rel="stylesheet" href="${css}/hongbao.css" />
<script type="text/javascript" src="${js}/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script>
	function tipsShow(){
		document.getElementById("tipPid").style.display="block";
	}
</script>
</head>
<body class="beijing">
    <div class="elephant">
        <div class="left-elephant"></div>
        <div class="right-elephant"></div>
    </div>
    <div class="receive"><a href="javascript:tipsShow();"></a></div>
    <div class="golden">金钥匙</div>
    <div class="contain">
        <div class="explan">
          <p class="title">京沪核心商业物业类资产证券化产品</p>
          <p class="wenzi">以北京东三环地铁上盖写字楼为底层基础资产的类资产证券化产品，以万元的资金门槛便于可参与短期限、高收益、高保障的理财产品。</p>
          <div class="sankuai">
             <div class="feilei feilei01"><p class="sma-tit">期&nbsp;&nbsp;限</p><p class="number">15天</p></div>
             <div class="feilei feilei02"><p class="lilv">预期年化</br>收益率</p><p class="baifen">8.0%</p></div>
             <div class="feilei feilei01"><p class="sma-tit">投资金额</p><p class="number02">1000元</p></div>
          </div>
        </div>
        <div class="rules">
          <p class="biaoti">&bull;活动规则&bull;</p>
          <div class="gzshuoming">
             <p class="tiaoli"> ■ 活动时间：${eventDate}</p>
             <p class="tiaoli"> ■ 活动奖励将于分享朋友圈后以高和畅金币方式发放到参与活动的客户账户内；</p>
             <p class="tiaoli"> ■ 请确保已注册高和畅平台，否则将导致金币无法发送至个人账户；</p>
             <p class="tiaoli"> ■ 本次活动红包所得金币有效期为48小时，过期自动清空；</p>
             <p class="tiaoli"> ■ 本次活动由高和畅平台举办，最终解释权归高和畅平台所有。</p>
          </div>
        </div>
    </div>
    <div class="rule"><a class="guize" href="#">活动规则</a></div>
    <div class="rule01"><a class="guize01" href="javascript:history.go(-1);">返回</a></div>

    <div id="tipPid" style="display: none" class="tip">
      <div class="point">
        <p><span>1</span>点击右上角图标</p>
        <p><span>2</span>在弹出菜单中选择分享到朋友圈</p>
        <p><span>3</span>领取金币</p>
      </div>
    </div>
</body>
<%@ include file="/jsp/shared.jsp"%>
<script type="text/javascript">
	wx.ready(function () {
		wx.onMenuShareAppMessage({
			title	: '领取畅享季金币，预期年化收益率最高可达136.49%！',	// 分享标题
			desc	: '${shareEventDate}高和畅金币大放送！',	// 分享描述
			link	: '${lctx}/wap/redPackageEvent/index?id=${redPackageEventId}',	// 分享链接
			imgUrl	: '${lctx}/images/red_pack.png',	// 分享图标
			type	: 'link',	// 分享类型,music、video或link，不填默认为link
			dataUrl	: '',	// 如果type是music或video，则要提供数据链接，默认为空
			success	: function () { 
				// 用户确认分享后执行的回调函数
				location.href='${lctx}/wap/redPackageEvent/getRedPackage?redPackageEventId=${redPackageEventId}&userId=${userId}';
			},
			cancel	: function () { 
				// 用户取消分享后执行的回调函数
			}
		});
		wx.onMenuShareTimeline({
			title	: '领取畅享季金币，预期年化收益率最高可达136.49%！',	// 分享标题
			link	: '${lctx}/wap/redPackageEvent/index?id=${redPackageEventId}',	// 分享链接
			imgUrl	: '${lctx}/images/red_pack.png', // 分享图标
			success	: function () { 
				// 用户确认分享后执行的回调函数
				location.href='${lctx}/wap/redPackageEvent/getRedPackage?redPackageEventId=${redPackageEventId}&userId=${userId}';
	
			},
			cancel	: function () { 
				// 用户取消分享后执行的回调函数
			}
		});
	});
</script>
</html>