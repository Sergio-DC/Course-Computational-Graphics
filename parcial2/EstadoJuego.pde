public class EstadoJuego {
    boolean finDelJuego;
    boolean jugador_A_saca;
    boolean isPaused;
    Cancha cancha;
    Player player1, player2;
    Pelota pelota;
  
   public EstadoJuego() {
     isPaused = false;
     this.finDelJuego = false;
     this.jugador_A_saca = true;
   }
   
   public void configInitJuego() {
      //Observable
     pelota = new Pelota(new PVector(width/2, height/2), new PVector(1,1), new int[] {0,0,255});
     //Observers  
     PVector PLAYER1_POSITION = new PVector(width * .35,height/2 + 25);//Punto de Spawn del Player 1
     PVector PLAYER2_POSITION = new PVector(width * .60,height/2 + 25);//Punto de Spawn del Player 2
     player1 = new Player(PLAYER1_POSITION,"A",new int[] {0,0,255}, 0);
     player2 = new Player(PLAYER2_POSITION,"B",new int[] {254, 135, 66}, 0);
     //Colocamos los jugadores en la cancha
     cancha = new Cancha(player1, player2, pelota);
     //Los jugadores se suscriben a los eventos emitidos por la pelota (Patron Observer)
     pelota.addObserver(player1);
     pelota.addObserver(player2);
     pelota.estadoTurno = "A"; 
   }
   public void correrJuego() {
       this.finDelJuego = false;
       cancha.dibujarCancha();
   }
   
   public void dibujarMenu() {
      background(0);
      fill(14, 247, 191 );
      textSize(50);
      text("Juego de Squash",225,50);
      textSize(30);
      text("Jugador 1 se mueve con:",45,150);
      text("w: arriba",75,200);
      text("s: abajo",75,250);
      text("a: izquierda",75,300);
      text("d: derecha",75,350);
      text("Jugador 2 se mueve con:",45,400);
      text("i: arriba",75,450);
      text("k: abajo",75,500);
      text("j: izquierda",75,550);
      text("l: derecha",75,600);
      fill(255, 0, 0 );
      text("Presiona SPACE para iniciar",45,650);
      text("Presiona 'p' para pausar",45,700);
   }
   
   public void dibujarPausa() {
      background(#f5bf42);
      textSize(32);
      fill(0);
      textAlign(RIGHT);
      text("Pausa", width/2, height/2 - 50);
      text("Presiona SPACE para continuar...", width/2 + 225, height/2);
      text("Presiona m para volver al menu...", width/2 + 225, height/2 + 50);
   }
   
   public void terminarJuego() {
      pelota = null;
      player1 = null;
      player2 = null;
      cancha = null;
      this.finDelJuego = true;
   }
}
  
