import java.util.Observer;

class Player implements Observer{
  PVector position;
  String nombre;
  float ancho;
  float alto;
  int [] rgb_color = new int[3];
  int score;
  
  public Player(PVector position,String nombre,int[] rgb_color, int score) {
    this.position = position;
    this.nombre = nombre;
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
  }
  
  @Override
  public void update(Observable o, Object val) {
     if(((Pelota)val).fueraDelCampo) {//La pelota en este punto ya salio del campo de juego
         if(((Pelota)val).estadoTurno.equals("A")) {//Si era el turno de A pero fallo
             print("Entre 1");
             if(this.nombre.equals("B"))//Se suma el punto a B
                 this.score += 1;
         } else { //Si era el turno de B pero fallo
           print("Entre 1");
           if(this.nombre.equals("A"))//Se suma el punto a A
             this.score += 1;
         }
     } else { // La pelota fue golpeada por un jugador
       if( ((Pelota)val).estadoTurno.equals("A"))
         print("Es el turno de: " + ((Pelota)val).estadoTurno); 
     }     
  }
}
