
var feeling;
jQuery(document).ready(function()
{
	jQuery.get('http://emotilizer.club/emoapi/emotilizer/mood/1001', function(data)
	{
		feeling = data.average;
		console.log("Got average: " + data.average);
	});

});

			

var img;
var resultA;
var resultS;
var resultH;
var gif;

feeling = 2;
function preload() { 
	img = loadImage("_GUI.png");
	resultA = loadImage("_Angry.png");
	resultS = loadImage("_Sadness.png");
	resultH = loadImage("_Happy.png");
	gif= loadImage("hex.gif");
}

function setup(){
	createCanvas(200,400);
	background(img); 
		
		setTimeout(function(){
			background(gif)}, 10000);
		
		


	
	
	if (feeling >= 0 && feeling <= 3 ) //HAPPY
	{
		background(resultH); 
	}
	else if (feeling >= 4 && feeling <= 6) // SAD
	{
		image(resultS,0,0,200,400);
	}
	else if (feeling >=7 && feeling <= 9) // ANGRY
	{
		image(resultA,0,0,200,400);
	}
}


	


function calcWave() {
	  // Increment theta (try different values for 
	  // 'angular velocity' here
	  theta += 0.02;

	  // For every x value, calculate a y value with sine function
	  var x = theta;
	  for (var i = 0; i < yvalues.length; i++) {
		yvalues[i] = sin(x)*amplitude;
		x+=dx;
  }
}

function renderWave() {
  noStroke();
  fill(255);
  // A simple way to draw the wave with an ellipse at each location
  for (var x = 0; x < yvalues.length; x++) {
    ellipse(x*xspacing, height/2+yvalues[x], 16, 16);
	
  }
}
	