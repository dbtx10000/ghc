$(document).ready(function() {
	$("a").live('click', function() {
		var powerUrl = request.getWebAppPath() + '/power';
		var loginUrl = request.getWebAppPath() + '/login';
		$.ajax({
			url : powerUrl, async : false, dataType : 'json',
			error : function() { window.top.location.href = loginUrl; },
			success : function(response) {
				if (response.result != 1) {
					window.top.location.href = loginUrl;
					return false;
				} else {
					return true;
				}
			}
		});
	});
});

/*********************全局变量*********************/
var lhg = {
	min : false,
	max : false,
	rang : true, 
	lock : true,
	resize : false
};

var ke_simple_items = [
    'source', '|', 'undo', 'redo', '|', 'preview', 'template', 'cut', 'copy', 'paste',
    'plainpaste', 'wordpaste', '|', 'clearhtml', 'quickformat', 'selectall', 'fullscreen', 
    '/', 'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
    'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 'hr'
];
/*********************全局变量*********************/

/*********************全局函数*********************/
$.lhg = {
	alert : function(msg, sec) {
		var lhg_alert = $.dialog({
			width : 300,
			height : 65,
			lock : true,
			resize : false,
			min : false,
			max : false,
			title : '提示',
			content : msg,
			id : 'lhg_extend_for_alert',
			ok : true
		});
		if (sec == parseFloat(sec)) {
			lhg_alert.get('lhg_extend_for_alert', 1).time(sec);
		}
	},
	confirm : function(msg, ok, cancel) {
		$.dialog({
			width : 300,
			height : 65,
			lock : true,
			resize : false,
			min : false,
			max : false,
			title : '确认',
			parent : this,
			content : msg,
			ok : function() {
				if ($.isFunction(ok)) {
					ok();
				}
				return true;
			},
			cancel : function() {
				if ($.isFunction(cancel)) {
					cancel();
				}
				return true;
			}
		});
	}
};

function valid($input, callback) {
	var $tip, $fir, $par = $input.parent().parent();
	if ($input.is('select')) {
		$par = $par.parent();
	} 
	$tip = $par.find(".tip");
	$fir = $par.find(".fir");
	var fir = $fir.html().substring(0, $fir.html().length - 1);
	if ($input.val().isEmpty()) {
		if ($input.is('select')) {
			$tip.html("<font color='red'>请选择" + fir + "</font>");
		} else {
			$tip.html("<font color='red'>" + fir + "不能为空</font>");
		}
		return false;
	} else {
		var id = $input.attr('id'), value = $input.val();
		if (id == 'mobile' && !value.isMobile()) {
			$tip.html("<font color='red'>" + fir + "格式错误</font>");
			return false;
		}
		if (id == 'telephone' && !value.isMobile() && !value.isTelephone()) {
			$tip.html("<font color='red'>" + fir + "格式错误</font>");
			return false;
		}
		if (id == 'linkman' && !value.isName()) {
			$tip.html("<font color='red'>" + fir + "格式错误</font>");
			return false;
		}
		if (id == 'username' && !value.isUsername()) {
			$tip.html("<font color='red'>4-16位:英文|数字|下划线</font>");
			return false;
		}
		if ($.isFunction(callback)) {
			return callback($input, $tip);
		} else {
			return true;
		}
	}
}

function validThese($inputs, callback) {
	for (var i = 0; i < $inputs.length; i++) {
		if (!valid($($inputs[i]), callback)) {
			return false;
		}
	}
	return true;
}

function lhgSave() {
	if (formValid()) {
		$.pop.lock(true);
		$("#save_form").ajaxSubmit({
			dataType: 'json',
			error : function() { 
				$.lhg.confirm("系统繁忙，请稍后..."); 
				$.pop.lock(false);
			},
			success: function(response) {
				$.pop.lock(false);
				if (response.result != 1) {
					$.lhg.confirm(response.message);
				} else {
					getLhgParent().dptl.list(true);
					lhgBack();
				}
			}
		});
	}
}

function htmSave(url) {
	if (formValid()) {
		$.pop.lock(true);
		$("#save_form").ajaxSubmit({
			dataType: 'json',
			error : function() { 
				$.lhg.confirm("系统繁忙，请稍后..."); 
				$.pop.lock(false);
			},
			success: function(response) {
				$.pop.lock(false);
				if (response.result == 1) {
					$.lhg.confirm("数据已保存", function() {
						if (url == null) {
							location.reload(true);
						} else {
							location.href = url;
						}
					}, function() {
						if (url != null) {
							location.href = url;
						}
					});
				} else {
					$.lhg.confirm(response.message);
				}
			}
		});
	}
}

function formValid() {
	return true;
}

function lhgBack() {
	frameElement.api.close();
}

function getLhgParent() {
	return frameElement.api.opener;
}
/*********************全局函数*********************/