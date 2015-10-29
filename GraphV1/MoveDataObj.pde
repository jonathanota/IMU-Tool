class MoveDataObj {

  int dataColumns, dataRows, sensor; 
  float [][] moveDataArray;

  int accelX = 0;
  int accelY = 1;
  int accelZ = 2;
  int gyroX = 3;
  int gyroY = 4;
  int gyroZ = 5;
  int magX = 6;
  int magY = 7;
  int magZ = 8;

  MoveDataObj( int numColumns, int numRows, int numSensor, 
  float [][] dataArray) {

    dataColumns = numColumns;
    dataRows = numRows;
    moveDataArray = dataArray;
    sensor = numSensor;
  }


  void display(int shiftX, float scaleY, int PosX, int PosY) {

    int initialScale = 20;
    int currentPoint = 0;

    pushMatrix();
    translate(PosX, PosY);

    stroke(255);
    strokeWeight(1);
    line(0, -80, 0, 30);

if (abs(shiftX) > dataRows){
 shiftX = dataRows+1; 
}
    fill(255, 0, 0);
    //  println(initialScale*moveDataArray[sensor][abs(shiftX)]);
    ellipse(0, initialScale*moveDataArray[sensor][abs(shiftX)], 8, 8);

    noFill();
    stroke(255);
    strokeWeight(1);
    beginShape();
    for (int j = 0; j < dataRows; j++) {

      vertex(j + shiftX, initialScale*moveDataArray[sensor][j]);
      //      if (j + shiftX < 0) {
      //        shiftX = 0;
      //      }
    }
    scale(scaleY, 1);
    endShape();
    popMatrix();


    //support shapes
    noStroke();
    rectMode(CENTER);
    fill(100);
    rect(PosX, PosY-10, width, -70);
  }
}

