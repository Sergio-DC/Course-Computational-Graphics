EstadoJuego juego;
boolean p1_menu_activo = true;
boolean p2_grafico_activo = false;
boolean p3_juego_activo = false;
boolean p4_finjuego_activo = false;
boolean p5_pausa_activo = false;
boolean isTheGameStarting = true;

boolean archivoEscrito = false;
boolean archivoLeido = false;

void setup(){
  size(600, 600);
  juego = new EstadoJuego();
}

void draw() {     //<>//
    opcionTecla(); //<>//
     //<>//
    if(juego.finDelJuego) { //<>//
        p4_finjuego_activo = true; //<>//
    }     //<>//
    if(p1_menu_activo){//Menu Ejecutandose //<>//
        juego.dibujarMenu(); //<>//
        juego.terminarJuego(); //<>//
    } else if(p3_juego_activo) {//Juego ejecutandose //<>//
        if(isTheGameStarting){ //<>//
           juego.configInitJuego(); //<>//
           isTheGameStarting = false; //<>//
        } //<>//
        juego.correrJuego();     //<>//
     } else if(p5_pausa_activo) {//Pausa Ejectandose //<>//
         juego.dibujarPausa(); //<>//
     } else if (p2_grafico_activo) { //Estadisticas o Grafico esjecutandose //<>//
         if(!archivoLeido) { //<>//
            juego.leerArchivo(); //<>//
            archivoLeido = true;  //<>//
         } //<>//
         juego.dibujarPartidasGanadas(); //<>//
     } else if(p4_finjuego_activo) {//Fin del Juego //<>//
         juego.dibujarFinDeJuego(); //<>//
         if(!archivoEscrito) { //<>//
             juego.actualizarArchivo();
             print("Archivo escrito");
             archivoEscrito = true;
         } //<>//
     } //<>// //<>// //<>// //<>// //<>//
}
 //<>//
void dibujarScore() { //<>//
   textSize(32); //<>//
   text("Player1 : ", width/2, height/2); //<>//
   text("Player2 : ", width/2, height/2 + 50); //<>//
    //<>//
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

public void opcionTecla() {
   if(key == ' ') {
       p1_menu_activo = false;
       p3_juego_activo = true;
       p4_finjuego_activo = false;
       juego.finDelJuego = false;
    }
    if(key == 'p' && p3_juego_activo){
        p3_juego_activo = false;
        p5_pausa_activo = true;
    }    
    if(key == 'm') {
      p3_juego_activo = false;
      p2_grafico_activo = false;
      p1_menu_activo = true;
      p5_pausa_activo = false;
      p4_finjuego_activo = false;
      juego.finDelJuego = true;
      isTheGameStarting = true;
      archivoEscrito = false;
      archivoLeido = false;
    }
    if(key == 'g') {
      p1_menu_activo = false;
      p2_grafico_activo = true;
    } 
    
    if(juego.finDelJuego){
      p3_juego_activo = false;
      p4_finjuego_activo = true;
    }
}
