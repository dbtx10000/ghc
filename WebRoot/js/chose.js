//创建问题
function questionHtml(option,title){
	$("#title").html(title);
	for(var k=0;k<option.length;k++){
		var html='<ul id="question'+k+'" class="question borderR5">'+
				'<input type="hidden" value="'+option[k].sort+'" />'+
				'<h4>'+option[k].sort+'、'+option[k].question+'</h4>'+
			'</ul>';
		$("#questList").append(html);
		for(var j=0;j<option[k].answer.length;j++){
			var list='<li><p><span class="icon_unradio"></span>'+option[k].answer[j]+'</p></li>';
			$("#question"+k).append(list);
		}

	}
	chose();
}

//选择
function chose(){
	$("#questList ul").each(function(){
		$(this).find("li").on("click",function(){
			$(this).addClass("active");
			$(this).siblings().removeClass("active");
		})
	});
}

//当前页面得分
function scores(){
	var score=0;//当前页面得分
	var result=true;
	$("#questList ul ").each(function(){
		var oli=$(this).find("li");
		var isHas=oli.hasClass("active")
		if(isHas){//判断题目是否作答；
			oli.each(function(){
				if($(this).hasClass("active")){
					score+=$(this).index()-1;//得分相加；
				};
			})
		}else{//有题目没作答
			var index=$(this).find("input").val();
			//alert("请回答第"+index+"题！");
			$.pop.tips("第"+index+"题还没回答哦!");
			result=false;
			return false;
		}
	});
	if(result){
		return score;
	}else{
		return 0;
	}
	
}
//提交分数
function  submitScore(url,score){
	var scoreCurrent=scores();//当前页面分数
	if(scoreCurrent>0){
		var scoreTotal=scoreCurrent+score;
		location.href=url+'&score='+scoreTotal;
	}
	
}

