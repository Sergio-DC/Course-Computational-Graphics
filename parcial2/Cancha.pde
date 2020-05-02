public class Cancha {
  float padding_x = 75;
  float padding_y_top = 20;
  float ancho = width - (padding_x * 2);
  float largo = height - (padding_y_top * 2);
  float origenX = padding_x;
  float origenY = padding_y_top;
  float limiteCampoY = origenY + (largo * 15/16);
  float speedX, speedY;
  Player player1;
  Player player2;
  Pelota pelota;
  
  public Cancha(Player player1, Player player2, Pelota pelota) {
    this.player1 = player1;
    this.player2 = player2;
    this.pelota = pelota;
    speedX = random(1, VELOCIDAD_BOLA);
    speedY = -random(1, VELOCIDAD_BOLA); 
  }

  public void dibujarCancha(){
    fill(150);
    rect(origenX, origenY, ancho, largo);//Base para la cancha de SQUASH
    pushMatrix();
    fill(0,255,0);
    translate(15,15);
    scale(0.95);
    rect(origenX, origenY, ancho, largo); //Cancha de Squashs    
    dibujarDelimitaciones();
    pelota.origenX = origenX; 
    pelota.origenY = origenY;
    pelota.ancho = ancho;
    //Debe ir dentro de push/pop matrix para que no se salgo del campo
    player1.movePlayer(origenX, ancho, largo, pelota);
    player2.movePlayer(origenX, ancho, largo, pelota);
    pelota.listenerCollisionWall();
    pelota.listenerOutOfField(limiteCampoY);
    popMatrix();
    scoreBoard(origenX,origenY, ancho);
  }
  
  void scoreBoard(float origenX, float origenY, float ancho){
     float desfaseX = 20;
     float desfaseY = 50;
      
     textSize(32);
     fill(player1.rgb_color[0],player1.rgb_color[1],player1.rgb_color[2]);
     textAlign(RIGHT);
     text(player1.score, origenX - desfaseX, origenY + desfaseY);
     text("A", origenX - desfaseX, origenY + (desfaseY*2));
     
     fill(player2.rgb_color[0],player2.rgb_color[1],player2.rgb_color[2]);
     textAlign(LEFT);
     text(player2.score, origenX + ancho + desfaseX, origenY + desfaseY);
     text("B", origenX + ancho + desfaseX, origenY + (desfaseY*2));
  }
  private void dibujarDelimitaciones() {
    float punto_medio_y = ( origenY + (origenY + largo) ) / 2;
    float punto_medio_x = (origenX + (origenX + ancho) ) / 2;
    strokeWeight(10);
    //Linea Horizontal
    PVector v1_horizontal , v2_horizontal;
    v1_horizontal = new PVector(origenX, punto_medio_y);
    v2_horizontal = new PVector(origenX + ancho, punto_medio_y);
    strokeWeight(3);
    stroke(255,0,0);
    line(v1_horizontal.x, v1_horizontal.y, v2_horizontal.x, v2_horizontal.y);
    //Linea Vertical
    PVector v1_vertical , v2_vertical;
    v1_vertical = new PVector(punto_medio_x, punto_medio_y);
    v2_vertical = new PVector(punto_medio_x, punto_medio_y + (largo/2));
    line(v1_vertical.x, v1_vertical.y, v2_vertical.x, v2_vertical.y);
    //Rectangulos pequeños
    stroke(255,0,0);
    beginShape();
      vertex(v1_horizontal.x + 1, v1_horizontal.y);
      vertex(v1_horizontal.x + (ancho/4), v1_horizontal.y);
      vertex(v1_horizontal.x + (ancho/4), v1_horizontal.y + (largo/6));
      vertex(v1_horizontal.x + 1, v1_horizontal.y + (largo/6));
    endShape();
    beginShape();
      vertex(v1_horizontal.x + (ancho) - 1, v1_horizontal.y);
      vertex(v1_horizontal.x + (ancho * 3/4) - 1, v1_horizontal.y);
      vertex(v1_horizontal.x + (ancho * 3/4) - 1, v1_horizontal.y + (largo/6));
      vertex(v1_horizontal.x + (ancho) - 1, v1_horizontal.y + (largo/6));
    endShape();
    genDottedLine(origenX, limiteCampoY, ancho * 3/4);
  }
  
  
  private void genDottedLine(float x, float y, float ancho) {
      int aux_x = (int)x;
      for(int i = 0 ; i<(aux_x + ancho + 40); i+=10){
        ellipse (aux_x + i,y,1,1);  
      } 
  }
  
}
