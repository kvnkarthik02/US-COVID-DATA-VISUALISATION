//Karthik, created general USA map using gicentre library, 7:20AM, 13/04/21

class USmap{
  
  void groupStateData(){
    int index=0;
    for(String stateName : stateList){
      graphCases[index++]= stateTotalCases(stateName);
    }
    //println(graphCases);
  }
  
  float stateTotalCases(String stateName){
    float totalNumberOfCases=0;
    for(int i=0;i<table.getRowCount();i++){
      String location = table.getString(i,2);
      if(location.equalsIgnoreCase(stateName)){
        float numberOfCases = table.getInt(i, 4);
        totalNumberOfCases= totalNumberOfCases+numberOfCases;
      }
    }
    //println(stateName+": "+ totalNumberOfCases);
    return totalNumberOfCases;
  }
  
  float findGreatestValue(){
    for(int i=0;i<graphCases.length;i++){
      if(graphCases[i]>maxValue){
        maxValue = graphCases[i];
      }
    }
    //println(maxValue);
    return maxValue;
  }
  
  void groupAreaData(){
    int index=0;
    for(String areaName : areaList){
      areaCases[index++]= stateTotalCases(areaName);
    }
    //println(Cases);
  }
  
  void draw(){
    background(181, 211, 231);
  }
}
