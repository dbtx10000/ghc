
var monthAmount; //选择显示的月份个数


function dateSelect_init(monthCount,element){
	monthAmount=monthCount;
	rili(element);
}

function rili(element) {
	monthShow();
	dayShow();
	//del();
	//dayNull();
	//dataTime(element);
}

//日历显示
function dataTime(element){
	$(element).click(function(){
		$("#calContainer").show();
		$("#indexHtml").hide();
		dateDay();
	})
}

//月份Show
function monthShow() {
	var bodyHtml=$("body").html();
	$("body").html("<div id='indexHtml'>"+bodyHtml+"</div>");
	$("body").append("<div id='calContainer' style='display:block;'></div>");

	//获取系统时间
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth();

	var index = 0;
	var monthDays = 0;

	for (var i = 0; i < monthAmount; i++) {
		if (month > 11) {
			month = 0;
			year++;
		}
		$("#calContainer").append("<div class='low_calendar' id='"+(month + 1)+"'></div>");
		var tag = "<div class='calGrid'><table><tbody><tr></tr></tbody></table></div>";
		$(".low_calendar:last").html(tag);
		$(".calGrid:last").before("<h1>" + year + "年" + (month + 1) + "月</h1>")
		weekName();
		month++;
	}

	for (var i = 0; i < 6; i++) {
		$(".low_calendar tbody").append("<tr></tr>");
	};
	for (var j = 0; j < 7; j++) {
		$(".low_calendar tbody tr").nextAll().append("<td></td>");
	}
	month++;
}

//周几show
function weekName() {
	var week_day = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"];
	for (var i = 0; i < 7; i++) {
		if (i == 0 || i == 6) {
			$(".low_calendar:last tr:first").append("<th class='week_day'>" + week_day[i] + "</th>");
		} else {
			$(".low_calendar:last tr:first").append("<th>" + week_day[i] + "</th>");
		}
	};
}

//日期show
function dayShow() {
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth();
	var daysInMonth = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31); //每月天数；
	var day = date.getDate();
	//日期show

	for (var j = 0; j < monthAmount; j++) {

		//判断一年12个月
		if (month > 11) {
			month = 0;
			year++;
		}
		var firstDay = set(year, month);
		//每个月的日期做出数组
		var day_tds = $($(".low_calendar")[j]).find("tbody tr td").toArray();

		for (var i = 1; i < daysInMonth[month] + 1; i++) {
			var date_td = $(day_tds[firstDay + i - 1]); //当月1号位置
			var month_this=month+1;//月
			date_td.html(i);//日

			//月份，少于10时，前面补充0
			if(month_this<10){
				month_this="0"+month_this;
			}
			//日，少于10时，前面补充0
			if(i<10){
				i="0"+i;
			}
			//生成日期
			date_td.attr("date",year+"-"+month_this+"-"+i);

			//过期变灰
			if (j == 0) {
				if (i < day) {
					//date_td.addClass("disable");
				}
			}

			

			//日期点击事件，过期不能点击
			date_td.click(function() {
				if ($(this).hasClass("disable")) {
					return false;
				}
			})
			
			//价格日历
			//获取每个月的价格,循环加入span内

			//date_td.append("<span class='sb'>11</span>");

		}
		month++;

		//判断是否为闰年
		if (month == 1) {
			if (((0 == year % 4) && (0 != (year % 100))) || (0 == year % 400)) {
				daysInMonth[1] = 29;
			} else {
				daysInMonth[1] = 28;
			}
		}
	}
}

//获取月第一天
function set(year, month) {
	var d = new Date();
	d.setFullYear(year);
	d.setMonth(month);
	d.setDate(1);
	return d.getDay();
}

//删减多余行
function  del(){
	//多余行删减
	for(var i=0;i<$(".low_calendar").length;i++){
		var monthLast=$($(".low_calendar")[i]).find("tbody tr:last");
		var last=monthLast.find("td:first");
		if(last.html()==""){
			monthLast.remove();
		}
	}
}

//日历中空白格
function  dayNull(){
	$(".low_calendar td").each(function(){
		if($(this).html()==""){
			$(this).addClass("disable");
		}
	})
}

var num;
//选着日期
function dateDay(){
    $("#calContainer .low_calendar tr").each(function(){
      $(this).delegate("td","click",function(){
      	$("#calContainer .low_calendar tr td").removeClass("curr");
        var date=$(this).attr("date");
        if(date==undefined){
        	return false;
        }else{
        	$(this).addClass("curr");
	        $("#select_Date").val(date);
	        //$("#calContainer").hide();
	        //$("#indexHtml").show();
	        var time_num=date.split("-");
	        num=date.split("-")[0]+date.split("-")[1]+date.split("-")[2];
        }
      })
    })
} 
