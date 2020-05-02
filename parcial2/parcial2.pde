Player player1, player2;
Pelota pelota;
int VELOCIDAD_BOLA = 2;
float diam = 10;
float x, y, speedX, speedY;//Variables para la pelota
boolean isUp = true;
boolean keyLeft, keyRight, keyUp, keyDown;
boolean keyLeft2, keyRight2, keyUp2, keyDown2,keyRest;
//boolean safeZoneRight = true;//si es verdad el jugador no ha salido del campo de juego por el lateral derecho
//boolean safeZoneLeft = true;//si es verdad el jugador no ha salido del campo de juego por el lateral izquierdo
float lastPosX, lastPosY;

void setup(){
  background(200);
  size(600, 600);
  
  PVector BALL_POSITION = new PVector(width/2, height/2);
  pelota = new Pelota(BALL_POSITION, VELOCIDAD_BOLA);
  speedX = random(1, VELOCIDAD_BOLA);
  speedY = -random(1, VELOCIDAD_BOLA);  

  PVector this1_POSITION = new PVector(width * .35,height/2 + 25);  
  PVector this2_POSITION = new PVector(width * .60,height/2 + 25);
  player1 = new Player(this1_POSITION,new int[] {0,0,255}, 0);
  player2 = new Player(this2_POSITION, new int[] {254, 135, 66}, 0);
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
  stroke(255,0,0);
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
  pelota.origenX = origenX; 
  pelota.origenY = origenY;
  pelota.ancho = ancho;
  player1.movePlayer(origenX, ancho, largo, pelota);//Debe ir dentro de push/pop matrix para que no se salgo del campo
  player2.movePlayer(origenX, ancho, largo, pelota);
  popMatrix();
  
  scoreBoard(origenX,origenY, ancho);
}

void keyPressed() {
    if (key == 'w')
      //if (safeZone)
         player1.position.y -= 20;
    if (key == 's')
      //if (safeZone)
         player1.position.y += 20;
    if (key == 'a')
        player1.position.x -= 25;
    if (key == 'd')
      player1.position.x += 25;
    if (key == 'i')
      player2.position.y -= 20;
    if (key == 'k')
      player2.position.y += 20;
    if (key == 'j')
      player2.position.x -= 25;
    if (key == 'l')
      player2.position.x += 25;
    if (key == 'r')
      keyRest = true;
}

void scoreBoard(float origenX, float origenY, float ancho){
 int score1 = 0;
 int score2 = 0;
 float desfaseX = 20;
 float desfaseY = 50;
  
 String score_this1 = Integer.toString(score1);
 String score_this2 = Integer.toString(score2);
 textSize(32);
 fill(255,0,0);
 textAlign(RIGHT);
 text(score_this1, origenX - desfaseX, origenY + desfaseY);
 text("B", origenX - desfaseX, origenY + (desfaseY*2));
 
 fill(0,0,255);
 textAlign(LEFT);
 text(score_this2, origenX + ancho + desfaseX, origenY + desfaseY);
 text("B", origenX + ancho + desfaseX, origenY + (desfaseY*2));
}

public void genDottedLine(float x, float y, float ancho) {
    int aux_x = (int)x;
   for(int i = 0 ; i<(aux_x + ancho + 40); i+=10){
      ellipse (aux_x + i,y,1,1);  
   } 
}

class Player {
  PVector position;
  float ancho;
  float alto;
  int [] rgb_color = new int[3];
  int score;
  
  public Player(PVector position,int[] rgb_color, int score) {
    this.position = position;
    this.ancho = width * 1/16;
    this.alto = 11;
    this.rgb_color = rgb_color;
    this.score = score;
  }
  
  void movePlayer(float origenX, float ancho, float largo, Pelota pelota) {
   
     strokeWeight(5);
     point(origenX, 100);
     point(origenX + ancho , 100);
     if(this.position.x > (origenX - this.ancho) && this.position.x < origenX + ancho
     && this.position.y > (largo*.53) && this.position.y < largo){//Esta dentro de la cancha
       noStroke();
       fill(this.rgb_color[0],this.rgb_color[1],this.rgb_color[2]);
       rect(this.position.x, this.position.y, this.ancho, 10);
       this.position.x = this.position.x;
       this.position.y = this.position.y;
       lastPosX = this.position.x;
       lastPosY = this.position.y;
     } else {
       rect(lastPosX, lastPosY, this.ancho, this.alto);
     }
     pelota.listenerCollisionPlayer(this);
     pelota.listenerCollisionWall();
  }
}

class Pelota {
  PVector posicion;
  float diam;
  int velocidad;
  boolean isUp = true;
  float origenX, origenY;
  float ancho;
  
  public Pelota(PVector posicion, int velocidad) {
     this.posicion = posicion;
     this.diam = 10;
     this.velocidad = velocidad;
     this.isUp = true;
  }
  
  public void listenerCollisionPlayer(Player player) {
     noStroke();
     fill(253, 118, 58);
     ellipse(this.posicion.x, this.posicion.y, diam, diam);
     this.posicion.x += speedX;
     this.posicion.y += speedY;
     // if ball hits this, invert X directiondd
     if ( this.posicion.x >= player.position.x && this.posicion.x <= (player.position.x + player.ancho) && 
           this.posicion.y >= (player.position.y - player.alto) && this.posicion.y <= (player.position.y + player.alto) ) {
        speedX = speedX * -1;
        speedY = speedY * -1;
        isUp = true;
      } 
   
   }
   
   public void listenerCollisionWall() {
       //Listener del Muro Izquierdo
      if (this.posicion.x < origenX){ 
        if(isUp) {
     
          speedX = 1 * random(1, VELOCIDAD_BOLA);
          speedY = -random(1, VELOCIDAD_BOLA);//Hacia Arriba
          this.posicion.x += speedX;
        } else if (!isUp){
          print("eNTRE");
          speedX = 1 * random(1, VELOCIDAD_BOLA);
          speedY = random(1, VELOCIDAD_BOLA);//Hacia Abajo
          this.posicion.x += speedX; 
        }
      }
      //Listener del muro derecho
      if (this.posicion.x > (origenX + ancho)) {    
        if(isUp) {
          speedX = -1 * random(1, VELOCIDAD_BOLA);
          speedY = -1 * random(1, VELOCIDAD_BOLA);//Hacia Arriba
          this.posicion.x += speedX;
        }else{
          speedX = -1 * random(1, VELOCIDAD_BOLA);
          speedY = 1 * random(1, VELOCIDAD_BOLA);//Hacia Abajo
          this.posicion.x += speedX;
        }
      }    
      // if ball hits up or down, change direction of Y   
      if (this.posicion.y < origenY) {
        speedY = 1 * random(1,VELOCIDAD_BOLA);
        this.posicion.y += speedY;
         isUp = false;
      }
   }
}
