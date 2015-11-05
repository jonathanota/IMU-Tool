class MoveDataObj {

  int dataColumns, dataRows, sensor; 
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

  MoveDataObj( String name, int numColumns, int numRows, int numSensor, 
  float [][] dataArray) {

    dataColumns = numColumns;
    dataRows = numRows;
    moveDataArray = dataArray;
    sensor = numSensor;
    sensorName = name;
  }


  void display(int shiftX, float scaleY, int PosX, float PosY) {

    int initialScale = 20;
    int currentPoint = shiftX;

    pushMatrix();
    translate(PosX, PosY);

    stroke(255);
    strokeWeight(1);
    line(0, -80, 0, 30);

    fill(255, 0, 0);
    //  println(initialScale*moveDataArray[sensor][abs(shiftX)]);
    ellipse(0, initialScale*moveDataArray[sensor][abs(shiftX)], 8, 8);
    
    String displayData = str(moveDataArray[sensor][abs(shiftX)]);
    fill(255);
    textSize(12);
    text(displayData, 0, 0);

    noFill();
    stroke(255);
    strokeWeight(1);
    beginShape();
    for (int j = 0; j < dataRows; j++) {
      vertex(j + shiftX, initialScale*moveDataArray[sensor][j]);
    }
    scale(scaleY, 1);
    endShape();
    popMatrix();


    //support shapes
    noStroke();
    rectMode(CENTER);
    fill(100);
    rect(PosX, PosY-10, width, -70);
    fill(255);
    textSize(20);
    text(sensorName, width/2, 70);
    println(sensorName);
  }
}

