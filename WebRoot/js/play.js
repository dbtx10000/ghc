   //图片资源
		var res={
			menu_bg:"../../images/game/startBg.png",
			play_bg:"../../images/game/playBg.png",
			start_btn:"../../images/game/start.png",
			score_btn:"../../images/game/score.png",
			house:"../../images/game/house.png",
			title:"../../images/game/bg_mine.png",
			page1:"../../images/game/page1.png",
			page2:"../../images/game/page2.png",
			page3:"../../images/game/page3.png",
		};		
		//图片加载
		function loadImages(sources,callback){ 
			// alert(2)
			var load=document.getElementById("load");
			load.width=w_width;
			load.height=w_height;
			var images={};
			var ctx=load.getContext("2d"); 
		    var loadedImages = 0;    
		    var numImages = 0;  
		    ctx.font='14px bold';
		    ctx.lineWidth=5;
		    var clearWidth=load.width;
		    var clearHeight=load.height;
		    var bg=new Image();
		    bg.src=res.menu_bg;
		    bg.onload=function(){
		    	ctx.drawImage(bg,0,0,w_width,w_height);
		    }
		    // get num of sources    
		    for (var src in sources) {    
		        numImages++;    
		    }    
		    for (var src in sources) {    
		        images[src] = new Image();
		        //当一张图片加载完成时执行    
		        images[src].onload = function(){ 
		            //重绘一个进度条
		            ctx.clearRect(0,0,clearWidth,clearHeight);
		            ctx.font="40px Arial";
		            ctx.fillText('Loading:'+parseInt(loadedImages/numImages*100)+'%',50,280);
		            ctx.save();
		            ctx.lineWidth=10;
		            ctx.strokeStyle='#555';
		            ctx.beginPath();
		            ctx.moveTo(10,300);
		            ctx.lineTo(10,300);
		            ctx.stroke();
		            ctx.beginPath();
		            ctx.restore();
		            ctx.moveTo(10,300);
		            ctx.lineTo(loadedImages/numImages*w_width+100,300);  
		            ctx.stroke();
		            //当所有图片加载完成时，执行回调函数callback
		            if (++loadedImages >= numImages) {    
		                callback();    
		            }    
		        };  
		        //把sources中的图片信息导入images数组  
		        images[src].src = sources[src];    
		    }    
		} 








