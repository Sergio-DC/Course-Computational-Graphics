

public class CRUD_File {
    ListenerUpdatedFile listenerUpdatedFile;
    final String FILE_NAME = "squash.csv";
    final String COL_NAME_1 = "A";
    final String COL_NAME_2 = "B";
    public CRUD_File() {}
    
    public CRUD_File(ListenerUpdatedFile listenerUpdatedFile) {
        this.listenerUpdatedFile = listenerUpdatedFile;
    }
  
    public int[] readFile() {
        Table table;
        table = loadTable(this.FILE_NAME, "header");  
        int juegosGanados_A = -1;
        int juegosGanados_B = -1;
        println(table.getRowCount() + " total rows in table");
        for (TableRow row : table.rows()) {
          juegosGanados_A = row.getInt(this.COL_NAME_1);
          juegosGanados_B = row.getInt(this.COL_NAME_2);
        }
        int [] array_juegos_ganados = new int[2];
        array_juegos_ganados[0] = juegosGanados_A;
        array_juegos_ganados[1] = juegosGanados_B;
        return array_juegos_ganados;
   }
   
   public void updateFile(Player player1, Player player2) {
        Table table = new Table();  
        table.addColumn(this.COL_NAME_1, Table.INT);
        table.addColumn(this.COL_NAME_2, Table.INT);
        
        TableRow newRow = table.addRow();
        newRow.setInt(this.COL_NAME_1, player1.partidasGanadas);
        newRow.setInt(this.COL_NAME_1, player2.partidasGanadas);
        
        saveTable(table, this.FILE_NAME);
   }
    
  public void witeFile(Player player) {
        Table table = new Table();  
        table.addColumn(this.COL_NAME_1);
        table.addColumn(this.COL_NAME_1, Table.INT);
        
        TableRow newRow = table.addRow();
        newRow.setString(this.COL_NAME_1, player.nombre);
        //newRow.setInt(nombre_col2, player.);
        
        saveTable(table, this.FILE_NAME);
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
