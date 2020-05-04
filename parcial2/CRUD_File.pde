

public class CRUD_File {
    ListenerUpdatedFile listenerUpdatedFile;
    public CRUD_File() {}
    
    public CRUD_File(ListenerUpdatedFile listenerUpdatedFile) {
        this.listenerUpdatedFile = listenerUpdatedFile;
    }
  
    public int[] readFile(String nombre_col1, String nombre_col2, String fileName) {
        Table table;
        table = loadTable(fileName, "header");  
        int juegosGanados_A = -1;
        int juegosGanados_B = -1;
        println(table.getRowCount() + " total rows in table");
        for (TableRow row : table.rows()) {
          juegosGanados_A = row.getInt(nombre_col1);
          println("ganA: " + juegosGanados_A);
          juegosGanados_B = row.getInt(nombre_col2);
          println("ganB: " + juegosGanados_B);
        }
        int [] array_juegos_ganados = new int[2];
        array_juegos_ganados[0] = juegosGanados_A;
        array_juegos_ganados[1] = juegosGanados_B;
        return array_juegos_ganados;
   }
    
  public void witeFile(String nombre_col1, String nombre_col2,String fileName, Player player) {
        Table table = new Table();  
        table.addColumn(nombre_col1);
        table.addColumn(nombre_col2, Table.INT);
        
        TableRow newRow = table.addRow();
        newRow.setString(nombre_col1, player.nombre);
        //newRow.setInt(nombre_col2, player.);
        
        saveTable(table, fileName);
  }
  
  /*public CRUD_File getInstance() {
      if(this == null)
          return new CRUD_File();
      else
        return this;
  }*/
  
}

public interface ListenerUpdatedFile {
    public void getData(ArrayList<String> lista_etiquetas, ArrayList<Float> lista_valores, float [] valores_reales);
}
