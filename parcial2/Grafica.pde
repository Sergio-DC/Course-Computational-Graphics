public class Grafica implements ListenerUpdatedFile{
  ArrayList<String> lista_etiquetas;
  ArrayList<Float> lista_valores; 
  float [] valores_reales; 
  String fileName = "squash.csv";
  PVector posicion;
  PVector posLabels;
  
  public Grafica() {
    
    //readFile("jugador", "ganadas", fileName);
    this.posicion = new PVector(width/2, height/2 - 50);
    this.posLabels = new PVector(posicion.x - (posicion.x*.5), 25);
  }
  
  public void pieChart(float diameter) {
      lista_valores = ajustarValores(lista_valores);
      float lastAngle = 0;
      for (int i = 0; i < lista_valores.size(); i++) {
        float canal_rojo = random(256);
        float canal_verde = random(256);
        float canal_azul = random(256);
        fill(canal_rojo, canal_verde, canal_azul);
        arc(posicion.x, posicion.y, diameter, diameter, lastAngle, lastAngle+radians(lista_valores.get(i)));
        lastAngle += radians(lista_valores.get(i));
        String info = lista_etiquetas.get(i)+" "+valores_reales[i];//Nombre y numero de juegos ganados
        pushMatrix();
          translate(250, 200);
          textSize(20);
          fill(canal_rojo, canal_verde, canal_azul);
          ellipse(posLabels.x - 10, (this.posLabels.y * i) - 5,10,10);
          fill(0);
          text(info,posLabels.x, this.posLabels.y * i);
        popMatrix(); 
      }  
  }
  private ArrayList<Float> ajustarValores(ArrayList<Float> valores) {
      //Calcular Suma de valores de la lista
      float sumaTotal = 0;
      for(int i = 0; i < valores.size(); i++)
         sumaTotal += valores.get(i);   
         
      //Crear una lista que tenga los valores de la lista inicial en porcentaje
      ArrayList<Float> lista_porcentaje = new ArrayList();
      for(int i = 0; i < valores.size(); i++) {
          float calculo = (valores.get(i) * 100)/sumaTotal;
          float size_portion = map(calculo,0,100,0,360);
          lista_porcentaje.add(size_portion);
      }    
      return lista_porcentaje;
  } 
  
  public void getData(ArrayList<String> lista_etiquetas, ArrayList<Float> lista_valores, float [] valores_reales) {
      this.lista_etiquetas = lista_etiquetas;
      this.lista_valores = lista_valores;
      this.valores_reales = valores_reales;
  }
}
