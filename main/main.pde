//"Karthik Venkatesh Nagaraj, completed week 8 task (reading data from dataset), 7PM, 23/3/2021"
//Niall, added multiple screens, made US clickable, 6PM, 31/3/21
// Victoria, changed the overall display of the program, resized and redesigned widgets and buttons, 4PM, 21/04/21

void settings() {
  size(SCREENX, SCREENY);
}
void setup() {
  table=loadTable("cases-97k.csv", "header");
  myFont2 = loadFont("DINCondensed-Bold-28.vlw");
  myFont = loadFont("ProcessingSansPro-Semibold-28.vlw");
  
  geoMap = new GeoMap(50, 120, 3500, 950, this);  // Create the geoMap object.
  geoMap.readFile("cb_2018_us_state_500k");   // Read shapefile.

  screenOne = new Screen(color(181, 211, 231)); 
  screenTwo = new Screen(color(181, 211, 231));
  USMapGraph = new Screen(color(181, 211, 231));
  screen = 1;

  //karthik venkatesh, adjusted size of text-widget to fit screen, 1:45PM, 12/02/21
  TextWidget textEdit=new TextWidget(SCREENX - 240, 15, 220, 65, "Search", color(224, 128, 142), myFont2, TEXT_WIDGET, 15);
  screenOne.addWidget(textEdit);
  TextWidget textEdit2=new TextWidget(SCREENX/2 + 180, SCREENY/4+150, 150, 65, "Search", color(224, 128, 142), myFont2, TEXT_WIDGET, 20);
  screenTwo.addWidget(textEdit2);
  Widget quitButton=new Widget(SCREENX - 170, SCREENY - 90, 140, 65, "Quit", color(224, 128, 142), myFont2, EVENT_QUIT);
  screenOne.addWidget(quitButton);
  Widget backButton=new Widget(SCREENX - 170, 30, 140, 65, "Back", color(224, 128, 142), myFont2, EVENT_BACKWARD);
  screenTwo.addWidget(backButton);
  USMapGraph.addWidget(backButton);
  Widget USMap = new Widget(30, SCREENY-90, 220, 65, "US GRAPH", color(224, 128, 142), myFont2, US_MAP_GRAPH);
  screenOne.addWidget(USMap);

  //12:40 Niall Connolly, created buttons for queries on graph screen
  Widget radioButton1=new Widget(550, SCREENY/3+320, 90, 50, "30 days", color(224, 128, 142), myFont2, EVENT_30DAYS);
  Widget radioButton2=new Widget(650, SCREENY/3+320, 90, 50, "60 days", color(224, 128, 142), myFont2, EVENT_60DAYS);
  Widget radioButton3=new Widget(750, SCREENY/3+320, 90, 50, "90 days", color(224, 128, 142), myFont2, EVENT_90DAYS);
  screenTwo.addWidget(radioButton1);
  screenTwo.addWidget(radioButton2);
  screenTwo.addWidget(radioButton3);

  stateInfo = new Info();
  d.getStateList();
  d.getAreaList();
  mapGraph.groupStateData();
  mapGraph.findGreatestValue();

  barChart= new BarChart(this);
  barChart.setData(graphCases);
  barChart.setMinValue(0);
  barChart.setMaxValue(maxValue);
  textFont(myFont, 20);
  barChart.showValueAxis(true);
  barChart.setValueFormat("#");
  barChart.setBarLabels(stateListArray);
  barChart.showCategoryAxis(true);
  barChart.setBarColour(color(211, 169, 171));
  barChart.setBarGap(8);
  barChart.transposeAxes(true);
}

void keyPressed() {
  if (screen==1) {
    if (focus != null) {
      focus.append(key);
    }
  } else if (screen==2) {
    if (focus2 != null) {
      focus2.append(key);
    }
  }
}
void mousePressed() {
  if (screen == 1) {
    for (int i=0; i < screenOne.widgetList.size(); i++) {
      Widget theWidget =  (Widget)screenOne.widgetList.get(i);
      int event = screenOne.getEvent();
      switch(event) {
      case TEXT_WIDGET:
        focus= (TextWidget)theWidget;
        focus.label="";        // karthik venkatesh, make the search bar empty when clicked, 12/04/21
        return;
      case EVENT_QUIT:        // Quit button to exit program
        exit();
        break;
      case US_MAP_GRAPH:
        screen= 3;
        break;
      default:
        focus = null;
      }
    }
    id = geoMap.getID(mouseX, mouseY);
    if (id != -1) {
      saveStateName = geoMap.getAttributeTable().findRow(str(id), 0).getString("NAME"); // Save the name of the state clicked on
      d.displayAreaNames(saveStateName);
      println("________________________________________________");
      stateInfo.getTotalNumberOfCases(saveStateName); 
      screen = 2;
    }
  }
  //12:30 13/04 Niall Connolly, Removed radio buttons
  if (screen == 2) {
    for (int i=0; i < screenTwo.widgetList.size(); i++) {
      Widget theWidget2 =  (Widget)screenTwo.widgetList.get(i);
      int event = screenTwo.getEvent();
      switch(event) {
      case TEXT_WIDGET:
        focus2= (TextWidget)theWidget2;
        focus2.label="";        // karthik venkatesh, make the search bar empty when clicked, 15/04/21
        return;
      case EVENT_BACKWARD:     // Back button to go to map screen
        screen = 1;
        saveAreaName = "";
        cThirty = 0;
        cSixty = 0;
        cNinety = 0;
        thirty = 0;
        sixty = 0;
        ninety = 0;
        
        break;
      case EVENT_30DAYS:
        stateInfo.days30 = true;
        stateInfo.days60 = false;
        stateInfo.days90 = false;
        break;
      case EVENT_60DAYS:
        stateInfo.days30 = false;
        stateInfo.days60 = true;
        stateInfo.days90 = false;
        break;
      case EVENT_90DAYS:
        stateInfo.days30 = false;
        stateInfo.days60 = false;
        stateInfo.days90 = true;
        break;
      }
    }
  }

  // 12:10 13/04 Niall Connolly, Added back button to the US general graph
  if (screen == 3) {
    int event = USMapGraph.getEvent();
    switch(event) {
    case EVENT_BACKWARD:     // Back button to go to map screen
      screen = 1; 
      break;
    }
  }
}


