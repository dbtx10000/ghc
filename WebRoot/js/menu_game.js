var areaArr=[];
//menu界面
var menuLayer=function(){
	//ruleLayer();
	var menuHtml='<canvas id="menu"></canvas>'
	$("body").append(menuHtml);
	$("#load").remove();
	var menu=document.getElementById("menu");
	var ctx=menu.getContext("2d");
	menu.width=w_width;
	menu.height=w_height;
	var menuBg=new Image();
	menuBg.src=res.menu_bg;
	menuBg.onload=function(){
		ctx.drawImage(menuBg,0,0,w_width,w_height);
	};

	var playBtn=new Image();
	playBtn.src=res.start_btn;
	var p_height;
	playBtn.onload=function(){
		var percent=playBtn.width/playBtn.height;
		var p_width=w_width/2.2;
		p_height=p_width/percent;
		var pos_height=(w_height-p_height)/6;
		var pos_width=(w_width-p_width)/2;
		ctx.drawImage(playBtn,pos_width,pos_height,p_width,p_height);
		var play_pos={x:pos_width,y:pos_height,width:p_width,height:p_height};
		areaArr.push(play_pos);
		return areaArr;
	};
	menu.addEventListener('click', function(e){
			var p = getEventPosition(e);
			ctx.beginPath();
		ctx.rect(areaArr[0].x,areaArr[0].y,areaArr[0].width,areaArr[0].height);
		if(p&&ctx.isPointInPath(p.x, p.y)){
			//点击了矩形
			console.log("play");
			playLayer();
		}
	}, false);

	var scoreBtn=new Image();
	scoreBtn.src=res.score_btn;
	scoreBtn.onload=function(){
		var percent=scoreBtn.width/scoreBtn.height;
		var width=w_width/2.2;
		var height=width/percent;
		var t_height=p_height+w_height*0.18;
		var t_width=(w_width-width)/2;
		ctx.drawImage(scoreBtn,t_width,t_height,width,height);
		var tryBtn_pos={x:t_width,y:t_height,width:width,height:height};
		areaArr.push(tryBtn_pos);
		return areaArr;
	};
	menu.addEventListener('click', function(e){
			var p = getEventPosition(e);
			ctx.beginPath();
		ctx.rect(areaArr[1].x,areaArr[1].y,areaArr[1].width,areaArr[1].height);
		if(p&&ctx.isPointInPath(p.x, p.y)){
			//alert("很抱歉，开发中！")
			//document.getElementById("charts").style.display="block";//排行榜
			charts();
		}
	}, false);

	var friend,rule;
	setTimeout(function(){
		ctx.font= "italic bolder 16px serif";
		ctx.fillStyle="#7f5130";
		friend=ctx.fillText("亲友团",(w_width/2)-120,p_height+w_height*0.32);
		ctx.fillStyle="#7f5130";
		rule=ctx.fillText("游戏规则",(w_width/2)+36,p_height+w_height*0.32);
		ctx.strokeStyle = "#7f5130";  
		ctx.lineWidth=1;
        ctx.moveTo(w_width/2,p_height+w_height*0.32-12);  
        ctx.lineTo(w_width/2,p_height+w_height*0.32+3);  
        ctx.stroke();

		menu.addEventListener('click', function(e){
				var p = getEventPosition(e);
				ctx.beginPath();
			ctx.rect(50,p_height+w_height*0.32-18,80,18);
			if(p&&ctx.isPointInPath(p.x, p.y)){
				//alert("很抱歉，我的亲友团开发中！")
				//document.getElementById("friend").style.display="block";//亲友团
				friends();
			}
		}, false);

		menu.addEventListener('click', function(e){
				var p = getEventPosition(e);
				ctx.beginPath();
			ctx.rect(40+w_width*0.46,p_height+w_height*0.32-18,80,18);
			if(p&&ctx.isPointInPath(p.x, p.y)){
				//点击了矩形
				document.getElementById("rule").style.display="block";//规则
			}
		}, false);
	},100);
};

//获取点击范围
function getEventPosition(ev){
	var x, y;
	if (ev.layerX || ev.layerX == 0) {
		x = ev.layerX;
		y = ev.layerY;
	} else if (ev.offsetX || ev.offsetX == 0) { // Opera
		x = ev.offsetX;
		y = ev.offsetY;
	}
 	return {x: x, y: y};
}