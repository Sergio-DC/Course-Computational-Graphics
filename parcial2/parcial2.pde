PVector PLAYER1_POSITION = new PVector();
//PVector PLAYER2_POSITION = new PVector();

void setup(){
  size(600, 600);
}

void draw() {
    drawField();
}

void drawField() {
float padding_x = 75;
float padding_y_top = 20;
float ancho = width - (padding_x * 2);
float largo = height - (padding_y_top * 2);
float origenX = padding_x;
float origenY = padding_y_top;

 
  fill(150);
  rect(origenX, origenY, ancho, largo);
  
  pushMatrix();
  fill(0,255,0);
  translate(15,15);
  scale(0.95);
  //Este va encima de otro rect
  rect(origenX, origenY, ancho, largo);
  
  //Dibujar Lineas Delimitadoras
  float punto_medio_y = ( origenY + (origenY + largo) ) / 2;
  float punto_medio_x = (origenX + (origenX + ancho) ) / 2;
  strokeWeight(10);
  //Linea Horizontal
  PVector v1_horizontal , v2_horizontal;
  v1_horizontal = new PVector(origenX, punto_medio_y);
  v2_horizontal = new PVector(origenX + ancho, punto_medio_y);
  strokeWeight(3);
  stroke(255,0,0);
  line(v1_horizontal.x, v1_horizontal.y, v2_horizontal.x, v2_horizontal.y);
  //Linea Vertical
  PVector v1_vertical , v2_vertical;
  v1_vertical = new PVector(punto_medio_x, punto_medio_y);
  v2_vertical = new PVector(punto_medio_x, punto_medio_y + (largo/2));
  line(v1_vertical.x, v1_vertical.y, v2_vertical.x, v2_vertical.y);
  //Rectangulos pequeños
  stroke(0,0,255);
  beginShape();
    vertex(v1_horizontal.x + 1, v1_horizontal.y);
    vertex(v1_horizontal.x + (ancho/4), v1_horizontal.y);
    vertex(v1_horizontal.x + (ancho/4), v1_horizontal.y + (largo/6));
    vertex(v1_horizontal.x + 1, v1_horizontal.y + (largo/6));
  endShape();
  beginShape();
    vertex(v1_horizontal.x + (ancho) - 1, v1_horizontal.y);
    vertex(v1_horizontal.x + (ancho * 3/4) - 1, v1_horizontal.y);
    vertex(v1_horizontal.x + (ancho * 3/4) - 1, v1_horizontal.y + (largo/6));
    vertex(v1_horizontal.x + (ancho) - 1, v1_horizontal.y + (largo/6));
  endShape();
  genDottedLine(origenX, origenY + (largo * 15/16), ancho * 3/4);
  PLAYER1_POSITION = movePlayer(origenX, ancho, largo,PLAYER1_POSITION);//Debe ir dentro de push/pop matrix para que no se salgo del campo
  popMatrix();
  
  scoreBoard(origenX,origenY, ancho, largo);
  
}

void scoreBoard(float origenX, float origenY, float ancho, float largo){
 int score1 = 0;
 int score2 = 0;
 float desfaseX = 20;
 float desfaseY = 50;
  
 String score_player1 = Integer.toString(score1);
 String score_player2 = Integer.toString(score2);
 textSize(32);
 fill(255,0,0);
 textAlign(RIGHT);
 text(score_player1, origenX - desfaseX, origenY + desfaseY);
 text("B", origenX - desfaseX, origenY + (desfaseY*2));
 
 fill(0,0,255);
 textAlign(LEFT);
 text(score_player2, origenX + ancho + desfaseX, origenY + desfaseY);
 text("B", origenX + ancho + desfaseX, origenY + (desfaseY*2));
}

public void genDottedLine(float x, float y, float ancho) {
    int aux_x = (int)x;
   for(int i = 0 ; i<(aux_x + ancho + 40); i+=10){
      ellipse (aux_x + i,y,1,1);  
   } 
}

PVector movePlayer(float origenX, float ancho, float largo, PVector player1_position) {
   float rectSize = width * 1/16;
   PLAYER1_POSITION.x = player1_position.x;
   PLAYER1_POSITION.y = player1_position.y;
   //PLAYER2_POSITION.y = posY;
   if(mouseX > origenX && mouseX < origenX + (ancho - rectSize) && mouseY > (largo*.53) && mouseY < largo){
     rect(mouseX, mouseY, rectSize, 10);
     player1_position.x = mouseX;
     player1_position.y = mouseY;
   } else {
     rect(PLAYER1_POSITION.x, PLAYER1_POSITION.y, rectSize, 10);
   }
   
   return player1_position;
}
