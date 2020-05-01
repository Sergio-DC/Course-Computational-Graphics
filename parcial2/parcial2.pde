
void setup(){
  drawField();
  size(600, 600);
}

void draw() {
  
}

void drawField() {
 float padding_x = 25;
 //Se quita el doble de padding al lateral derecho para quede
 //simetrico con el lateral izquierdo
  float ancho = width - (padding_x * 2);
  float alto = height;
  float origenX = padding_x, origenY = 20;
  
  fill(0,255,0);
  rect(origenX, origenY, ancho, alto);//Este va encima de otro rect
}
