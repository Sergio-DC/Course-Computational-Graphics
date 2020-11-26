import java.util.Arrays;
Table table;
String FILE_NAME = "data1.csv";
String [] COLUMN_NAMES = {"A", "B", "C", "D"};
ArrayList ALL_COLUMNS_VALUES = new ArrayList<String>();//Excepto de la primera columna

void setup() {
  size( 600, 500 );
  background( 255 );
  lineChart();
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
  int padding = 50;
  int minDate = min( dataX );
  int maxDate = max( dataX );
  int minX = 0 + padding;
  int maxX = width - padding;
  int minCount = 0;
  int maxCount = max( dataY );
  int minY = height - padding;
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
  int minX = 0 + padding;
  int minY = height - padding;
  int minDate = min( dataX );
  int maxDate = max( dataX );
  
  int maxX = width - padding;
  for(int i =1; i < dataX.length; i++) {
    text(dataX[i], map(i,minDate,maxDate, minX, maxX), minY);
  }
}

void drawParallelLines(int [] lines) {
  int padding = 50;
  int minX = 0 + padding;
  int maxX = width - padding;
  int minY = height - padding;
  int maxY = 0 + padding;
  int minDate = min( lines );
  int maxDate = max( lines );
  stroke(0);
  //Ordenar el array
  Arrays.sort(lines);
  //Quitar elementos repetidos
   removeDuplicates(lines, lines.length);
  for(int i = 0; i < lines.length; i++)
    println(":) " + lines[i]);
    
    println("minDate: ", minDate);
    println("maxDate: ", maxDate);
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
      
      //value += interval;
      //label_text = Float.toString(value);
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
  int padding = 50;
  int maxX = width - padding;
  int minY = height - padding;
  
     textSize(16);
     fill(colors_rgb[0], colors_rgb[1], colors_rgb[2]); 
     text(columnName, maxX * 7/8, minY/2 + (i*25));
     textAlign(LEFT);
     ellipse((maxX * 7/8) - 5, minY/2 + (i*25),5,5);
     
}
