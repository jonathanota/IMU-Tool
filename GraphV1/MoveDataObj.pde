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


  void display(float shiftX, float scaleY, int PosX, int PosY) {

    pushMatrix();
    translate(PosX, PosY);
    stroke(255);
    strokeWeight(1);
    line(0, -80, 0, 30);
    strokeWeight(1);
    noFill();
    stroke(255);
    beginShape();
    for (int j = 0; j < dataRows; j++) {
      // vertex(j*scaleX, scaleY*moveDataArray[sensor][j]);
      vertex(j + shiftX, 20*moveDataArray[sensor][j]);
    }
    scale(scaleY, 1);
    endShape();
    popMatrix();
   
    fill(100);
    noStroke();
    rectMode(CENTER);
    rect(PosX, PosY-10, width, -70);
  }
}

