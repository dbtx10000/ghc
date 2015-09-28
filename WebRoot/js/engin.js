window.requestAnimFrame = (function(callback) {
    return window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame ||
    function(callback) {
      window.setTimeout(callback, 1000 / 60);
    };
})();


function animate(myRectangle, canvas, context, startTime) {
    // update
    var time = (new Date()).getTime() - startTime;

    // pixels / second^2
    var gravity = 5000;

    myRectangle.y = 0.5 * gravity * Math.pow(time / 1000, 2);

    if(myRectangle.y > canvas.height - myRectangle.height - myRectangle.borderWidth / 2) {
      myRectangle.y = canvas.height - myRectangle.height - myRectangle.borderWidth / 2;
    }
    lastTime = time;

    // clear
    context.clearRect(0, 0, canvas.width, canvas.height);

    // draw
    drawRectangle(myRectangle, context);

    // request new frame
    requestAnimFrame(function() {
      animate(myRectangle, canvas, context, startTime);
    });
}
  var canvas = document.getElementById('myCanvas');
  var context = canvas.getContext('2d');

var house=new Image();
house.src=res.house;
var houseDraw={
    x:0,
    y:15,
}
house.onload=function(){
    $("#menu").hide();
    
    
    var rightEnd=false;
    var timer=setInterval(function(){
        if(move_x>parseInt(w_width-w_width*0.23)){
            rightEnd=true;
        }else if(move_x==0){
            rightEnd=false;
        }
        if(!rightEnd){
            move_x+=speed;
        }else{
            move_x-=speed;
        }

        ctx.drawImage(playBg,0,changes*houseHeight*4,w_width,w_height);
        ctx.fillRect(0, 0, w_width,changes*houseHeight*4);
        ctx.drawImage(house,move_x,50+10,width,height);
        ctx.beginPath();
        ctx.moveTo(w_width*0.23/2+move_x,0);  
        ctx.lineTo(w_width*0.23/2+move_x,50+10);  
        ctx.stroke();
        ctx.fillStyle="#7aedf1";
        
    },1000/30);

  function drawRectangle(houseDraw, context) {
    var percent=house.width/house.height;
    var width=w_width*0.23;
    var height=width/percent;
    houseHeight=height;
    houseWidth=width;
    ctx.drawImage(house,0,15,width,height);

    ctx.strokeStyle = "#000";  
    ctx.moveTo(w_width*0.23/2,0);  
    ctx.lineTo(w_width*0.23/2,15);  
    ctx.stroke();
  }

  drawRectangle(myRectangle, context);

  // wait one second before dropping rectangle
  setTimeout(function() {
    var startTime = (new Date()).getTime();
    animate(myRectangle, canvas, context, startTime);
  }, 2000);




