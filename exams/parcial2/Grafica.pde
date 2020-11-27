/**
 * La siguiente clase permite dibujar una grafica de pastel, aunque a largo plazo esta clase puede
 * escalarse para soportar más tipos de graficas
 */
public class Grafica{
  int [] array_valores;
  PVector posicion;
  PVector posLabels;
  
  public Grafica() {
    this.posicion = new PVector(width/2, height/2 - 50);
    this.posLabels = new PVector(posicion.x - (posicion.x*.5), 25);
  }
  
  public void pieChart(float diameter, Player[] player) {
      array_valores = ajustarValores(new int[]{player[0].partidasGanadas, player[1].partidasGanadas});
      float lastAngle = 0;
      for (int i = 0; i < array_valores.length; i++) {
        float canal_rojo = player[i].rgb_color[0];
        float canal_verde = player[i].rgb_color[1];
        float canal_azul = player[i].rgb_color[2];
        fill(canal_rojo, canal_verde, canal_azul);
        arc(posicion.x, posicion.y, diameter, diameter, lastAngle, lastAngle+radians(array_valores[i]));
        lastAngle += radians(array_valores[i]);
        pushMatrix();
          translate(250, 200);
          textSize(20);
          fill(canal_rojo, canal_verde, canal_azul);
          fill(0);
        popMatrix(); 
      }  
  }
  private int [] ajustarValores(int [] array_valores) {
      //Calcular Suma de valores de la lista
      int sumaTotal = 0;
      for(int i = 0; i < array_valores.length; i++)
         sumaTotal += array_valores[i];   
         
      //Crear una lista que tenga los valores de la lista inicial en porcentaje
      int[] lista_porcentaje = new int[2];
      for(int i = 0; i < array_valores.length; i++) {
          int calculo = (array_valores[i] * 100)/sumaTotal;
          float size_portion = map(calculo,0,100,0,360);
          lista_porcentaje[i] = (int)size_portion;
      }    
      return lista_porcentaje;
  } 
}
