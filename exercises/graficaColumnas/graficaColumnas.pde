Table table;

void setup() {
  size(900,800);
  background(255);
  noLoop();
  }
  
void draw()
{
  doubleBarChart();
}

void doubleBarChart()
{
  //table = loadTable("data2.csv", "header");

  //println(table.getRowCount() + " total rows in table");

  //for (TableRow row : table.rows()) {

    //String recuperados = row.getString("recuperados");
    /*int n1 = row.getInt("11");
    int n2 = row.getInt("12");
    int n3 = row.getInt("13");
    int n4 = row.getInt("14");
    int n5 = row.getInt("15");
    int n6 = row.getInt("16");
    int n7 = row.getInt("17");*/
    
    fill(255);
    textSize(40);
    text("RECUPERADOS (EUA vs MEXICO)",width * .2 , height * .1 );
    fill(0);
    textSize(20);
    text("600",width*.1, height * .2);
    line(width*.2, height*.2, width*.9,height*.2);
    text("500",width*.1, height * .3);
    line(width*.2, height*.3, width*.9,height*.3);
    text("400",width*.1, height * .4);
    line(width*.2, height*.4, width*.9,height*.4);
    text("300",width*.1, height * .5);
    line(width*.2, height*.5, width*.9,height*.5);
    text("200",width*.1, height * .6);
    line(width*.2, height*.6, width*.9,height*.6);
    text("100",width*.1, height * .7);
    line(width*.2, height*.7, width*.9,height*.7);
    text("0",width*.1, height * .8);
    line(width*.2, height*.8, width*.9,height*.8);
    textSize(50);
    fill(#22ED23);
    text("EUA",width*.3, height*.9);
    fill(#2479ED);
    text("MEXICO",width*.5, height*.9);
    
    textSize(20);
    fill(0);
    text("11",width*.25,height*.83);
    text("12",width*.35,height*.83);
    text("13",width*.45,height*.83);
    text("14",width*.55,height*.83);
    text("15",width*.65,height*.83);
    text("16",width*.75,height*.83);
    text("17",width*.85,height*.83);
    

    float posX = width*.22;
    float posY = height*.8;
    float dif = 120;
    fill(0,0,255);
    rect(posX,posY,40,-map(8,0,600,0,700));
    rect(posX+dif,posY,40,-map(21,0,600,0,700));
    rect(posX+2*dif,posY,40,-map(30,0,600,0,700));
    rect(posX+3*dif,posY,40,-map(90,0,600,0,700));
    rect(posX+4*dif,posY,40,-map(187,0,600,0,700));
    rect(posX+5*dif,posY,40,-map(294,0,600,0,700));
    rect(posX+6*dif,posY,40,-map(482,0,600,0,700));
    
    fill(255,0,0);
    posX += 45;
    rect(posX,posY,40,-map(4,0,600,0,700));
    rect(posX+dif,posY,40,-map(19,0,600,0,700));
    rect(posX+2*dif,posY,40,-map(35,0,600,0,700));
    rect(posX+3*dif,posY,40,-map(37,0,600,0,700));
    rect(posX+4*dif,posY,40,-map(68,0,600,0,700));
    rect(posX+5*dif,posY,40,-map(89,0,600,0,700));
    rect(posX+6*dif,posY,40,-map(103,0,600,0,700));
    //rect(width*.2,height*.8,30,-123.6);
    
    
    
//}
}
