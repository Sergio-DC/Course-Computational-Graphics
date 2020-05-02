PVector PLAYER1_POSITION, PLAYER2_POSITION, BALL_POSITION;
int VELOCIDAD_BOLA = 2;
float diam = 10;
float x, y, speedX, speedY;//Variables para la pelota
boolean isUp = true;
boolean keyLeft, keyRight, keyUp, keyDown;
boolean keyLeft2, keyRight2, keyUp2, keyDown2,keyRest;
boolean safeZoneRight = true;//si es verdad el jugador no ha salido del campo de juego por el lateral derecho
boolean safeZoneLeft = true;//si es verdad el jugador no ha salido del campo de juego por el lateral izquierdo
float lastPosX, lastPosY;

void setup(){
  background(200);
  size(600, 600);

  PLAYER1_POSITION = new PVector(width/2,height/2 + 25);  
  PLAYER2_POSITION = new PVector(width/2,height/2 + 25);
  BALL_POSITION = new PVector(100, 150);
  speedX = random(3, 5);
  speedY = random(3, 5);  
}

void draw() {
     background(200);
    drawField();
    //print("SafeZoneRigth: ", safeZoneRight);
}

void drawField() {
float padding_x = 75;
float padding_y_top = 20;
float ancho = width - (padding_x * 2);
float largo = height - (padding_y_top * 2);
float origenX = padding_x;
float origenY = padding_y_top;

  fill(150);
  rect(origenX, origenY, ancho, largo);//Base para la cancha de SQUASH
  pushMatrix();
  fill(0,255,0);
  translate(15,15);
  scale(0.95);
  rect(origenX, origenY, ancho, largo); //Cancha de Squash
  
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
  PLAYER1_POSITION = movePlayer(origenX, origenY,ancho, largo,PLAYER1_POSITION);//Debe ir dentro de push/pop matrix para que no se salgo del campo
  PLAYER2_POSITION = movePlayer(origenX, origenY,ancho, largo,PLAYER2_POSITION);
  popMatrix();
  
  scoreBoard(origenX,origenY, ancho, largo);
}

PVector movePlayer(float origenX, float origenY, float ancho, float largo, PVector PLAYER_POSITION) {
   float playerWidth = width * 1/16;
   float playerHeight = 11;
   
   strokeWeight(5);
   point(origenX, 100);
   point(origenX + ancho , 100);
   if(PLAYER_POSITION.x > (origenX - playerWidth) && PLAYER_POSITION.x < origenX + ancho
   && PLAYER_POSITION.y > (largo*.53) && PLAYER_POSITION.y < largo){//Esta dentro de la cancha
     rect(PLAYER_POSITION.x, PLAYER_POSITION.y, playerWidth, 10);
     PLAYER_POSITION.x = PLAYER_POSITION.x;
     PLAYER_POSITION.y = PLAYER_POSITION.y;
     lastPosX = PLAYER_POSITION.x;
     lastPosY = PLAYER_POSITION.y;
   } else {
     /*if(lastPosX < origenX) {
       print("Entre 1");
       safeZoneLeft = false;
       safeZoneRight = true;
     } else if(lastPosX > (origenX + ancho)) {
       safeZoneLeft = true;
       safeZoneRight= false;
       print("Entre 2");
     }*/
     rect(lastPosX, lastPosY, playerWidth, playerHeight);
   }
   noStroke();
   fill(253, 118, 58);
   ellipse(BALL_POSITION.x, BALL_POSITION.y, diam, diam);
   BALL_POSITION.x += speedX;
   BALL_POSITION.y += speedY;
   // if ball hits player, invert X directiondd
   if ( BALL_POSITION.x >= PLAYER_POSITION.x && BALL_POSITION.x <= (PLAYER_POSITION.x + playerWidth) && 
         BALL_POSITION.y >= (PLAYER_POSITION.y - playerHeight) && BALL_POSITION.y <= (PLAYER_POSITION.y + playerHeight) ) {
      speedX = speedX * -1;
      speedY = speedY * -1;
      isUp = true;
    } 
   
   //Listener del Muro Izquierdo
  if (BALL_POSITION.x < origenX){ 
    if(isUp) {
      speedX = 1 * random(1, VELOCIDAD_BOLA);
      speedY = -random(1, VELOCIDAD_BOLA);//Hacia Arriba
      BALL_POSITION.x += speedX;
    } else if (!isUp){
      speedX = 1 * random(1, VELOCIDAD_BOLA);
      speedY = random(1, VELOCIDAD_BOLA);//Hacia Abajo
      BALL_POSITION.x += speedX; 
    }
  }
  //Listener del muro derecho
  if (BALL_POSITION.x > (origenX + ancho)) {    
    if(isUp) {
      speedX = -1 * random(1, VELOCIDAD_BOLA);
      speedY = -1 * random(1, VELOCIDAD_BOLA);//Hacia Arriba
      BALL_POSITION.x += speedX;
    }else{
      speedX = -1 * random(1, VELOCIDAD_BOLA);
      speedY = 1 * random(1, VELOCIDAD_BOLA);//Hacia Abajo
      BALL_POSITION.x += speedX;
    }
  }
  
  // if ball hits up or down, change direction of Y   
  if (BALL_POSITION.y < origenY) {
    speedY = 1 * random(1,VELOCIDAD_BOLA);
    BALL_POSITION.y += speedY;
     isUp = false;
  }
   
   return PLAYER_POSITION;
}



void keyPressed() {
    if (key == 'w')
      //if (safeZone)
         PLAYER1_POSITION.y -= 20;
    if (key == 's')
      //if (safeZone)
         PLAYER1_POSITION.y += 20;
    if (key == 'a')
        PLAYER1_POSITION.x -= 25;
      /*if (safeZoneLeft) {
        PLAYER1_BALL_POSITION[0].x -= 25;
      } else {
        PLAYER1_BALL_POSITION[0].x += 10;
        safeZoneLeft = true;
      }*/
    if (key == 'd')
      PLAYER1_POSITION.x += 25;
      /*if (safeZoneRight) {
        PLAYER1_BALL_POSITION[0].x += 25;
      } else {
        PLAYER1_BALL_POSITION[0].x -= 10;        
        safeZoneRight = true;
      }*/
    if (key == 'i')
      PLAYER2_POSITION.y -= 20;
    if (key == 'k')
      PLAYER2_POSITION.y += 20;
    if (key == 'j')
      PLAYER2_POSITION.x -= 25;
    if (key == 'l')
      PLAYER2_POSITION.x += 25;
    if (key == 'r')
      keyRest = true;
}
/*void keyReleased() {

    if (key == 'w')
  
    if (key == 's')
      PLAYER1_BALL_POSITION[0].y += 10;
    if (key == 'a')
      PLAYER1_BALL_POSITION[0].x -= 30;
    if (key == 'd')
      PLAYER1_BALL_POSITION[0].x += 30; 
    if (key == 'i')
      keyUp2 = false;
    if (key == 'k')
      keyDown2 = false;
    if (key == 'j')
      keyLeft2 = false;
    if (key == 'l')
      keyRight2 = false;
    if (key == 'r')
      keyRest = false;
}*/

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