//requestAnimFrame浏览器兼容
		window.requestAnimFrame = (function(callback) {
			return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame ||
			function(callback) {
			  window.setTimeout(callback, 1000 / 60);
			};
		})();

		var w_width=$(window).width();
		var w_height=$(window).height();
		var movehouse;
		var houseHeight,houseWidth;//房子宽高
		var move_x;//水平移动的房子的x轴坐标
		var timer;
		var click;
		var speed;
		var playCtx;
		var houseY;
		var clickTimes;
		var rightEnd=false;
		var unclick=false;
		var scroll=false;
		var move=0;
		var stop=null;
		var oldBg_y=0;
		var playBg;
		var retry=false;
		var touch=false;
		var touchCtx;
		var oTime=0;

		var init=function(){
			speed=3;
			move_x=0;
			click=0;
			clickTimes=0;
			houseY=[];
			houseX=[];
			lastX="";
			rightEnd=false;
			unclick=false;
			stop=null;
			oldBg_y=0;
			unclick=false;
		}

		
		
		//画背景
		var drawPlayBg=function(x,y){
			//console.log("bgbgbgbgbbgbg")
			
			play.width=w_width;
			play.height=w_height;
			
			playBg=new Image();
			playBg.src=res.play_bg;
			playBg.onload=function(){
				playCtx.drawImage(playBg,x,y,w_width,w_height);
				$("#menu").hide();
			};
		}
		//移动房子
		var drawMoveHouse=function(){
			var movehouse=document.getElementById("movehouse");
			var ctx=movehouse.getContext("2d");
			touchCtx=ctx;
			movehouse.width=w_width;
			movehouse.height=w_height;
			var house=new Image();
			house.src=res.house;
			house.onload=function(){
				$("#menu").hide();
				var percent=house.width/house.height;
				var width=w_width*0.23;
				var height=width/percent;
				houseHeight=height;
				houseWidth=width;
				ctx.drawImage(house,0,60,width,height);
				// 画线
				ctx.strokeStyle = "#000";  
		        ctx.moveTo(w_width*0.23/2,0);  
		        ctx.lineTo(w_width*0.23/2,60);  
		        ctx.stroke();
		        moveX(ctx,house);
		        coorY();
			};
		}
		//x轴移动
		var  moveX=function(ctx,house){
			if(move_x>parseInt(w_width-w_width*0.3)){
	        	rightEnd=true;
	        }else if(move_x<w_width*0.1){
	        	rightEnd=false;
	        }
	        if(!rightEnd){
	        	move_x+=speed;
	        }else{
	        	move_x-=speed;
	        }
			ctx.clearRect(0,0,w_width,w_height);
	        ctx.drawImage(house,move_x,60,houseWidth,houseHeight);
        	ctx.beginPath();
        	ctx.moveTo(w_width*0.23/2+move_x,0);  
        	ctx.lineTo(w_width*0.23/2+move_x,60);  
        	ctx.stroke();
        	ctx.fillStyle="#7deef2";
        	
        	if(retry||touch){
        		console.log(touch)
        		window.cancelAnimationFrame(timer);
        		touch=false;
        		timer=window.requestAnimationFrame(function(){
	        		moveX(ctx,house);
	        	});
        	}else if(unclick){
        		window.cancelAnimationFrame(timer);
        	}else{
        		timer=window.requestAnimationFrame(function(){
	        		moveX(ctx,house);
	        	});
        	}
        	
		}
		//搭房子界面
		var houseLayer=function(){
			var house=document.getElementById("house");
			var ctx=house.getContext("2d");
			var houseShow=document.getElementById("houseShow");
			var context=houseShow.getContext("2d");
			house.height=houseShow.height=w_height;
			house.width=houseShow.width=w_width;
			house.addEventListener('touchstart', function(e){
				e.preventDefault();
				var nDate=new Date();
				var nTime=nDate.getTime();
				if (e.targetTouches.length == 1) {
					//console.log("new"+parseInt(nTime))
					//console.log('old'+parseInt(oTime))
					if(nTime-oTime<300){
						//alert("doubleTap")
						oTime=nTime;
						return false;
					}else{
						console.log("sigle")
						touch=true;
						console.log(move_x);
						if(unclick){
							return false;
						}else{
							clickTimes++;//点击次数
							if(click>=4){
							var lastX=houseX[3];
								click=1;
							}else if(clickTimes>3){
								scroll=true;
								click++;
							}else{
								scroll=false;
								click++;
							}
							if(houseX.length>3){
								houseX.splice($.inArray(houseX[0],houseX),1);//数组内删除
							}
							houseX.push(move_x);
							DropHouse(ctx,context);
							animateGame(move_x);
							if(clickTimes%4==0){
								speed+=1;
							}
							//console.log(houseX)
							oTime=nTime;
						}
					}
				}
			},false);
		};

		// Y轴移动坐标
		var coorY=function(){
			houseY=[];
			for(var j=0;j<4;j++){
				var HY=w_height-(j+1)*parseInt(houseHeight)-parseInt(w_height*0.07);
				houseY.push(HY);//获取每一个Y轴值
			};
		}
		//Y轴移动动画
		var y=60;
		var DropHouse=function(ctx,context){
			var house=new Image();
			house.src=res.house;
			house.onload=function(){
				if(y<houseY[houseY.length-1]){
					y+=13;
					ctx.clearRect(0,0,w_width,w_height);
					ctx.drawImage(house,houseX[houseX.length-1],y,houseWidth,houseHeight);
					window.requestAnimationFrame(function(){
						DropHouse(ctx,context);
					})
				}else{//到达位置；
					y=60;
					ctx.clearRect(0,0,w_width,w_height);
					var last=houseX.length-1;
					context.drawImage(house,houseX[last],houseY[last],houseWidth,houseHeight);
					gameover(ctx,context);
				}
			}
		}

		var houseX=[];//x轴数组
		
		//游戏结束
		var gameover=function(ctx,context){
			var house=new Image();
			house.src=res.house;
			var length=houseX.length;
			if(clickTimes<=1){
				if(houseX[0]<w_width/4||houseX[0]>w_width*0.56){//判断第一个是否在区域内
					result();
					return false;
				}else{
					$("#score").html(clickTimes);
					for(var i=0;i<houseY.length;i++){
						context.drawImage(house,houseX[i],houseY[i],houseWidth,houseHeight);
					}
				}
			}else if(houseX.length>0&&Math.abs(houseX[length-1]-houseX[length-2])>2*houseWidth/3){//判断连续两个的位置
				if(houseX[0]<w_width/4||houseX[0]>w_width*0.56){//判断第一个是否在区域内
					result();
					return false;
				}else{
					result();
				}
			}else if(scroll){
				canCroll(context);
				scrollBg();
				console.log("scroll");
				$("#score").html(clickTimes);
				for(var i=0;i<houseY.length;i++){
					context.drawImage(house,houseX[i],houseY[i],houseWidth,houseHeight);
				}
			}else{
				console.log("unscroll");
				$("#score").html(clickTimes);
				for(var i=0;i<houseY.length;i++){
					context.drawImage(house,houseX[i],houseY[i],houseWidth,houseHeight);
				}
			}
		};


		//scroll
		var scrollArr=[];
		var canCroll=function(context){
			// console.log("canscroll");
			var house=new Image();
			house.src=res.house;
			house.onload=function(){
				if(move<houseHeight){
					move+=10;
					context.clearRect(0,0,w_width,w_height)
					for(var i=0;i<houseY.length;i++){
						context.drawImage(house,houseX[i],houseY[i]+move,houseWidth,houseHeight);
					}
					window.requestAnimationFrame(function(){
						canCroll(context);
					})
				}else{
					var last=houseY.length-1;
					var lastY=houseY[last];
					var scrollArr=[];
					if(houseY.length>5){
						houseY.splice($.inArray(houseY[0],houseY),1);//数组内删除
						for(var i=0;i<houseY.length;i++){
							houseY[i]+=houseHeight;
						}
						houseY.push(lastY);
					}
					move=0;
					// console.log(houseX)
				}
				
			}
		}
		var bgY=0;
		var scrollBg=function(){
			if(bgY<houseHeight){
				bgY+=10;
				// console.log(bgY);
				// console.log(oldBg_y)
				playCtx.drawImage(playBg,0,oldBg_y+bgY,w_width,w_height);
				window.requestAnimationFrame(function(){
					scrollBg();
				})
			}else{
				oldBg_y+=bgY;
				bgY=0;
			}	
		}

		var again=function(){
			retry=true;
			$("#play,#house,#movehouse,#houseShow,#header").remove();
			window.cancelAnimationFrame(stop);
			playLayer();
			$("#gameoverResult").hide();
		}

		
		//规则隐藏
		function ruleHide(){
			document.getElementById("rule").style.display="none";
		}
		var animateGame=function(x){
			console.log("animate");
			$("#yun").show();
			if(x<w_width/2-houseWidth/2){
				console.log("right")
				$("#elephant_left img").removeClass('slideInLeft').addClass('slideOutUp');
				$("#elephant img").removeClass("slideOutUp").addClass('slideInRight');
				$("#elephant").show()
			}else{
				console.log("left")
				$("#elephant img").removeClass('slideInRight').addClass('slideOutUp');
				$("#elephant_left img").removeClass('slideOutUp').addClass('slideInLeft');
				$("#elephant_left").show();
			}
		}