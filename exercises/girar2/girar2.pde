float rot = 0.0;

void setup(){
  size(400, 400);
  smooth();
  noStroke();
  frameRate(4);
}

void draw(){

  background(0);

  //push matrix helps you to manipulate such things like rotation and translation
  //ACCORDING to the shape, and not the whole sketch
  pushMatrix();

  //position of your thing
  translate(width/2, height/2);

  //in a cercle, you have TWO_PI
  //to rotate in 4 steps, you need to get TWO_PI/4 (HALF_PI)
  rot += HALF_PI;
  rotate(rot);

  //the center of your shape needs to be at the coordinate (0,0)
  //so like you see below, there is actually negative numbers
  beginShape();
  vertex(0,-10);
  vertex(8,10);
  //vertex(2,10);
  //vertex(0,5);
  vertex(-2,10);
  vertex(-8,10);
  vertex(0,-10);
  endShape();

  popMatrix();
  println(rot);
}
