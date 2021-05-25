//Victoria Emukperuo, moved constants to a new tab to make code clearer, 16:56PM, 15/04/21
import java.util.HashSet;
import java.util.Collections;
import org.gicentre.utils.stat.*;
import org.gicentre.geomap.*;
import java.lang.*;

PFont myFont, myFont2, fontSize;
Screen screenOne; Screen screenTwo; Screen USMapGraph;
HashSet<String> stateList = new HashSet<String>(); 
String[] stateListArray; 
HashSet<String> areaList = new HashSet<String>(); 
String[] areaListArray;
float[] graphCases= new float[55];
float[] areaCases= new float[areaList.size()];
TextWidget focus;
TextWidget focus2;
final int SCREENX = 1400;final int SCREENY = 800;
int id, screen, cases; int borderStroke = 9;
double geoid; 
TableRow row;
String saveStateName, areas, area, date, state, country;
float maxValue=0;
Table table;
data d=new data();
GeoMap geoMap;         //"Karthik, added interactive map of US, 12:30PM, 30/3/21
Info stateInfo;
USmap mapGraph= new USmap();
BarChart barChart;
String saveAreaName;

int cThirty = 0;
int cSixty = 0;
int cNinety = 0;
int thirty;
int sixty;
int ninety;

final int EVENT_BACKWARD=2;
final int EVENT_QUIT=1;
final int TEXT_WIDGET=3;
final int EVENT_NULL=0;
final int TOGGLE = 4;
final int US_MAP_GRAPH = 5;
final int EVENT_30DAYS = 6;
final int EVENT_60DAYS = 7;
final int EVENT_90DAYS = 8;
