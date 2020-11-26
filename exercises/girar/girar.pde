float angle;
 
void setup () { 
  size (600, 600);
  noCursor();
}
 
void draw () { 
  background (0); 
  smooth(); 
  fill(255);
  translate(width/2, height/2); 
  rotate(radians(angle)); 
  triangle ( - 10, + 26, 
  0, -25, 
  + 10, + 26);
}
 
void keyPressed() { 
  if (key == CODED) { 
    if (keyCode == RIGHT) { 
      angle++;
    }
  }
}
