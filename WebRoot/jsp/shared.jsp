<%@ include file="/jsp/weixin.jsp" %>
<script type="text/javascript">
wx.ready(function () {
	wx.hideAllNonBaseMenuItem();
	wx.showMenuItems({
	    menuList : [
	    	'menuItem:share:timeline',
	    	'menuItem:share:appMessage', 
	    	'menuItem:favorite'
	    ]
	});
});
</script>