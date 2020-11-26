import java.util.Collections;

ArrayList<String> etiquetas;
ArrayList<Float> valores; 
float ANCHO_BAR = 20;//Base o ancho de la barra
float PUNTO_ORIGEN_BARRAS_X = width*4;
String NOMBRE_ARCHIVO = "data.csv";
import java.util.Arrays;
Table table;
String FILE_NAME = "data1.csv";
String [] COLUMN_NAMES = {"A", "B", "C", "D"};
int padding = 50;


void setup() {
   size(1200,800); 
   etiquetas = new ArrayList();
   valores = new ArrayList();
   valores = readFile(etiquetas, valores, "Guitarrista", "Ranking"); //<>//
   
   noLoop();
}

void draw() {
   background(255);

   pushMatrix();
   translate(-50,height/2);
   generateBarChart();
   popMatrix();
   
   pushMatrix();
   translate(450,-100);
   pieChart(300, etiquetas, valores);
   popMatrix();
   
   lineChart();
}

public void generateBarChart() {
   float pasos_avanzados = 0;//guarda el estado del paso o posición en el que se encuentra una 'barra' o un 'espacio_entre_barra'
   float largoBarNegativo = getMaxNegativeVal();
   float pos_linea_adorno = ANCHO_BAR + (ANCHO_BAR * .25);
   for(int i=0; i<valores.size(); i++) {
     float largoBar = valores.get(i);//largo de la barra     
     //Barra
     fill(0,255,0);
     rect(PUNTO_ORIGEN_BARRAS_X,ANCHO_BAR * pasos_avanzados, largoBar, ANCHO_BAR);
     pasos_avanzados += 1;//Distancia entre el inicio y fin de una barra 
     //Etiqueta de Categoria
     pushMatrix();
     //! Si la palabra tiene 4 letras coloca 50 unidades
     textAlign(RIGHT);
     translate(largoBarNegativo - 80,0);//El texto se ajusta a la izquiera del inicio de las barras
     fill(0, 102, 153);
     textSize(ANCHO_BAR * 3/4);
     text(etiquetas.get(i), PUNTO_ORIGEN_BARRAS_X, ANCHO_BAR * pasos_avanzados);
     popMatrix();
     //Etiqueta o valor de la barra
     pushMatrix();
     if(largoBar < 0) {
       textAlign(RIGHT);
       translate(largoBar, 0);//El número o valor se posiciona a la izquierda de la barra
     } else {
       textAlign(LEFT);
       translate(largoBar, 0);//El número o valor se posiciona a la derecha de la barra
     }
     fill(0, 102, 153);
     textSize(ANCHO_BAR * 3/4);
     text(largoBar, PUNTO_ORIGEN_BARRAS_X, ANCHO_BAR * pasos_avanzados);
     popMatrix();
     //Espacio entre la barra
     fill(255);
     rect(PUNTO_ORIGEN_BARRAS_X, ANCHO_BAR * pasos_avanzados, largoBar, ANCHO_BAR/2);
     //Linea de adorno en el espacio
     stroke(2);
     genDottedLine(150, pos_linea_adorno);
     pos_linea_adorno += 30;
     noStroke();
     pasos_avanzados += .5;//Distancia entre el inicio y fin de un espacio entre cada barra
   }
   
   //Linea Base 0
   stroke(1);
   line(PUNTO_ORIGEN_BARRAS_X,valores.size() * 31,PUNTO_ORIGEN_BARRAS_X,0);
   fill(0, 102, 153);
   text("0", PUNTO_ORIGEN_BARRAS_X - 5, valores.size() * 33);
}

void pieChart(float diameter, ArrayList<String> lista_etiquetas, ArrayList<Float> lista_valores) {
  lista_valores = ajustarValores(lista_valores);
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
      translate(250, 200);
      textSize(20);
      fill(canal_rojo, canal_verde, canal_azul);
      ellipse(0, y*i,10,10);
      fill(0);
      text(info,10, y * i);
    popMatrix(); 
  }  
}

public float getMaxNegativeVal() { //<>//
   float minVal = 0;
   for(int i = 0; i < valores.size(); i++)    
      if(valores.get(i) < minVal) 
          minVal = valores.get(i);
   return minVal;
}

public void genDottedLine(float x, float y) {
   for(int i = 10; i<width/2; i+=10){
      ellipse (x + i,y,1,1);  
   } 
}

//Lee un archivo csv(2 columnas con varios registros)
//Y separa los valores de cada columna en 2 ArrayList
public ArrayList<Float> readFile(ArrayList<String> lista_etiqueta, ArrayList<Float> lista_valores, String nombre_col1, String nombre_col2) {
  Table table;
  table = loadTable(NOMBRE_ARCHIVO, "header");

  println(table.getRowCount() + " total rows in table");
  
  for (TableRow row : table.rows()) {
    lista_etiqueta.add(row.getString(nombre_col1));
    lista_valores.add(row.getFloat(nombre_col2));
    Collections.sort(lista_valores, Collections.reverseOrder());
  }
  
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
        float calculo = (valores.get(i) * 100)/sumaTotal;
        float size_portion = map(calculo,0,100,0,360);
        println(calculo);
        lista_porcentaje.add(size_portion);
    }    
    return lista_porcentaje;
}

