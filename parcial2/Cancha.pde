public class Cancha {
  float padding_x = 75;
  float padding_y_top = 20;
  float ancho = width - (padding_x * 2);
  float largo = height - (padding_y_top * 2);
  float origenX = padding_x;
  float origenY = padding_y_top;
  float speedX, speedY;
  Player player1, player2;
  
  public Cancha(Player player1, Player player2) {
    this.player1 = player1;
    this.player2 = player2;
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
    
  //Dibujar Lineas Delimitadoras
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
    genDottedLine(origenX, origenY + (largo * 15/16), ancho * 3/4);
    pelota.origenX = origenX; 
    pelota.origenY = origenY;
    pelota.ancho = ancho;
    player1.movePlayer(origenX, ancho, largo, pelota);//Debe ir dentro de push/pop matrix para que no se salgo del campo
    player2.movePlayer(origenX, ancho, largo, pelota);
    popMatrix();
    scoreBoard(origenX,origenY, ancho);
  }
  
  private void genDottedLine(float x, float y, float ancho) {
      int aux_x = (int)x;
      for(int i = 0 ; i<(aux_x + ancho + 40); i+=10){
        ellipse (aux_x + i,y,1,1);  
      } 
  }
  
}
