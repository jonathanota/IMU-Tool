import java.util.List;
import controlP5.*;
import g4p_controls.*;

GWindow[] window;
int windowNum = 3;

ControlP5 cp5;

Accordion dataAccordion;

float [][] moveDataArray;
String [][] timeLog;
int dataColumns, dataRows;
float scaleY;
int shiftX, PosX, PosY;

MoveDataObj 
motionAccelX, motionAccelY, motionAccelZ, 
motionGyroX, motionGyroY, motionGyroZ;

int accelX = 0;
int accelY = 1;
int accelZ = 2;
int gyroX = 3;
int gyroY = 4;
int gyroZ = 5;
int magX = 6;
int magY = 7;
int magZ = 8;
int time = 9;

int timeHour, timeMin, timeSec, timeMilli;
long currentTime, prevTime, timeDifference;

void setup() {
  size(displayWidth-100, displayHeight-100, "processing.core.PGraphicsRetina2D");
  hint(ENABLE_RETINA_PIXELS);
  smooth();
  background(0);

  importData();

  //Pass Data array into movement data object
  /*Accelerometer Object */
  motionAccelX = new MoveDataObj("AccelX", 20, dataColumns, dataRows, accelX, moveDataArray);
  motionAccelY = new MoveDataObj("AccelY", 20, dataColumns, dataRows, accelY, moveDataArray);
  motionAccelZ = new MoveDataObj("AccelZ", 20, dataColumns, dataRows, accelZ, moveDataArray);

  /*Gyroscope Object */
  motionGyroX = new MoveDataObj("GyroX", 10, dataColumns, dataRows, gyroX, moveDataArray);
  motionGyroY = new MoveDataObj("GyroY", 10, dataColumns, dataRows, gyroY, moveDataArray);
  motionGyroZ = new MoveDataObj("GyroZ", 10, dataColumns, dataRows, gyroZ, moveDataArray);

  setupGUI();
  //createWindows();
}


void draw() {
  background(0);
  smooth();

  timeStamp();

  //motion...display(graph x location, graph scaling, x location, y location)
  /*
  motionAccelX.display(shiftX, scaleY, width/2, height/1.1-75-75);
   motionAccelY.display(shiftX, scaleY, width/2, height/1.1-75);
   motionAccelZ.display(shiftX, scaleY, width/2, height/1.1);
   */
  // println(frameRate);
  //println(scaleY);
  
}

void timeStamp() {

  String timeStampText = timeLog[0][abs(shiftX)];
  fill(255);
  textSize(18);
  text(timeStampText, 30, height-50);
  // println(timeStampText.substring(11));

  timeHour = int(timeStampText.substring(11, 13));
  timeMin = int(timeStampText.substring(14, 16));
  timeSec = int(timeStampText.substring(17, 19));
  timeMilli = int(timeStampText.substring(20));

  println( timeHour + ":" + timeMin + ":" + timeSec + ":" + timeMilli);

  //convert time of day into millis
  currentTime = (timeHour*3600)*1000 + (timeMin*60)*1000 + (timeSec)*1000 + timeMilli;
  
  //do a bit of math to figure out time in millis since program started running
  timeDifference = currentTime - prevTime;
  println(timeDifference);
}

void createWindows(){
 
 window = new GWindow[windowNum];
 
 
 
 window[0] = new GWindow(this, "Graphs", 300, 200, displayWidth - 100, 
 displayHeight - 100, false, "processing.core.PGraphicsRetina2D");
 window[0].addData(new WinMovieData());
 window[0].addDrawHandler(this, "WinMovieDraw");
 window[0].addMouseHandler(this, "WinMovieMouse");
 
 for (int i = 0; i < windowNum; i++)
 {
   window[i].setBackground(0);
 }
  
}

void syncTime() {

  String initialTime = timeLog[0][0];
  long initTimeHour, initTimeMin, initTimeSec, initTimeMillis;

  initTimeHour = int(initialTime.substring(11, 13));
  initTimeMin = int(initialTime.substring(14, 16));
  initTimeSec = int(initialTime.substring(17, 19));
  initTimeMillis = int(initialTime.substring(20));

  //first time reading.
  prevTime = (initTimeHour*3600)*1000 + (initTimeMin*60)*1000 + (initTimeSec)*1000 + initTimeMillis;
  println(prevTime);
}


