<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!doctype html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection" content="telephone=no" />
    <meta http-equiv="Cache-Control" content="must-revalidate,no-cache">
    <meta http-equiv="x-dns-prefetch-control" content="on" />
    <title>${snm}<c:if test="${!need_head}"> - 礼品订单</c:if></title>
    <link type="text/css" rel="stylesheet" href="${css}/ghc_gift_1.0.css" />
    <script type="text/javascript" src="${js}/jquery.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/core.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/jquery.sot.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/overlay/init.js"></script>
	<script type="text/javascript" src="${js}/LD.sot/pop.ups/init.js"></script>
    <style type="text/css">
    	#orders {
    		width: 100%; font-size: 14px; margin-bottom: 54px;
    	}
    	#orders li {
    		border: 1px solid #f5f5f5; height: 154px; margin-top: 10px; background: #fff; text-indent: 10px;
    	}
    	#orders li.material {
    		border: 1px solid #f5f5f5; height: 185px; margin-top: 10px; background: #fff; text-indent: 10px;
    	}
    	#orders li div.head {
    		height: 30px; line-height: 30px; width: 100%; border-bottom: 1px solid #f5f5f5;
    	}
    	#orders li div.head span.stat {
    		float: right; margin-right: 10px;
    	}
    	#orders li div.body {
    		margin-top: 10px; height: 80px; border-bottom: 1px solid #f5f5f5; cursor: pointer; background: #fff url('${img}/icon_more_2.png') no-repeat scroll right 13px / 44px auto;
    	}
    	#orders li div.body .img {
    		height: 70px; width: 70px; float: left;
    	}
    	#orders li div.body .img img {
    		height: 70px; width: 70px; border: none;
    	}
    	#orders li div.body .txt {
    		height: 70px; color: #666; margin-left: 10px;
    	}
    	#orders li div.body .txt p {
    		color: #000; margin-top: 7px; 
    	}
    	#orders li div.foot {
    		height: 30px; line-height: 30px; width: 100%; font-size: 12px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
    	}
    	#orders li div.oprs {
    		height: 30px; line-height: 30px; width: 100%; border-top: 1px solid #f5f5f5; margin-top: 1px;
    	}
    	#orders li div.oprs div.okey {
    		width: 70px; text-indent: 0px; margin-top: 3px; height: 22px; line-height: 22px; text-align: center; border: 1px solid #f22; color:#f22; border-radius: 3px; float: right; margin-right: 9px; cursor: pointer;
    	}
    	#orders li div.oprs div.lose {
    		width: 70px; text-indent: 0px; margin-top: 3px; height: 22px; line-height: 22px; text-align: center; border: 1px solid #444; color:#444; border-radius: 3px; float: right; margin-right: 9px; cursor: pointer;
    	}
    	.giftNull{position:relative;margin-top:100px;width:100%;min-height:150px;background:url(${img}/gift-null.png) top center no-repeat;background-size:100px;text-align:center;}
    	.giftNull p{position:absolute;top:120px;left:0;width:100%;text-align:center;color:#828282}
    	.changBtn{display:block;overflow:hidden;zoom:1;}
    	.changBtn a{float:left;width:45%;margin:4px 2.5%;}
    </style>
    <script type="text/javascript">
    	function idel(id) {
    		$.pop.chio({
				text : '提示',
				note : '是否确认删除订单?',
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
							url : '${ctx}/wap/user/delete?openid=${openid}&orderId=' + id,
							msg : {
								text : '正在删除订单', succ : '删除订单成功',
								fail : '删除订单失败', warn : '系统繁忙'
							},
							success : function(response) {
								return {
									flag : response.result == 1,
									call : function(flag) {
										location.reload(true);
									}
								};
							}
						});
					}
				}
			});
    	}
    	function iget(id) {
    		$.pop.chio({
				text : '提示',
				note : '是否确认收货?',
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
							url : '${ctx}/wap/user/delive?openid=${openid}&orderId=' + id,
							msg : {
								text : '正在收货', succ : '收货成功',
								fail : '收货失败', warn : '系统繁忙'
							},
							success : function(response) {
								return {
									flag : response.result == 1,
									call : function(flag) {
										location.reload(true);
									}
								};
							}
						});
					}
				}
			});
    	}
    	function icls(id) {
    		$.pop.chio({
				text : '提示',
				note : '是否确认关闭订单?',
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
							url : '${ctx}/wap/user/iclose?openid=${openid}&orderId=' + id,
							msg : {
								text : '正在关闭订单', succ : '关闭订单成功',
								fail : '关闭订单失败', warn : '系统繁忙'
							},
							success : function(response) {
								return {
									flag : response.result == 1,
									call : function(flag) {
										location.reload(true);
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
	       	礼品订单
	        <a href="javascript:history.go(-1);" class="back"></a>
	    </header>
    </c:if>
    <c:if test="${!empty(list)}">
    	<section>
	        <ul id="orders">
	        	<c:forEach var="cell" items="${list}">
	        		<li id="item_${cell.id}" class="${cell.gifttype == 1 ? 'material' : ''}">
	        			<div class="head">
	        				<span>订单编号：${cell.orderNo}</span>
	       					<c:if test="${cell.gifttype == 1}">
	       						<c:if test="${cell.status == 0}">
		                        	<span class="stat" style="color: #999;">已关闭</span>
	                       		</c:if>
	                       		<c:if test="${cell.status == 1}">
		                        	<span class="stat" style="color: #999;">未发货</span>
	                       		</c:if>
	                       		<c:if test="${cell.status == 2}">
		                        	<span class="stat" style="color: #f22;">已发货</span>
	                       		</c:if>
	                       		<c:if test="${cell.status == 3}">
		                        	<span class="stat" style="color: #2f2;">已收货</span>
	                       		</c:if>
	                       	</c:if>
	                       	<c:if test="${cell.gifttype == 2}">
	                       		<c:if test="${cell.status == 0}">
		                        	<span class="stat" style="color: #999;">已关闭</span>
	                       		</c:if>
	                       		<c:if test="${cell.status == 1}">
		                        	<span class="stat" style="color: #f22;">未使用</span>
	                       		</c:if>
	                       		<c:if test="${cell.status == 2}">
		                        	<span class="stat" style="color: #2f2;">已使用</span>
	                       		</c:if>
	                       	</c:if>
	        			</div>
		            	<div class="body" onclick="location.href='${ctx}/wap/igift/cell?id=${cell.giftId}'">
		            		<div class="img"><img src="${cell.images}" /></div>
			            	<div class="txt">
			            		<div style="width:100%; text-indent: 20px">
				            		<p style="max-height: 20px; font-weight: bold; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${cell.giftname} * ${cell.nums}</p>
				            		<p>${cell.integral}金币</p>
				            		<p><fmt:formatDate value="${cell.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
			            		</div>
			            	</div>
		            	</div>
		            	<div class="foot">收货地址：${cell.address}</div>
		            	<c:if test="${cell.gifttype == 1}">
	                  		<div class="oprs">
	                  			<c:if test="${cell.status == 0}">
	                  				<div class="lose" onclick="idel(${cell.id});">删除订单</div>
		                  		</c:if>
	                  			<c:if test="${cell.status == 1}">
	                  				<div class="lose" onclick="icls(${cell.id});">关闭订单</div>
		                  		</c:if>
		                  		<c:if test="${cell.status == 2}">
		                  			<div class="okey" onclick="iget(${cell.id});">确认收货</div>
		                  		</c:if>
		                  		<c:if test="${cell.status == 3}">
		                  			<div class="lose" onclick="idel(${cell.id});">删除订单</div>
		                  		</c:if>
		            		</div>
	                  	</c:if>
		            </li>
	        	</c:forEach>
	        </ul>
	    </section> 
    </c:if>
    <c:if test="${empty(list)}">
    	<!-- 没有礼品 -->
	    <section class="giftNull">
	    	<p>你还没有礼品哦！</p>
	    </section>
	    <!-- 没有礼品 -->
	</c:if>
    <footer class="changBtn">
	    <a href="${ctx}/wap/igift/list?openid=${openid}" class="redBg">前往换购</a>
	    <a href="${ctx}/wap/user/center?openid=${openid}" class="orangeBg">我的帐户</a>
	</footer>
</body>
<%@ include file="/jsp/shield.jsp"%>
</html>
