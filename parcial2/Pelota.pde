import java.util.Observable;

class Pelota extends Observable {
  PVector posicion;
  float diam;
  int velocidad;
  boolean isUp;
  float origenX, origenY;
  float ancho;
  int[] color_pelota;
  String estadoTurno;//Nos indica que jugador puede pegarle a la pelota, dos valores posibles {"A", "B"}
  boolean fueraDelCampo;//Indica si la bandera esta dentro(false) o fuera(true) del campo
  float speedX, speedY;
  
  public Pelota(PVector posicion, int velocidad, int [] color_pelota) {
     this.posicion = posicion;
     this.diam = 10;
     this.velocidad = velocidad;
     this.isUp = true;
     this.color_pelota = color_pelota;
     this.fueraDelCampo = false;
     speedX = random(1, velocidad);
     speedY = -random(1, velocidad); 
  }
  
  public void listenerCollisionPlayer(Player player) {
     noStroke();
     fill(color_pelota[0],color_pelota[1],color_pelota[2]);
     ellipse(this.posicion.x, this.posicion.y, diam, diam);
     this.posicion.x += speedX;
     this.posicion.y += speedY;
     // Si la pelota golpea al jugador se invierte la direccion de esta
     if ( this.posicion.x >= player.position.x && this.posicion.x <= (player.position.x + player.ancho) && 
           this.posicion.y >= (player.position.y - player.alto) && this.posicion.y <= (player.position.y + player.alto) 
           && player.nombre.equals(this.estadoTurno)) {
        isUp = true;
        if (player.nombre.equals("B")){
          speedX = speedX * -1;
          speedY = speedY * -1;
          //print("Entre B");
          this.estadoTurno = "A";
          this.color_pelota[0] = 0;
          this.color_pelota[1] = 0;
          this.color_pelota[2] = 255;
          setChanged();
          notifyObservers(this);
        } else {
          speedX = speedX * -1;
          speedY = speedY * -1;
          //print("Entre A");
           this.estadoTurno = "B";
           this.color_pelota[0] = 254;
           this.color_pelota[1] = 135;
           this.color_pelota[2] = 66;
           setChanged();
           notifyObservers(this);
        }
      } 
   
   }
   
   public void listenerCollisionWall() {
       //Listener del Muro Izquierdo
      if (this.posicion.x < origenX){ 
        if(isUp) {
     
          speedX = 1 * random(1, this.velocidad);
          speedY = -random(1, this.velocidad);//Hacia Arriba
          this.posicion.x += speedX;
        } else if (!isUp){
          speedX = 1 * random(1, this.velocidad);
          speedY = random(1, this.velocidad);//Hacia Abajo
          this.posicion.x += speedX; 
        }
      }
      //Listener del muro derecho
      if (this.posicion.x > (origenX + ancho)) {    
        if(isUp) {
          speedX = -1 * random(1, this.velocidad);
          speedY = -1 * random(1, this.velocidad);//Hacia Arriba
          this.posicion.x += speedX;
        }else{
          speedX = -1 * random(1, this.velocidad);
          speedY = 1 * random(1, this.velocidad);//Hacia Abajo
          this.posicion.x += speedX;
        }
      }    
      // if ball hits up or down, change direction of Y   
      if (this.posicion.y < origenY) {
        speedY = 1 * random(1,this.velocidad);
        this.posicion.y += speedY;
         isUp = false;
      }
   }
   /**
    * @param coordX representa el punto inicial en X donde se encuentra el limite del campo de juego
    * @param coordY representa el punto inicial en Y donde se encuentra el limite del campo de juego
    * @param ancho representa el ancho del campo juego
    */
   public void listenerOutOfField(float coordY) { 
       if(this.posicion.y > coordY && !this.fueraDelCampo) {
            this.fueraDelCampo = true;
            setChanged();
            notifyObservers(this);
       }
   }

}
