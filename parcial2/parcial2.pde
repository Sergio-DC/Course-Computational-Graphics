EstadoJuego juego;
boolean pantallaDeInicio = true;

void setup(){
size(600, 600);
  juego = new EstadoJuego();
  juego.configInitJuego();
}

void draw() {    
    if(key == ' ' || !juego.finDelJuego) {//Correr Juego
      pantallaDeInicio = false;
      if(juego.finDelJuego)
        juego.configInitJuego();
      juego.correrJuego();
      if(key == 'm')
        juego.finDelJuego = true;
    else if(key == 'p' || !juego.isPaused) {
      if(juego.isPaused)
        juego.isPaused = false;
      juego.dibujarPausa();
      juego.isPaused = true;
    }
    } else if(key == 'm' || pantallaDeInicio) {//Salir/Menu   
      if(!pantallaDeInicio)
        juego.terminarJuego();
      juego.dibujarMenu();
    }
}

void dibujarScore() {
   textSize(32);
   text("Player1 : ", width/2, height/2);
   text("Player2 : ", width/2, height/2 + 50);
   
}


void keyPressed() {
  if(!juego.finDelJuego){
     if (key == 'w')
         juego.player1.position.y -= 20;
    if (key == 's')
         juego.player1.position.y += 20;
    if (key == 'a')
        juego.player1.position.x -= 25;
    if (key == 'd')
      juego.player1.position.x += 25;
    if (key == 'i')
      juego.player2.position.y -= 20;
    if (key == 'k')
      juego.player2.position.y += 20;
    if (key == 'j')
      juego.player2.position.x -= 25;
    if (key == 'l')
      juego.player2.position.x += 25; 
  }
}
