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