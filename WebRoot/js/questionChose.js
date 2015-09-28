//选择
function chose(){
	$("#questList ul").each(function(){
		//单选
		if($(this).find("input[class='type']").val()==0){
			$(this).find("li").on("click",function(){
				$(this).addClass("active");
				$(this).siblings().removeClass("active");
			})
		}else{
			//多选
			$(this).find("li").on("click",function(){
				if($(this).hasClass("active")){
					$(this).removeClass("active");
				}else{
					$(this).addClass("active");
				}
			})
		}
		
	});
}

//获取答案
function scores(){
	var result=true;
	var isHas;
	$("#questList ul ").each(function(){
		var oli=$(this).find("li");
		var answer=0;
		oli.each(function(){
			if($(this).hasClass('active')||$(this).parent().find("input[class='choose']").val()==0){
				answer++;
			}
		});
		if(answer>=1){
			isHas=true;
		}else{
			isHas=false;
		}

		if(isHas){//判断题目是否作答；
			var answer='';
			oli.each(function(){
				if($(this).hasClass("active")){//获取选中的答案
					$(this).parent().find("input[id='topicId']").attr("name","topicId");
					answer+=$(this).find("input").val()+',';
					$(this).parent().find("input[name='optionId']").attr("name","optionId").val(answer);
					
				}
			})
		}else{//有题目没作答
			
			var index=$(this).find("input").attr('class');
			result=false;
			$.pop.tips("第"+index+"题还没回答哦!");
			return false;
		}
	});
	if(result){
		return 1;
	}else{
		return 0;
	}
	
};

//提交分数
function  submitScore(){
	var scoreCurrent=scores();//当前页面分数
	if(scoreCurrent>0){
		$("#save_form").attr("action", "save").ajaxSubmit({
			dataType: 'json',
			error : function() { 
				$.lhg.confirm("系统繁忙，请稍后..."); 
				$.pop.lock(false);
			},
			success: function(response) {
				$.pop.lock(false);
				if (response.result == 1) {
					location.href="finish?integral="+$("#integral").val();
				} else {
					$.pop.tips(response.message);
				}
			}
		});
	}
}