void title() 
{
  textAlign(CENTER);
  textFont(myFont2, 48);
  fill(0);
  text("Click on a state to view COVID-19 data", SCREENX/2, 65);
}

void draw() {
  readTable();
  if (screen == 1) { 
    screenOne.draw();
    textFont(myFont2, 56);
    title();
    fill(0);
    noStroke();
    rect(0, 0, SCREENX, borderStroke); // Top
    fill(0);
    noStroke();
    rect(SCREENX-borderStroke, 0, borderStroke, SCREENY); // Right
    fill(0);
    noStroke();
    rect(0, SCREENY-borderStroke, SCREENX, borderStroke); // Bottom
    fill(0);
    noStroke();
    rect(0, 0, borderStroke, SCREENX); // Left
    strokeWeight(1);
    stroke(0, 40);               // Boundary colour

    fill(228, 206, 208);          // Land colour
    geoMap.draw();              // Draw the entire map.

    // Find the country at mouse position and draw in different colour.
    id = geoMap.getID(mouseX, mouseY);
    if (id != -1) {
      fill(211, 169, 171);      // Highlighted land colour.
      geoMap.draw(id);

      String stateName=geoMap.getAttributeTable().findRow(str(id), 0).getString("NAME");
      fill(0);
      text(stateName, 640, 680);
    }
  } else if (screen == 2) {
    screenTwo.draw();
    fill(0);
    textFont(myFont2, 72);
    text(saveStateName, SCREENX/2, 80);
    textFont(myFont);
    d.draw();
    
    // outer border
    fill(0);
    noStroke();
    rect(0, 0, SCREENX, borderStroke); // Top
    fill(0);
    noStroke();
    rect(SCREENX-borderStroke, 0, borderStroke, SCREENY); // Right
    fill(0);
    noStroke();
    rect(0, SCREENY-borderStroke, SCREENX, borderStroke); // Bottom
    fill(0);
    noStroke();
    rect(0, 0, borderStroke, SCREENX); // Left
    // inner border
    fill(0);
    noStroke();
    rect(320, 120, 769, borderStroke, 7); // Top
    fill(0);
    noStroke();
    rect(SCREENX-320, 120, borderStroke, 555, 7); // Right
    fill(0);
    noStroke();
    rect(320, SCREENY-borderStroke-120, 769, borderStroke, 7); // Bottom
    fill(0);
    noStroke();
    rect(320, 120, borderStroke, 555, 7); // Left

    //To draw info gathered from info class - Daniel Agsalud.
    stateInfo.casesForArea(saveAreaName, saveStateName);
    stateInfo.getTotalNumberOfCases(saveStateName);
    stateInfo.draw();
  } else if (screen==3) {
    textFont(myFont, 18);
    USMapGraph.draw();
    textFont(myFont, 18);
    barChart.draw(10, 10, width-20, height-20);
    fill(0);
    textFont(myFont2, 52);
    text("USA COVID CHART", SCREENX/2+100, 55);
    fill(0);
    noStroke();
    rect(0, 0, SCREENX, borderStroke); // Top
    fill(0);
    noStroke();
    rect(SCREENX-borderStroke, 0, borderStroke, SCREENY); // Right
    fill(0);
    noStroke();
    rect(0, SCREENY-borderStroke, SCREENX, borderStroke); // Bottom
    fill(0);
    noStroke();
    rect(0, 0, borderStroke, SCREENX); // Left
  }
}

void readTable() {
  table=loadTable("cases-97k.csv", "header");
  for (int i=0; i<table.getRowCount(); i++) {
    row = table.getRow(i);
    date = row.getString("date");
    area = row.getString("area");
    state = row.getString("county/state");
    geoid = row.getDouble("geoid");
    cases = row.getInt("cases");
    country= row.getString("country");
  }
}
