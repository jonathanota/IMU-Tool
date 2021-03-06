class MoveDataObj {

  int dataColumns, dataRows, sensor, initialScale; 
  float [][] moveDataArray;
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

  MoveDataObj( String name, int scale, int numColumns, int numRows, int numSensor, 
  float [][] dataArray) {

    dataColumns = numColumns;
    dataRows = numRows;
    moveDataArray = dataArray;
    sensor = numSensor;
    sensorName = name;
    initialScale = scale;
  }


  void display(int shiftX, float scaleY, int PosX, float PosY) {

    int currentPoint = shiftX;
    int shiftXDisplay = 0;


    noStroke();
    rectMode(CENTER);
    fill(25);
    rect(PosX, PosY-10, width, -70);


    pushMatrix();
    translate(PosX, PosY);

    stroke(255);
    strokeWeight(1);
    line(0, -50, 0, 30);
    stroke(255);
    noFill();
    //strokeWeight(1);
    beginShape();

    int onScreenDataBegin = abs(shiftX) - 100;
    if (onScreenDataBegin < 0) { onScreenDataBegin = 0; }
    
    int onScreenDataEnd   = abs(shiftX) + 100;
    if (onScreenDataEnd > dataRows) { onScreenDataEnd = dataRows; }
    
    for (int j = onScreenDataBegin; j < onScreenDataEnd; j++) {
      curveVertex(j + shiftX, initialScale*moveDataArray[sensor][j]);
    }

//    for (int j = 0; j < dataRows; j++) {
//      curveVertex(j + shiftX, initialScale*moveDataArray[sensor][j]);
//    }

    scale(scaleY, 1);
    endShape();
    popMatrix();


    //support shapes  
    pushMatrix();
    translate(PosX, PosY);
    stroke(255, 0, 0);
    strokeWeight(1.5);
    noFill();
    ellipseMode(CENTER);
    ellipse(0, initialScale*moveDataArray[sensor][abs(shiftX)], 8, 8);
    popMatrix();
    
    //rectMode(CENTER);
   // line(mouseX, -10, mouseX, 100);


    stroke(0);
    String displayData = str(moveDataArray[sensor][abs(shiftX)]);
    fill(255);
    textSize(12);
    text(displayData, PosX+5, PosY-30);

    //reset RectMode() for controlP5 bar
    rectMode(CORNER);
    strokeWeight(0);
  }
}

