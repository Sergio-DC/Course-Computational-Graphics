Cancha cancha;
Player player1, player2;
Pelota pelota;
int [] PLAYER1_COLOR = new int[] {0,0,255};//Color del Player 1
int [] PLAYER2_COLOR = new int[] {254, 135, 66};//Color del Player 2
PVector BOLA_POS = new PVector(width/2, height/2);//Punto de Spawn de la bola
int VELOCIDAD_BOLA = 1;//Es recomendable que este en 1 para que el juego sea jugable
float lastPosX, lastPosY;

void setup(){
  background(200);
  size(600, 600);
  //Observable
  pelota = new Pelota(BOLA_POS, VELOCIDAD_BOLA, new int[] {0,0,255}); 
  //Observers  
  PVector PLAYER1_POSITION = new PVector(width * .35,height/2 + 25);//Punto de Spawn del Player 1
  PVector PLAYER2_POSITION = new PVector(width * .60,height/2 + 25);//Punto de Spawn del Player 2
  player1 = new Player(PLAYER1_POSITION,"A",PLAYER1_COLOR, 0);
  player2 = new Player(PLAYER2_POSITION,"B",PLAYER2_COLOR, 0);
  //Colocamos los jugadores en la cancha
  cancha = new Cancha(player1, player2);
  //Los jugadores se suscriben a los eventos emitidos por la pelota (Patron Observer)
  pelota.addObserver(player1);
  pelota.addObserver(player2);
  pelota.estadoTurno = "A";
}

void draw() {
    background(200);
    cancha.dibujarCancha();
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

void keyPressed() {
    if (key == 'w')
         player1.position.y -= 20;
    if (key == 's')
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
}
