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
<title>${snm}</title>
<script type="text/javascript" src="${js}/jquery.js"></script>
<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
<style type="text/css">
	html, body {
		margin: 0;
		padding: 0;
		width: 100%;
		height: 100%;
		background:#212735;
	}
    html{font-size: 62.5%;/*10 ÷ 16 × 100% = 62.5%*/}
    body{font-style:1.4rem}
    #title{position:absolute;top:0;left:0;z-index:999;width:100%;/*background:yellow*/}
    #title article{margin:8% auto 0 auto;width:50%;height:70%;/*background:red;*/text-align:center;color:#f0f0f0;display:block;}
    #title article .name{line-height:0.8;font-size:1.4rem}
    #title article img{margin:20% auto 0 auto;width:80px;height:80px;border:1px solid #fff;border-radius:50% 50%;-webkit-border-radius:50% 50%;-moz-border-radius:50% 50%;-ms-border-radius:50% 50%;-o-border-radius:50% 50%;display:block;}
    /*@media screen and (max-height:480px){
         #title article{height:70%;}
         #title article img{margin-left:22px;margin-top:8px;width:80px;height:80px;}
    }
    */
    #title #error{width:100%;text-align:center;color:#fe4032;font-size:1.4rem;line-height:0.8;display:-none}
    #myCanvas{position:absolute;top:0;left:0;z-index:99;}
    footer{position:fixed;bottom:0;left:0;width:100%;height:10%;display:block;z-index:999;/*background:#000;*/}
    footer a:first-child{color:#fff;text-decoration:none;margin-left:9.6%;line-height:30px;font-size:1.4rem}
    footer a:last-child{color:#fff;text-decoration:none;float:right;margin-right:10%;line-height:30px;font-size:1.4rem}
</style>
<script type="text/javascript">
	OffsetX = 30, OffsetY = 30;
	var PointLocationArr = [];
	window.onload = function() {
		init();
	};

	// 初始化
	function init() {
		var canvasBox=document.getElementById("canvas");
		var canvasContent=document.createElement("canvas");
		canvasContent.setAttribute("id","myCanvas");
		canvasBox.appendChild(canvasContent);
       
		var c = document.getElementById("myCanvas");
		CW = document.body.offsetWidth;//画布宽
		CH = document.body.offsetHeight-40;//画布高
        R = CW*0.09;//半径
        c.width = CW;
        c.height = CH;
        var cxt = c.getContext("2d");
        //两个圆之间的外距离 就是说两个圆心的距离去除两个半径
        var X = (CW - 2 * OffsetX - R * 2 * 3) / 2;
        if (CH < 528) {
           var Y = (CH - 2 * OffsetY - R * 2 * 5.5) / 2;
        } else {
           var Y = (CH - 2 * OffsetY - R * 2 * 6.3) / 2;
        }
        
        PointLocationArr = CaculateNinePointLotion(X, Y, CH);//圆心数组
        InitEvent(c, cxt);
        // CW = 2*offsetX+R*2*3+2*X
        Draw(cxt, PointLocationArr, [],null);
    }
    //圆心
    function CaculateNinePointLotion(diffX, diffY, CH) {
		var Re = [];
        for (var row = 0; row < 3; row++) {
            for (var col = 0; col < 3; col++) {
				if (CH < 528) {
	               	var Point = {
	           			X: (OffsetX + col * diffX + ( col * 2 + 1) * R),
	                	Y: (OffsetY + row * diffY + (row * 2 + 1) * R + 150)
	                };
                	document.getElementById("title").style.height = 150 + "px";
              	} else {
                	var mT=document.body.offsetHeight*0.30;
                	var Point = {
                    	X: (OffsetX + col * diffX + ( col * 2 + 1) * R),
                    	Y: (OffsetY + row * diffY + (row * 2 + 1) * R + mT)
                    };
                    document.getElementById("title").style.height = mT + "px";
				}
				Re.push(Point);
            }
        }
        return Re;
   }
   
	function Draw(cxt, _PointLocationArr, _LinePointArr,touchPoint) {
       //
		if (_LinePointArr.length > 0) {
		cxt.beginPath();
			for (var i = 0; i < _LinePointArr.length; i++) {
                var pointIndex = _LinePointArr[i];
                cxt.lineTo(_PointLocationArr[pointIndex].X, _PointLocationArr[pointIndex].Y);
            }
            cxt.lineWidth =5;
            cxt.strokeStyle = "#627eed";
            cxt.stroke();
            cxt.closePath();
            if (touchPoint!=null) {
				var lastPointIndex = _LinePointArr[_LinePointArr.length - 1];
                var lastPoint = _PointLocationArr[lastPointIndex];
                cxt.beginPath();
                cxt.moveTo(lastPoint.X,lastPoint.Y);
                cxt.lineTo(touchPoint.X,touchPoint.Y);
                cxt.stroke();
                cxt.closePath();
			}
        }
        //画布画圆
        for (var i = 0; i < _PointLocationArr.length; i++) {
            var Point = _PointLocationArr[i];
            cxt.fillStyle = "#627eed";
            cxt.beginPath();
            cxt.arc(Point.X, Point.Y, R, 0, Math.PI * 2, true);//画圆 外框
            cxt.closePath();
            cxt.fill();
            cxt.fillStyle = "#ffffff";//颜色填充
            cxt.beginPath();
            cxt.arc(Point.X, Point.Y, R - 3, 0, Math.PI * 2, true);//画圆 里面
            cxt.closePath();
            cxt.fill();
            if(_LinePointArr.indexOf(i) >= 0) {
                cxt.fillStyle = "#627eed";
                cxt.beginPath();
                cxt.arc(Point.X, Point.Y, R -16, 0, Math.PI * 2, true);
                cxt.closePath();
                cxt.fill();
            }
        }
    }
    //p判断是否选中
    function IsPointSelect(touches,LinePoint){
        for (var i = 0; i < PointLocationArr.length; i++) {
            var currentPoint = PointLocationArr[i];
            var xdiff = Math.abs(currentPoint.X - touches.pageX);
            var ydiff = Math.abs(currentPoint.Y - touches.pageY);
            var dir = Math.pow((xdiff * xdiff + ydiff * ydiff), 0.5);
            if (dir < R ) {
                if (LinePoint.indexOf(i) < 0){ 
                   LinePoint.push(i);
				}
				break;
            }
        }
    }

    // touch事件
	function InitEvent(canvasContainer, cxt) {
        var LinePoint = [];
        var password=[];
		// 手势开始
        canvasContainer.addEventListener("touchstart", function (e) {
            IsPointSelect(e.touches[0],LinePoint);
        }, false);
        //手势中
        canvasContainer.addEventListener("touchmove", function (e) {
            e.preventDefault();
            var touches = e.touches[0];
            IsPointSelect(touches,LinePoint);
            cxt.clearRect(0,0,CW,CH);
            Draw(cxt,PointLocationArr,LinePoint,{X:touches.pageX,Y:touches.pageY});//画线
        }, false);
        //手势结束
        canvasContainer.addEventListener("touchend", function (e) {
			cxt.clearRect(0,0,CW,CH);
			Draw(cxt,PointLocationArr,LinePoint,null);
			for(var i=0;i<LinePoint.length;i++){
				password.push(LinePoint[i]+1);
			}
			document.getElementById("password").value = password.join("");
			
			if (oldTouchsPassword == '') {
				chktpw(password.join(""));
			} else {
				if (newTouchsPassword == '') {
					newTouchsPassword = password.join("");
					$("#error").html('请重复您的手势密码');
				} else {
					if (newTouchsPassword != password.join("")) {
						$("#error").html('重复密码错误,请再次设置');
					} else {
						rtpswd(password.join(""));
					}
				}
			}
			
			LinePoint = [];
			password = [];
			clearCanvas();
		}, false);         
 	}
	// 清除痕迹
	function clearCanvas() {
		var c = document.getElementById("myCanvas");
		c.remove();
		init();
	}
	var oldTouchsPassword = '';
	var newTouchsPassword = '';
	function reset() {
		$("#error").html('请设置新手势密码');
		newTouchsPassword = '';
	}
	function chktpw(password) {
		$.LD.ajax({
			url : '${ctx}/wap/user/chktpw?openid=${openid}',
			async : false, data : { 'touchsPassword' : password },
			success : function(response) {
				if (response.result == 1) {
					$("#error").html('请设置新手势密码');
					oldTouchsPassword = password;
				} else {
					$("#error").html('手势密码错误,请重新设置');
					oldTouchsPassword = '';
				}
			}
		});
	}
	function rtpswd(password) {
		$("#error").html('');
		$.ios.ajax({
			url : '${ctx}/wap/user/rtpswd?openid=${openid}',
			msg : { 
				text : '正在设置', succ : '设置成功',
				fail : '设置失败', warn : '系统繁忙'
			},
			data : { 
				'oldTouchsPassword' : oldTouchsPassword,
				'newTouchsPassword' : password,
			},
			success : function(response) {
				return {
					flag : response.result == 1 ? true : false,
					call : function(flag) {
						if (flag) {
							var url = '${ctx}/wap/user/center?openid=%s';
							location.href = url.format('${openid}');
						}
					}
				};
			}
		});
	}
</script>
</head>

<body>
<section id="title">
	<article>
		<c:if test="${union == null}">
       		<img id="img" src="${img}/headimage.jpg" />
  		</c:if>
		<c:if test="${union != null}">
     		<img id="img" src="${union.headimgurl}" />
		</c:if>
		<p class="name">${username}</p>
		<p id="error">请设置旧手势密码</p>
	</article>
</section>
<section id="canvas">
	<input id="password" type="hidden" value="">
</section>
<footer>
    <a href="${ctx}/wap/user/center?openid=${openid}">返回我的</a>
    <a href="javascript:reset();">重新设置</a>
</footer>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
