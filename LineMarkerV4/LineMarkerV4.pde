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


void setup() {
  size(displayWidth/2, displayHeight/2, OPENGL);
  smooth();

  initializeMap();  
  //importData();
}


void draw() {
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

  List<Location> sensorLocations = new ArrayList<Location>();
  List<Marker> sensorMarker = new ArrayList<Marker>();

  for (TableRow sensorDataRow : sensorDataCSV.rows ()) {

    //each table row, inside list sensorDaraCSV.rows() 
    float lat = sensorDataRow.getFloat("locationLatitude");
    float lng = sensorDataRow.getFloat("locationLongitude");

    locationData = new Location(lat, lng);
    sensorLocations.add(locationData);

    //println(locationData);
    SimpleLinesMarker m = new SimpleLinesMarker(sensorLocations);

    m.setColor(color(100));
    m.setStrokeWeight(10);
    sensorMarker.add(m);
  }
    sensorDataCSV.clearRows();

  map.panTo(locationData);
  map.addMarkers(sensorMarker);
  
}

