Pelota pelota;
public class EstadoJuego {
    int PTS_MAX_TO_WIN = 0;
    boolean finDelJuego;
    boolean ganoJugadorA;
    boolean volver_a_sacar;
    boolean jugador_A_saca;
    boolean isPaused;
    Player ganador;
    Cancha cancha;
    Player player1, player2;
  
   public EstadoJuego() {
     isPaused = false;
     this.finDelJuego = false;
     this.volver_a_sacar = false;
     this.jugador_A_saca = true;
     this.ganoJugadorA = false;
   }
   
   public void configInitJuego() {
      //Observable
     pelota = new Pelota(new PVector(width/2, height/2), 2, new int[] {0,0,255});
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
   void correrJuego() {
       this.finDelJuego = false;
       cancha.dibujarCancha();
      if(volver_a_sacar) {
         delay(1000);
         pelota.posicion.x = width/2 + 100;
         pelota.posicion.y = height/2 - 50;
         volver_a_sacar = false;
         pelota.estadoTurno = (jugador_A_saca) ?  "B" : "A";
      }
      
      if(this.player1.score > PTS_MAX_TO_WIN) {        
          this.finDelJuego = true;
          this.ganador = player1;
      }
      
      if(this.player2.score > PTS_MAX_TO_WIN) {
         this.finDelJuego = true;
         this.ganador = player2;
      }
        
   }
   
   public void dibujarMenu() {
      background(0);
      fill(14, 247, 191 );
      textSize(40);
      textAlign(CENTER);
      text("Juego de Squash",width/2,50);
      textSize(20);
      text("Jugador 1 se mueve con:",width/2,100);
      text("w: arriba",width/2,140);
      text("s: abajo",width/2,180);
      text("a: izquierda",width/2,220);
      text("d: derecha",width/2,260);
      text("Jugador 2 se mueve con:",width/2,300);
      text("i: arriba",width/2,340);
      text("k: abajo",width/2,380);
      text("j: izquierda",width/2,420);
      text("l: derecha",width/2,460);
      fill(255, 0, 0 );
      text("Presiona SPACE para iniciar",width/2, 500);
      text("Presiona 'p' para pausar",width/2,540);
   }
   
   public void dibujarGanador() {
       background(0);
       fill(14, 247, 191 );
       textSize(30);
       textAlign(CENTER);
       text("El ganador es: " + this.ganador.nombre,width/2,50);
       textAlign(CENTER);
       text("Presiona 'm' para volver al menu",width/2,100);
   }
   
   public void dibujarPausa() {
      background(#f5bf42);
      fill(0);
      textAlign(CENTER);
      textSize(40);
      text("Pausa", width/2, height/2 - 50);
      textSize(30);
      text("Presiona SPACE para continuar...", width/2, height/2);
      text("Presiona m para volver al menu...", width/2, height/2 + 50);
   }
   
   public void terminarJuego() {
      pelota = null;
      player1 = null;
      player2 = null;
      cancha = null;
      this.finDelJuego = true;
   }
}
  
