<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<%@ include file="/jsp/script.jsp"%>
<style>
	body { background: #fff; }
</style>
<script type="text/javascript">
   	$(document).ready(function() {
   		initData();
   		initValid();
   	});
   	function initValid() {
   		$("#name").focus(function() {
   			$(this).parent().parent().find(".tip").html("*");
   		}).blur(function() {
   			valid($(this));
   		});
   	}
   	function formValid() {
   		return validThese($("#name"));
   	}
   	function initData() {
   		if ('${object.type}' != 'click') {
   			$("#type").val('view');
			$("#left").addClass("selected");
			$("#key").hide();
			$("#url").show();
   		} else {
   			$("#type").val('click');
			$("#right").addClass("selected");
			$("#key").show();
			$("#url").hide();
   		}
   		$("#left").click(function() {
			$("#type").val('view');
			$("#right").removeClass("selected");
			$(this).addClass("selected");
			$("#key").hide();
			$("#url").show();
		});
		$("#right").click(function() {
			$("#type").val('click');
			$("#left").removeClass("selected");
			$(this).addClass("selected");
			$("#key").show();
			$("#url").hide();
		});
   	}
</script>
</head>
<body>
	<form id="save_form" action="${ctx}/wxapi/menus/save" method="post">
		<input type="hidden" id="id" name="id" value="${object.id}" />
		<input type="hidden" id="type" name="type" value="${object.type}" />
		<input type="hidden" id="level" name="level" value="${level}" />
		<input type="hidden" id="pid" name="pid" value="${pid}" />
		<div id="content-lhg">
			<div class="item h30">
				<div class="fir">菜单名：</div>
				<div class="ipt">
					<input type="text" class="w230" id="name" name="name"
						placeholder="请输入菜单名" value="${object.name}" />
				</div>
				<div class="tip">*</div>
			</div>
			<div class="item h30">
   				<div class="fir">类　型：</div>
   				<div class="ipt">
	   				<div class="radio">
						<a id="left" class="left">链　接</a> 
						<a id="right" class="right">关键字</a>
					</div>
   				</div>
   			</div>
   			<div id="url" class="item h30">
				<div class="fir">链　接：</div>
				<div class="ipt">
					<input type="text" class="w360" id="url" name="url"
						value="${object.url}" placeholder="请输入链接" />
				</div>
			</div>
   			<div id="key" class="item h30">
   				<div class="fir">关键字：</div>
   				<div class="ipt">
	   				<span class="sel" style="width: 120px;"> 
						<select name="key" class="w120">
							<c:forEach var="reply" items="${replies}">
								<option ${reply.tags == object.key ? 'selected' 
									: ''} value="${reply.tags}">${reply.tags}</option>
							</c:forEach>
						</select>
					</span>
   				</div>
   			</div>
   			<div class="item h30">
				<div class="fir">排序：</div>
				<div class="ipt">
					<span class="sel" style="width: 120px;"> 
						<select id="weight" name="weight" class="w120">
			  				<option value="0" <c:if test="${object.weight == 0}">selected="selected"</c:if>>0</option>
			  				<option value="1" <c:if test="${object.weight == 1}">selected="selected"</c:if>>1</option>
			  				<option value="2" <c:if test="${object.weight == 2}">selected="selected"</c:if>>2</option>
			  				<option value="3" <c:if test="${object.weight == 3}">selected="selected"</c:if>>3</option>
			  				<option value="4" <c:if test="${object.weight == 4}">selected="selected"</c:if>>4</option>
			  				<option value="5" <c:if test="${object.weight == 5}">selected="selected"</c:if>>5</option>
			  				<option value="6" <c:if test="${object.weight == 6}">selected="selected"</c:if>>6</option>
			  				<option value="7" <c:if test="${object.weight == 7}">selected="selected"</c:if>>7</option>
			  				<option value="8" <c:if test="${object.weight == 8}">selected="selected"</c:if>>8</option>
			  				<option value="9" <c:if test="${object.weight == 9}">selected="selected"</c:if>>9</option>
						</select>
					</span>
				</div>
			</div>
			<div class="popBtn">
				<a class="save orangeBg" href="javascript:lhgSave()">保 存</a> 
				<a class="back grayBg" href="javascript:lhgBack()">返 回</a>
			</div>
		</div>
	</form>
</body>
</html>
