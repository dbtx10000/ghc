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
<meta name="version" content="GoHigh v1.1 20150320">
<meta name="author" content="zalon" />
<meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
<meta http-equiv="x-dns-prefetch-control" content="on" />
<title>高和畅 - 畅享七夕</title>
<link type="text/css" rel="stylesheet" href="${css}/seventh.css" />
<script type="text/javascript" src="${js }/zepto.min.js"></script>
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script>
var gender='';
    $(function(){
        var w_width=$(window).width();
        var w_height=$(window).height();
        $(".background").height(w_height);
        chose();
    });
    //获取性别
    function chose(){
    	
        $("input[type='radio']").each(function(){
        	$(this).removeAttr("checked");
            $(this).on("click",function(){
                gender=$(this).val();
            });
        })
    }

function sumit(){
if($("#name").val()==''){
	$.pop.tips("请输入姓名");
	return ;
}else if(gender==''){
	$.pop.tips("请选择性别");
	return ;
}
location.href = '${ctx}/wap/share/qixi/2?openid=${openid}&name='+$("#name").val().encode().encode()+"&gender="+gender;
}
</script>
</head>

<body>
<div class="background">
	<div class="after">
        <div class="write">
         <input type="name" class="write" name="name" id="name" placeholder="您的姓名"/>
        </div>
        <div class="gender">
        	<div class="boy">
            	<div class="radio">
                 <input type="radio" name="choice" value="boy" /><span></span>   
                </div><span>男</span>
                
            </div>
            <div class="girl">
            	<div class="radio">
                 <input type="radio" name="choice" value="girl" /><span></span>   
                </div><span>女</span>
            </div>
        </div>
        <a class="btn" href="javascript:;;" onclick="sumit()">提交</a>
    </div>
</div>
</body>
<%@ include file="/jsp/shared.jsp"%>
<script type="text/javascript">
	wx.ready(function () {
		wx.onMenuShareAppMessage({
			title	: '送你一份私人订制七夕礼！',	// 分享标题
			desc	: '金钥匙畅享七夕理财计划',	// 分享描述
			link	: '${lctx}/wap/share/qixi/1',	// 分享链接
			imgUrl	: '${lctx}/images/qixi/qixi_share.png',	// 分享图标
			type	: 'link',	// 分享类型,music、video或link，不填默认为link
			dataUrl	: '',	// 如果type是music或video，则要提供数据链接，默认为空
			success	: function () { 
				// 用户确认分享后执行的回调函数
			},
			cancel	: function () { 
				// 用户取消分享后执行的回调函数
			}
		});
		wx.onMenuShareTimeline({
			title	: '送你一份私人订制七夕礼！',	// 分享标题
			link	: '${lctx}/wap/share/qixi/1',	// 分享链接
			imgUrl	: '${lctx}/images/qixi/qixi_share.png',	// 分享图标
			success	: function () { 
				// 用户确认分享后执行的回调函数

			},
			cancel	: function () { 
				// 用户取消分享后执行的回调函数
			}
		});
	});
</script>
</html>
