import java.util.List;

float [][] moveDataArray;
int dataColumns, dataRows;
float scaleY;
int shiftX, PosX, PosY;

MoveDataObj motionAccelX, motionAccelY, motionAccelZ;

int accelX = 0;
int accelY = 1;
int accelZ = 2;
int gyroX = 3;
int gyroY = 4;
int gyroZ = 5;
int magX = 6;
int magY = 7;
int magZ = 8;

void setup() {
  size(displayWidth/2, displayHeight/2, OPENGL);
  smooth();
  background(0);

  importData();

  //Pass Data array into movement data object
  motionAccelX = new MoveDataObj("AccelX", dataColumns, dataRows, accelX, moveDataArray);
  motionAccelY = new MoveDataObj("AccelY", dataColumns, dataRows, accelY, moveDataArray);
  motionAccelZ = new MoveDataObj("AccelZ", dataColumns, dataRows, accelZ, moveDataArray);
  
}


void draw() {
  smooth();
  background(0);
 
  //motion...display(graph x location, graph scaling, x location, y location)
  motionAccelX.display(shiftX, scaleY, width/2, height/1.1-75-75);
  motionAccelY.display(shiftX, scaleY, width/2, height/1.1-75);
  motionAccelZ.display(shiftX, scaleY, width/2, height/1.1);
}

void importData() {

  //This method takes data from the Table and puts them into an array
  String sensorDataFile = "sensorLog2.csv";
  Table sensorDataCSV = loadTable(sensorDataFile, "header, csv");

  //set # of columns we're reading from
  dataColumns = 9;
  dataRows = sensorDataCSV.getRowCount();
  moveDataArray = new float [dataColumns][dataRows];

  //Setup graph
  shiftX = 1;
  scaleY = width/float(dataRows);
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

    iter++;
  }
  
  
}

void moveData() {
}

void keyPressed() {


  if (key == CODED) {
    if (keyCode == LEFT && shiftX <= 0 ) {
      shiftX+= 1;
    } else if (keyCode == RIGHT && shiftX > -dataRows+1 ) {
      shiftX-= 1;
    } else if (keyCode == UP) {
      scaleY += .1;
    } else if (keyCode == DOWN) {
      scaleY -= .1;
    } else if (keyCode == CONTROL){
     shiftX = -dataRows+1; 
    }
    else {
      scaleY = width/float(dataRows);
      shiftX = 0;
    }
  }
}

