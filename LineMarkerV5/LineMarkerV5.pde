/**
 * Displays the subway lines of Boston, read from a GeoJSON file.
 * 
 * This example shows how to load data features and create markers manually in order to map specific properties; in this
 * case the colors according to the MBTA schema.
 */
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.marker.*;
import java.util.List;


Location locationData;

Location currentLocation = new Location(37.75646384343296f, -122.4212272838898f);

UnfoldingMap map;
DebugDisplay debugDisplay;
List<Location> sensorLocations;
List<Marker> sensorMarker;


float [][] locationDataArray;

void setup() {
  size(displayWidth/2, displayHeight/2, OPENGL);
  smooth();

  initializeMap();  
  importData();
}


void draw() {
  mapDraw();
  map.draw();

}

void initializeMap() {
 // map = new UnfoldingMap(this, new StamenMapProvider());
    map = new UnfoldingMap(this, new Microsoft.RoadProvider());

  map.zoomToLevel(16);
  map.panTo(currentLocation);
  map.setZoomRange(9, 20); // prevent zooming too far out
  map.setPanningRestriction(currentLocation, 50);
  MapUtils.createDefaultEventDispatcher(this, map);
}

void importData() {
  String sensorDataFile = "sensorLog4.csv";
  Table sensorDataCSV = loadTable(sensorDataFile, "header, csv");
  
  int dataColumns = 2;
  int dataRows = sensorDataCSV.getRowCount();
  int iter = 0;

  locationDataArray = new float [dataColumns][dataRows];
  
  sensorLocations = new ArrayList<Location>();
  sensorMarker = new ArrayList<Marker>();

  for (TableRow sensorDataRow : sensorDataCSV.rows ()) {

    //each table row, inside list sensorDaraCSV.rows() 
    float lat = sensorDataRow.getFloat("locationLatitude");
    float lng = sensorDataRow.getFloat("locationLongitude");
    

    locationDataArray[0][iter] = lat;
    locationDataArray[1][iter] = lng;
    
    iter++;
      
  }

  map.panTo(locationData);
  map.addMarkers(sensorMarker);
  
}

void mapDraw(){
      //println(locationDataArray[0][iter]);
    locationData = new Location(locationDataArray[0][iter], locationDataArray[1][iter]);
    
    sensorLocations.add(locationData);

    //println(locationData);
    SimpleLinesMarker m = new SimpleLinesMarker(sensorLocations);

    m.setColor(color(100));
    m.setStrokeWeight(5);
    sensorMarker.add(m);
    
    if (iter < dataRows-1000){
    iter+=1000;  
    }
    
    
    println(iter);
    
}

