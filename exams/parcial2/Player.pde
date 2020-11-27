import java.util.Collections;
import java.util.Observer;
/**
 * La siguiente clase representa a un jugador, 
 */
class Player implements Observer{
  PVector position;
  String nombre;
  float ancho;
  float alto;
  int [] rgb_color = new int[3];
  int score;
  float lastPosX, lastPosY;
  int partidasGanadas;
  
  public Player(PVector position,String nombre,int[] rgb_color, int score) {
    this.position = position;
    this.nombre = nombre;
    this.ancho = width * 2/16;
    this.alto = 11;
    this.rgb_color = rgb_color;
    this.score = score;
  }
  
  void movePlayer(float origenX, float ancho, float largo) {
   
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
     //pelota.listenerCollisionPlayer(this);
  }
  
  @Override
  public void update(Observable o, Object val) {
     if(((Pelota)val).fueraDelCampo && this.nombre.equals("B") && ((Pelota)val).estadoTurno.equals("A")) {//Si era el turno de A pero fallo
         ((Pelota)val).fueraDelCampo = false;             
         this.score += 1;//Se suma el punto a B
         //print("B gano un punto");
         juego.jugador_A_saca = false;
         juego.volver_a_sacar = true;
     } else if(((Pelota)val).fueraDelCampo && this.nombre.equals("A") && ((Pelota)val).estadoTurno.equals("B")) {//Si era el turno de B pero fallo  
           ((Pelota)val).fueraDelCampo = false;                                     
           this.score += 1;//Se suma un punto a A
           //print("A gano un punto");
           juego.jugador_A_saca = true;
           juego.volver_a_sacar = true;
     }
  }
}
