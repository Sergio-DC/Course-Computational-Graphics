String [] deportes = {"Futbol","Baseball","Basquetball","Americano","Golf","Tenis","Volleyball"};
int[] fans = {29,8,18,21,9,10,5};

int[] angles = { (29*360)/100,(8*360)/100,(18*360)/100,(21*360)/100,(9*360)/100,(10*360)/100,(6*360)/100};

void setup() {
  size(700, 400);
}

void draw() {
  background(#3D6F1C);
  pieChart(300, angles);
}

void pieChart(float diameter, int[] data) {
  fill(0);
  textSize(40);
  text("¿Cuál es tu deporte favorito?",width/10,height/10);
  float lastAngle = 0;
  int alt = height/4;
  for (int i = 0; i < data.length; i++) {
    float gray = map(i, 0, data.length, 0, 255);
    fill(gray);
    arc(width/1.5, height/2, diameter, diameter, lastAngle, lastAngle+radians(data[i]));
    lastAngle += radians(data[i]);
    textSize(26);
    fill(gray);
    text(deportes[i]+" "+fans[i],width/10,alt);
    alt = alt+30;
  }
  
}