void lineChart() {
  table = loadTable(FILE_NAME, "header");
  int[] dataX = new int[ table.getRowCount() ];
  int[] dataY = null;
  
  for ( int i = 0; i < table.getRowCount(); i++ )
    dataX[i] = table.getInt( i, "date" );

  int [] old_dataY = null;
  for(int i = 0; i < COLUMN_NAMES.length; i++) {
    dataY = getDataForColumn(COLUMN_NAMES[i], table);
    if(i > 0)// Unimos el array anterior con el actual
      dataY = joinTwoArrays(old_dataY, dataY);
    float rojo = random(256), verde = random(256), azul =random(256);
    drawLine(dataX, dataY, COLUMN_NAMES[i],
          new float[] {rojo, verde, azul});//Traza una linea de tendencia
    drawLabels(COLUMN_NAMES[i], new float[] {rojo, verde, azul}, i);
    old_dataY = new int[dataY.length];//array auxiliar que guarda los datos anteriores
    System.arraycopy(dataY, 0, old_dataY, 0, dataY.length); 
  }
  
  drawParallelLines(dataY);
  drawX_AxisData(dataX);
}
/** 
 *  Obtiene la lista de datos de una columna de un archivo CSV
 *  @param col_name{String} nombre de la columna dentro del archivo CSV
 *  @param table{String} representación de una matriz del archivo CSV
 *  @return int[] valores de las celdas asociadas a la columna seleccionada
 **/
int[] getDataForColumn(String col_name, Table table) {
  int[] dataY = new int[ table.getRowCount() ];
   for ( int i = 0; i < table.getRowCount(); i++ ) {
     //ALL_COLUMNS_VALUES.add(table.getInt( i, col_name ));
     dataY[ i ] = table.getInt( i, col_name );
  }
  return dataY;
}

void drawLine(int[] dataX, int[] dataY, String column_name, float [] color_rgb) {
  int padding = 0;
  int minDate = min( dataX );
  int maxDate = max( dataX );
  int minX = 100 + padding;
  int maxX = width/2 - padding;
  int minCount = 0;
  int maxCount = max( dataY );
  int minY = 300 - padding;
  int maxY = 0 + padding;
  
  stroke(color_rgb[0], color_rgb[1], color_rgb[2]);
  for ( int i = 1; i < table.getRowCount(); i++ ) {
    int oldDate = table.getInt( i - 1, "date" );
    int newDate = table.getInt( i, "date" );
    int oldCount = table.getInt( i - 1, column_name);
    int newCount = table.getInt( i, column_name );
    
    line(
      map( oldDate, minDate, maxDate, minX, maxX ),
      map( oldCount, minCount, maxCount, minY, maxY ),
      map( newDate, minDate, maxDate, minX, maxX ),
      map( newCount, minCount, maxCount, minY, maxY )
    );
  }
}

void drawX_AxisData(int[] dataX) {
  int padding = 50;
  int minX = 100 + padding;
  int minY = height - padding;
  int minDate = min( dataX );
  int maxDate = max( dataX );
  
  int maxX = width - padding;
  for(int i =1; i < dataX.length; i++) {
    text(dataX[i], map(i,minDate,maxDate, minX, maxX), minY);
  }
}

void drawParallelLines(int [] lines) {
  int padding = 0;
  int minX = 100 + padding;
  int maxX = width/2 - padding;
  int minY = 0 - padding;
  int maxY = height/2 + padding;
  int minDate = min( lines );
  int maxDate = max( lines );
  stroke(0);
  //Ordenar el array
  Arrays.sort(lines);
  //Quitar elementos repetidos
   removeDuplicates(lines, lines.length);
   
  for(int i = 0; i < 7; i++) {
     line(minX, 
       map(i, minDate, maxDate, minY, maxY),
       maxX, 
       map(i, minDate, maxDate, minY, maxY)
     );
     
      textAlign(RIGHT);
      textSize(16);
      fill(0, 102, 153);      
      text(lines[i], minX, map(i, 0, lines.length/2, minY, maxY));
  }
}


int removeDuplicates(int arr[], int n) 
{  
        if (n==0 || n==1) 
            return n; 
       
        int[] temp = new int[n]; 
          
        // Start traversing elements 
        int j = 0; 
        for (int i=0; i<n-1; i++) 
            // If current element is not equal 
            // to next element then store that 
            // current element 
            if (arr[i] != arr[i+1]) 
                temp[j++] = arr[i]; 
          
        // Store the last element as whether 
        // it is unique or repeated, it hasn't 
        // stored previously 
        temp[j++] = arr[n-1];             
        // Modify original array 
        for (int i=0; i<j; i++) 
            arr[i] = temp[i]; 
       
        return j; 
} 


/**
 * Une dos arrays de tipo primitivo INT y lo devuelve en un nuevo array
 * @param first[] array que se encuentra lo más posible al extremo izquierdo
 * @para second[] array que se encuentra lo más posible al extremo derecho
 * @return int[] contiene los elementos del primer y segundo array
 **/
int [] joinTwoArrays(int [] first, int [] second) {
    int[] both = Arrays.copyOf(first, first.length + second.length);
    System.arraycopy(second, 0, both, first.length, second.length);
    return both;
}

void drawLabels(String columnName, float colors_rgb[], int i) {
    int minY = height/2 - padding;
    int maxY = 0 + padding;
    int minX = 100 + padding;
  int maxX = width/2 - padding;
  
     textSize(16);
     fill(colors_rgb[0], colors_rgb[1], colors_rgb[2]); 
     text(columnName, maxX * 7/8, minY/2 + (i*25));
     textAlign(LEFT);
     ellipse((maxX * 7/8) - 5, minY/2 + (i*25),5,5);
     
}
