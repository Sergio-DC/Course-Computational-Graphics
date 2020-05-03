import java.util.Observable;

class Pelota extends Observable {
  PVector posicion;
  float diam;
  PVector velocidad;
  boolean isUp;
  float muroIzquierdo, origenY;
  float ancho;
  int[] color_pelota;
  String estadoTurno;//Nos indica que jugador puede pegarle a la pelota, dos valores posibles {"A", "B"}
  boolean fueraDelCampo;//Indica si la bandera esta dentro(false) o fuera(true) del campo
  
  public Pelota(PVector posicion, PVector velocidad, int [] color_pelota) {
     this.posicion = posicion;
     this.diam = 20;
     this.velocidad = velocidad;
     this.isUp = true;
     this.color_pelota = color_pelota;
     this.fueraDelCampo = false;
  }
  
  public void listenerCollisionPlayer(Player player) {
     this.posicion.add(this.velocidad);
     // Si la pelota golpea al jugador se invierte la direccion de esta
     if ( this.posicion.x > player.position.x && this.posicion.x < (player.position.x + player.ancho) && 
           this.posicion.y > (player.position.y)
           && player.nombre.equals(this.estadoTurno)) {
        isUp = true;
        if (player.nombre.equals("B")){
          this.velocidad.x = this.velocidad.x * -1;
          this.velocidad.y = this.velocidad.y * -1;
          //print("Entre B");
          this.estadoTurno = "A";
          this.color_pelota[0] = 0;
          this.color_pelota[1] = 0;
          this.color_pelota[2] = 255;
          if(!this.fueraDelCampo) {
            setChanged();
            notifyObservers(this);
          }
        } else {
          this.velocidad.x = this.velocidad.x * -1;
          this.velocidad.y = this.velocidad.y * -1;
          //print("Entre A");
           this.estadoTurno = "B";
           this.color_pelota[0] = 254;
           this.color_pelota[1] = 135;
           this.color_pelota[2] = 66;
           if(!this.fueraDelCampo) {
             setChanged();
             notifyObservers(this);
           }
        }
      } 
   
   }
   
   public void listenerCollisionWall() {
       //Listener del Muro Izquierdo
      if (this.posicion.x < muroIzquierdo){ 
        if(isUp) {
          this.velocidad.x = this.velocidad.x * -1;
          this.velocidad.y = this.velocidad.y * -1;//Hacia Arriba
          isUp= false;
          //this.posicion.x += speedX;
        } else if (!isUp){
          this.velocidad.x = this.velocidad.x * -1;
          this.velocidad.y = this.velocidad.y * 1;//Hacia Abajo
          isUp = false;
          //this.posicion.x += speedX; 
        }
        this.posicion.add(this.velocidad);
      }
      //Listener del muro derecho
      if (this.posicion.x > (muroIzquierdo + ancho)) {    
        if(isUp) {
          this.velocidad.x = this.velocidad.x * -1;
          this.velocidad.y = this.velocidad.y * -1;//Hacia Arriba
          isUp = false;
          //this.posicion.x += speedX;
        }else{
          this.velocidad.x = this.velocidad.x * -1;
          this.velocidad.y = this.velocidad.y * 1;//Hacia Abajo
          isUp = false;
          //this.posicion.x += speedX;
        }
      }    
      // Si la pelota golpea el muro de enfrente la pelota cambia su direccion
      //en sentido Contrario
      if (this.posicion.y < origenY) {
        this.velocidad.y = this.velocidad.y * -1;//Hacia Abajo
        //this.posicion.y += speedY;
         isUp = false;
      }
      this.posicion.add(this.velocidad);
   }
   /**
    * @param coordX representa el punto inicial en X donde se encuentra el limite del campo de juego
    * @param coordY representa el punto inicial en Y donde se encuentra el limite del campo de juego
    * @param ancho representa el ancho del campo juego
    */
   public void listenerOutOfField(float coordY) { 
       if(this.posicion.y > coordY && !this.fueraDelCampo) {
             print("!");
            this.fueraDelCampo = true;
            setChanged();
            notifyObservers(this);
       }
   }
   
   public void dibujarPelota(){
      noStroke();
      fill(color_pelota[0],color_pelota[1],color_pelota[2]);
      ellipse(this.posicion.x, this.posicion.y, diam, diam);
   }

}
