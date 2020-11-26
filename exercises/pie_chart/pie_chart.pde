ArrayList<String> etiquetas; 
ArrayList<Float> valores;

void setup() {
  size(640, 360);
  etiquetas = new ArrayList();
  valores = new ArrayList();
  valores = readFile(etiquetas, valores, "Guitarrista", "Ranking");
  background(100);
  for(Float item: valores)
      println("Item: " + item);
  pieChart(300, etiquetas, valores);
}
void pieChart(float diameter, ArrayList<String> lista_etiquetas, ArrayList<Float> lista_valores) {
  float lastAngle = 0;
  for (int i = 0; i < lista_valores.size(); i++) {
    float canal_rojo = random(256);
    float canal_verde = random(256);
    float canal_azul = random(256);
    fill(canal_rojo, canal_verde, canal_azul);
    arc(width/2, height/2, diameter, diameter, lastAngle, lastAngle+radians(lista_valores.get(i)));
    lastAngle += radians(lista_valores.get(i));
    String info = lista_etiquetas.get(i)+" "+lista_valores.get(i);
    float y = 25;
    pushMatrix();
      translate(15, 75);
      textSize(20);
      fill(canal_rojo, canal_verde, canal_azul);
      ellipse(0, y*i,10,10);
      fill(255);
      text(info,10, y * i);
    popMatrix(); 
  }  
}

//Lee un archivo csv(2 columnas con varios registros)
//Y separa los valores de cada columna en 2 ArrayList
public ArrayList<Float> readFile(ArrayList<String> lista_etiqueta, ArrayList<Float> lista_valores, String nombre_col1, String nombre_col2) {
  Table table;
  table = loadTable("data.csv", "header");

  println(table.getRowCount() + " total rows in table");
  
  for (TableRow row : table.rows()) {
    lista_etiqueta.add(row.getString(nombre_col1));
    java.util.Collections.sort(lista_etiqueta);
    lista_valores.add(row.getFloat(nombre_col2));
    java.util.Collections.sort(lista_valores);
  }
  lista_valores = ajustarValores(lista_valores);
  for(int i = 0; i < lista_valores.size(); i++)
       println("val: " + lista_valores.get(i));
   return lista_valores;  
}

public ArrayList<Float> ajustarValores(ArrayList<Float> valores) {
    //Calcular Suma de valores de la lista
    float sumaTotal = 0;
    for(int i = 0; i < valores.size(); i++)
       sumaTotal += valores.get(i);   
       
    //Crear una lista que tenga los valores de la lista inicial en porcentaje
    ArrayList<Float> lista_porcentaje = new ArrayList();
    for(int i = 0; i < valores.size(); i++) {
        float calculo = map(valores.get(i), 0, 100, 0, 360);
        println(calculo);
        lista_porcentaje.add(calculo);
    }    
    return lista_porcentaje;
}
