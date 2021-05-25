// 22:32pm, 07/04/2021, Jhellen Kyle DANIEL Agsalud created Info Class
// Karthik Venkatesh, moving code inside draw function into functions, 2:02PM, 12/02/21
class Info
{
  int numberOfCases;
  int totalCases;
  int highestCase;
  final int space = 18;

  boolean days30=true, days60=false, days90=false;

  String location;
  String dateOfHighest;

  String stateArea;
  String stateName2;
  int totalAreaCase;
  int areaCaseNum;

  boolean sameText;
  boolean sameState;


  Info()
  {   
    numberOfCases = 0;
    totalCases = 0;
  }

  void getTotalNumberOfCases(String stateName)
  {
    for (int r = 0; r < table.getRowCount(); r++)
    {
      location = table.getString(r, 2);

      //Daniel Agsalud added bool var to work for search bar, 15/04/2021, 01:13
      boolean similar = location.equalsIgnoreCase(stateName);

      if (similar == true)
      {
        cThirty++;
        cSixty++;
        cNinety++;

        numberOfCases = table.getInt(r, 4);
        totalCases = totalCases + numberOfCases;



        if (numberOfCases > highestCase)
        {
          highestCase = numberOfCases;
          dateOfHighest = table.getString(r, 0);
        }

        if (cThirty == 30)
        {
          thirty = totalCases;
        }

        if (cSixty == 60)
        {
          sixty = totalCases;
        }

        if (cNinety == 90)
        {
          ninety = totalCases;
        }
      }
    }
  }

  //Daniel Agsalud, added new method to get number of cases for an specific area in a state.
  void casesForArea(String areaName, String stateName)
  {

    sameText = stateName.equalsIgnoreCase(areaName);

    if (sameText == false)
    {
      if (areaName != null)
      {

        for (int r2 = 0; r2 < table.getRowCount(); r2++)
        {
          stateArea = table.getString(r2, 1);
          stateName2 = table.getString(r2, 2);
          
          boolean sameState = stateName.equalsIgnoreCase(stateName2);

          boolean same = stateArea.equalsIgnoreCase(areaName);
          
          if(sameState == true)
          {
            if (same == true)
            {
              areaCaseNum = table.getInt(r2, 4);
              totalAreaCase = totalAreaCase + areaCaseNum;
            }
          }
        }
      }
    }
  }



  void displayInfo() {
    //Daniel Agsalud moved info position so it displays in the box; 22:38, 14/04/2021
    textFont(myFont, 18);
    text("Enter an Area in the State you selected for total number of cases: ", 600, SCREENY/4+190);
    textFont(myFont, 24);
    text("From:", 700, SCREENY/5);
    text("21/01/2020 - 28/04/2020", 700, SCREENY/4);
    text("Total number of cases:  " + totalCases, 700, SCREENY/4 + space * 3);
    totalCases = 0;
    text("Highest number of cases in a day:  " + highestCase, 700, SCREENY/4 + space * 5);
    text("Date of highest number of cases:  " + dateOfHighest, 700, SCREENY/4 + space * 7);
    if (days30 == true) {
      text("Number of cases within the first 30 Days:  ", 700, SCREENY/3+90 + space * 9);
      text(thirty, 700, SCREENY/3+110 + space * 10);
    }
    if (days60 == true) {
      text("Number of cases within the first 60 Days:  ", 700, SCREENY/3+90 + space * 9);
 
      text( + sixty, 700, SCREENY/3+110 + space * 10);
    }
    if (days90 == true) {
      text("Number of cases within the first 90 Days:  ", 700, SCREENY/3+90 + space * 9);
      text( ninety, 700, SCREENY/3+110 + space * 10);
    }
    if (saveAreaName != null && sameText == false)
    {
      textFont(myFont2, 48);
      text(saveAreaName, 700, SCREENY/4+190 + space * 3);
      textFont(myFont, 24);
      text("Number of cases: " + totalAreaCase, 700, SCREENY/4+220 + space * 3);
    }
    totalAreaCase = 0;
    textFont(myFont2);
  }
  void draw()
  {
    //getTotalNumberOfCases(stateName);
    displayInfo();
  }
}
