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
    for (int j = 0; j < dataRows; j++) {
      curveVertex(j + shiftX, initialScale*moveDataArray[sensor][j]);
    }
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
     
    stroke(0);
    String displayData = str(moveDataArray[sensor][abs(shiftX)]);
    fill(255);
    textSize(12);
    text(displayData, PosX+5, PosY-30);

pushMatrix();
translate(0,0);
popMatrix();
 
    /*
    fill(255);
     textSize(20);
     text(sensorName, 20, PosY-20);
     //println(sensorName);
     */
  }
}

