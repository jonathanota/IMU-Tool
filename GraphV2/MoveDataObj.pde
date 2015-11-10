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

  void setup(PApplet d) {
  }

  void draw(PApplet d) {

    display(shiftX, scaleY, PosX, PosY);
   
  }

  void display(int shiftx, float scaley, int Posx, float Posy) {

    int initialScale = 20;
    int currentPoint = shiftX;


    noStroke();
    rectMode(CENTER);
    fill(25);
    rect(PosX, PosY-10, width, -70);


    pushMatrix();
    translate(width/2, 0);

    stroke(255);
    strokeWeight(1);
    line(0, -80, 0, 30);

    noFill();
    stroke(255);
    //strokeWeight(1);
    beginShape();
    for (int j = 0; j < dataRows; j++) {
      vertex(j + shiftX, initialScale*moveDataArray[sensor][j]);
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
    ellipse(0, initialScale*moveDataArray[sensor][abs(shiftX)], 8, 8);
    popMatrix();


    String displayData = str(moveDataArray[sensor][abs(shiftX)]);
    fill(255);
    textSize(12);
    text(displayData, PosX+5, PosY-30);

/*
    fill(255);
    textSize(20);
    text(sensorName, 20, PosY-20);
    //println(sensorName);
    */
  }
}

