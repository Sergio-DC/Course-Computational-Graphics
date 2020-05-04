EstadoJuego juego;
Grafica grafica;
CRUD_File crud_file;
boolean p1_menu_activo = true;
boolean p2_grafico_activo = false;
boolean p3_juego_activo = false;
boolean p4_finjuego_activo = false;
boolean p5_pausa_activo = false;

boolean archivoEscrito = false;

void setup(){
  size(1400, 1000);
  
  juego = new EstadoJuego();
  grafica = new Grafica();
  juego.configInitJuego(); //<>//
} //<>//
 //<>//
void draw() {     //<>//
    opcionTecla(); //<>//
     //<>//
    if(juego.finDelJuego) { //<>//
        p4_finjuego_activo = true; //<>//
    } //<>//
     //<>//
    if(p1_menu_activo){//Menu Ejecutandose //<>//
        juego.dibujarMenu(); //<>//
    } else if(p3_juego_activo) {//Juego ejecutandose //<>//
        if(juego.finDelJuego) //<>//
            juego.configInitJuego(); //<>//
        juego.correrJuego();     //<>//
     } else if(p5_pausa_activo) {//Pausa Ejectandose //<>//
         juego.dibujarPausa(); //<>//
     } else if (p2_grafico_activo) { //Estadisticas o Grafico esjecutandose //<>//
         juego.dibujarPartidasGanadas(); //<>//
     } else if(p4_finjuego_activo) {//Fin del Juego //<>//
         juego.dibujarFinDeJuego(); //<>//
     } //<>// //<>// //<>// //<>// //<>//
} //<>//
 //<>//
void dibujarScore() { //<>//
   textSize(32);
   text("Player1 : ", width/2, height/2);
   text("Player2 : ", width/2, height/2 + 50);
    //<>//
} //<>//

 //<>//
void keyPressed() { //<>//
  if(!juego.finDelJuego){ //<>//
     if (key == 'w') //<>//
         juego.player1.position.y -= 20; //<>//
    if (key == 's') //<>//
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
    }
    if(key == 'g') {
      p1_menu_activo = false;
      p2_grafico_activo = true;
    } 
}
