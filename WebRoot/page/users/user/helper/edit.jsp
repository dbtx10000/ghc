<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<script type="text/javascript" src="${js}/kindeditor/kindeditor.js"></script>
<script type="text/javascript">
	var editors = new Array();
	$(document).ready(function() {
		initEditors();
	});
	function formValid() {
		if (editors.length > 0) {
			for (var i = 0; i < editors.length; i++) {
				$("#detail_" + i).val(editors[i].html());
			}
		}
		return true;
	}
	function initEditors() {
		var $textareas = $("textarea");
		if ($textareas.length > 0) {
			KindEditor.ready(function(K) {
				for (var i = 0; i < $textareas.length; i++) {
					var name = $($textareas[i]).attr('name');
					var editor = K.create(
						'textarea[name=\'' + name + '\']', 
						{
							uploadJson : '${ke_upload}',
							formatUploadUrl : false
						}
					);
					editors.push(editor);
				}
			});
		}
	}
</script>
</head>

<body>
	<form id="save_form" action="${ctx}/users/user/helper/save" method="post">
		<div id="content">
			<div class="flag">
				<div class="location">用户助手</div>
			</div>
			<div class="data">
				<div class="form">
					<c:forEach var="cell" items="${list}" varStatus="p">
						<input type="hidden" name="list[${p.index}].id" value="${cell.id}" />
						<input type="hidden" id="detail_${p.index}" name="list[${p.index}].detail" />
						<div class="item" style="height: 350px;">
							<div class="fir">${cell.typeName}：</div>
							<div class="ipt">
								<textarea style="width: 700px; height: 333px;" 
									name="detail_${cell.id}">${cell.detail}</textarea>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="pBtn">
				<a class="save orangeBg" href="javascript:htmSave();">保&nbsp;&nbsp;存</a>
				<a class="back grayBg" href="javascript:history.go(-1)">返&nbsp;&nbsp;回</a>
			</div>
		</div>
	</form>
</body>
</html>