void setupGUI() {

  /* ControlP5 setup */
  cp5 = new ControlP5(this);

  /*--------------- ACCELEROMETER DATA----------------- */

  Group AccelX = cp5.addGroup("Accel X")
    .setLabel("Accelerometer X")
      .setWidth(200)
        ;      

  AccelX.addDrawable(new CDrawable() {
    public void draw(PApplet p) {
      motionAccelX.display(shiftX, scaleY, width/2, 45);
    }
  }
  );

  Group AccelY = cp5.addGroup("Accel Y")
    .setLabel("Accelerometer Y")
      .setWidth(200)
        ;

  AccelY.addDrawable(new CDrawable() {
    public void draw(PApplet p) {
      motionAccelY.display(shiftX, scaleY, width/2, 45);
    }
  }
  );

  Group AccelZ = cp5.addGroup("Accel Z")
    .setLabel("Accelerometer Z")
      .setWidth(200)
        ;

  AccelZ.addDrawable(new CDrawable() {
    public void draw(PApplet p) {
      motionAccelZ.display(shiftX, scaleY, width/2, 45);
    }
  }
  );


  /*-----------GYROSCOPE DATA----------------- */

  Group GyroX = cp5.addGroup("Gyro X")
    .setLabel("Gyroscope X")
      .setWidth(200)
        ;      

  GyroX.addDrawable(new CDrawable() {
    public void draw(PApplet p) {
      motionGyroX.display(shiftX, scaleY, width/2, 45);
    }
  }
  );

  Group GyroY = cp5.addGroup("Gyro Y")
    .setLabel("Gyroscope Y")
      .setWidth(200)
        ;

  GyroY.addDrawable(new CDrawable() {
    public void draw(PApplet p) {
      motionGyroY.display(shiftX, scaleY, width/2, 45);
    }
  }
  );

  Group GyroZ = cp5.addGroup("Gyro Z")
    .setLabel("Gyroscope Z")
      .setWidth(200)
        ;

  GyroZ.addDrawable(new CDrawable() {
    public void draw(PApplet p) {
      motionGyroZ.display(shiftX, scaleY, width/2, 45);
    }
  }
  );

  dataAccordion = cp5.addAccordion("Sensor Stack")
    .setPosition(5, 5)
      .setWidth(200)
        .addItem(AccelX)
          .addItem(AccelY)
            .addItem(AccelZ)
              .addItem(GyroX)
                .addItem(GyroY)
                  .addItem(GyroZ)
                    .setItemHeight(70)
                      ;

  dataAccordion.setMinItemHeight(50);
  dataAccordion.setCollapseMode(Accordion.MULTI);
}

void importData() {

  //This method takes data from the Table and puts them into an array
  String sensorDataFile = "sensorLog3.csv";
  Table sensorDataCSV = loadTable(sensorDataFile, "header, csv");

  //set # of columns we're reading from
  dataColumns = 9;
  dataRows = sensorDataCSV.getRowCount();
  moveDataArray = new float [dataColumns][dataRows];
  timeLog = new String [1][dataRows];

  //Setup graph
  shiftX = 1;
  //scaleY = width/float(dataRows);
  scaleY = 5;
  PosX = width/2;
  PosY = height;


  //actual row value is +2
  int iter = 0;

  for (TableRow sensorDataRow : sensorDataCSV.rows ()) {

    //println(iter);
    //each table row, inside list sensorDaraCSV.rows() 
    float lat = sensorDataRow.getFloat("locationLatitude");
    float lng = sensorDataRow.getFloat("locationLongitude");

    moveDataArray [accelX][iter] = sensorDataRow.getFloat("accelerometerAccelerationX");
    moveDataArray [accelY][iter] = sensorDataRow.getFloat("accelerometerAccelerationY");
    moveDataArray [accelZ][iter] = sensorDataRow.getFloat("accelerometerAccelerationZ");
    moveDataArray [gyroX][iter] = sensorDataRow.getFloat("gyroRotationX");
    moveDataArray [gyroY][iter] = sensorDataRow.getFloat("gyroRotationY");
    moveDataArray [gyroZ][iter] = sensorDataRow.getFloat("gyroRotationZ");
    moveDataArray [magX][iter] = sensorDataRow.getFloat("locationHeadingX");
    moveDataArray [magY][iter] = sensorDataRow.getFloat("locationHeadingY");
    moveDataArray [magZ][iter] = sensorDataRow.getFloat("locationHeadingZ");

    timeLog [0][iter] = sensorDataRow.getString("loggingTime");

    /* -- some kind of loading animation for large table creation -- */
    //loadScreen(iter);

    iter++;
  }

  //set origin for syncing with video
  syncTime();

  sensorDataCSV.clearRows();
}



void loadScreen(int scan) {

  background(0);
  fill(map(scan, 0, dataRows, 0, 255));
  rect(width/2-25, height/2, 50, 50);
  fill(255);
  text(map(scan, 0, dataRows, 0, 100) + "%", width/2-25, height/2 + 75);
}

void keyPressed() {


  if (key == CODED) {
    if (keyCode == LEFT && shiftX <= 0 ) {
      shiftX+= 1;
    } else if (keyCode == RIGHT && shiftX > -dataRows+1 ) {
      shiftX-= 1;
    } else if (keyCode == UP) {
      scaleY += .05;
    } else if (keyCode == DOWN) {
      scaleY -= .05;
    } else if (keyCode == CONTROL) {
      shiftX = -dataRows+1;
    } else {
      scaleY = width/float(dataRows);
      shiftX = 0;
    }
  }
  if (key == 'o') {
    dataAccordion.open(0, 1, 2, 3, 4, 5);
  } else if (key == 'c') {
    dataAccordion.close(0, 1, 2, 3, 4, 5);
  }
}

class WinMovieData extends GWinData{
  
}

