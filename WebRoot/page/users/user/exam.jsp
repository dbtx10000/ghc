<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<style>
	body { background: #fff;}
</style>
<script type="text/javascript">
   	function formValid() {
   		return true;
   	}
</script>
</head>
<body>
	<form id="save_form" action="${ctx}/users/user/save" method="post">
		<input type="hidden" name="id" value="${id}" />
		<input type="hidden" name="status" value="2" />
		<div id="content-lhg">
			<div class="item h30">
   				<div class="fir">用户类型：</div>
   				<div class="ipt">
	   				<span class="sel" class="w140">
	   					<select id="type" name="type" class="w140">
							<option value="1" >VIP用户</option>
							<option value="2" >普通用户</option>
							<option value="3" >销售人员</option>
	   					</select>
	   				</span>
   				</div>
   			</div>
			<div class="popBtn">
				<a class="save greenBg" href="javascript:lhgSave()">保 存</a> 
				<a class="back grayBg" href="javascript:lhgBack()">返 回</a>
			</div>
		</div>
	</form>
</body>
</html>
