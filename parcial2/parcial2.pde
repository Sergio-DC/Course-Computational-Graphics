EstadoJuego juego;
Grafica grafica;
CRUD_File crud_file;
boolean pantallaDeInicio = true;
boolean archivoEscrito = false;

void setup(){
  size(1400, 1000);
  
  juego = new EstadoJuego();
  grafica = new Grafica();
  juego.configInitJuego();
  
  
}

void draw() {    
    if(key == ' ' || (!juego.finDelJuego && !juego.isPaused && !pantallaDeInicio) ) {//Correr Juego con SPACE
        if(juego.isPaused)
            juego.isPaused = false;
        pantallaDeInicio = false;
        if(juego.finDelJuego)
            juego.configInitJuego();
          if(!juego.isPaused)
              juego.correrJuego();
        if(key == 'm')
          juego.finDelJuego = true;
        else if(key == 'p') {
          if(!juego.isPaused)//La pausa sera verdadera
              juego.isPaused = true;
          juego.dibujarPausa();      
        }
    } else if(juego.finDelJuego && key == ' ') {//El juego ha terminado, alguien ha obtenido 5 puntos
        println("Mostrar Ganador de partida");
        juego.dibujarGanador();
        if(!archivoEscrito) {
            //crud_file.witeFile("player", "ganadas","squash.csv", juego.ganador);
            archivoEscrito = true;
        }
    } else if(key == 'm' || pantallaDeInicio) {//Salir o ir al Menu   
        if(!pantallaDeInicio)
            juego.terminarJuego();
        juego.dibujarMenu();
        if(key == 'n') {
           print("Partidas Ganadas");
           juego.drawPartidasGanadas();
        }
    }
    //grafica.pieChart(300);
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
