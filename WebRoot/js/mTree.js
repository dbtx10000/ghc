var startX=0;
var startY=0;
var endX=0;
var endY=0;

document.addEventListener("touchstart",function(event){
	startX=event.touches[0].pageX;
	startY=event.touches[0].pageY;
});

document.addEventListener("touchmove",function(event){
	event.preventDefault();
});

document.addEventListener("touchend",function(event){
	var documentWidth=document.body.offsetWidth;
	endX=event.changedTouches[0].pageX;
	endY=event.changedTouches[0].pageY;
	var deltax=endX-startX;
	var deltay=endY-startY;
	if(Math.abs(deltax)<0.3*documentWidth&&Math.abs(deltay)<0.3*documentWidth){
		return;
	}else{
		if(Math.abs(deltax)>=Math.abs(deltay)){//x
			return;
		}else{//y
			if(deltay>0){
				//down
				$("#rules").removeClass('rulesUp').addClass('rulesDown').find('ol').hide();
				$("#icon").removeClass('active');
			}else{
				//up
				$("#rules").removeClass('rulesDown').addClass('rulesUp').find('ol').show();
				$("#icon").addClass('active');
			}
		}
	}
	
});