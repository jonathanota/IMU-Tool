class MoveDataObj extends Canvas {

  int dataColumns, dataRows, sensor, shiftX, PosX; 
  float [][] moveDataArray;
  float scaleY, PosY;
  String sensorName;

  int accelX = 0;
  int accelY = 1;
  int accelZ = 2;
  int gyroX = 3;
  int gyroY = 4;
  int gyroZ = 5;
  int magX = 6;
  int magY = 7;
  int magZ = 8;

  MoveDataObj( String name, int numColumns, int numRows, int numSensor, 
  float [][] dataArray, int ShiftX, float ScaleY, int posX, float posY) {

    dataColumns = numColumns;
    dataRows = numRows;
    moveDataArray = dataArray;
    sensor = numSensor;
    sensorName = name;
    shiftX = ShiftX;
    scaleY = ScaleY;
    PosX = posX;
    PosY = posY;
  }

void draw(PApplet P){
  
  display(shiftX, scaleY, PosX, PosY, P);
}

  void display(int shiftx, float scaley, int Posx, float Posy, PApplet d) {

    int initialScale = 20;
    int currentPoint = shiftX;


    d.noStroke();
    d.rectMode(CENTER);
    d.fill(25);
    d.rect(PosX, PosY-10, width, -70);


    d.pushMatrix();
    d.translate(PosX, PosY);

    d.stroke(255);
    d.strokeWeight(1);
    d.line(0, -80, 0, 30);

    d.noFill();
    d.stroke(255);
    //strokeWeight(1);
    beginShape();
    for (int j = 0; j < dataRows; j++) {
      d.vertex(j + shiftX, initialScale*moveDataArray[sensor][j]);
    }
    d.scale(scaleY, 1);
    d.endShape();
    d.popMatrix();

 //support shapes

    
    d.pushMatrix();
    d.translate(PosX, PosY);
    d.stroke(255, 0, 0);
    d.strokeWeight(1.5);
    d.noFill();
    d.ellipse(0, initialScale*moveDataArray[sensor][abs(shiftX)], 8, 8);
    d.popMatrix();

    
    String displayData = str(moveDataArray[sensor][abs(shiftX)]);
    d.fill(255);
    d.textSize(12);
    d.text(displayData, PosX+5, PosY-30);

    
    d.fill(255);
    d.textSize(20);
    d.text(sensorName, 20, PosY-20);
    //println(sensorName);
  }
}

