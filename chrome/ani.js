var diameter; 
var angle = 0;

function setup() {
  createCanvas(250, 150);
  diameter = height - 10;
  noStroke();
  fill(255, 204, 0);
}

function draw() {
  background(1000);

  var d2 = 10 + (sin(angle + PI/2) * diameter/2) + diameter/2;

  
  ellipse(width/2, (height/2)+20, d2, d2);
  
  angle += 0.01;
}