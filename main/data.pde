//"Karthik Venkatesh Nagaraj, completed week 8 task (reading data from dataset), 7PM, 23/3/2021" 
class data{                                                      
  void setup(){
    size(600,600);
    background(0);
  }
  
  void readTable(){
    for(int i=0;i<table.getRowCount();i++){
      row=table.getRow(i);
      String date= row.getString("date");
      String area= row.getString("area");
      String state= row.getString("county/state");
      double geoid=row.getDouble("geoid");
      int cases = row.getInt("cases");
      String country= row.getString("country");
    }  
  }
  
  
  String[] getStateList(){
    for(int i=0;i<table.getRowCount();i++){
      row = table.getRow(i);
      String stateName=row.getString("county/state");
      String stateNameUpperCase= stateName.toUpperCase();
      stateList.add(stateNameUpperCase);
    }
    stateListArray=stateList.toArray( new String[stateList.size()]);
    //println(stateListArray.length);
    return stateListArray;
  }
  
  boolean checkValidStateSearch(String stateName){
    for(int i=0;i<stateListArray.length;i++){
      if(stateName.equalsIgnoreCase(stateListArray[i])){
        return true;
      }
    }
    
    return false;
  }
  
  String[] getAreaList(){
    for(int i=0;i<table.getRowCount();i++){
      row = table.getRow(i);
      String areaName=row.getString("area");
      String areaNameUpperCase= areaName.toUpperCase();
      areaList.add(areaNameUpperCase);
    }
    areaListArray=areaList.toArray( new String[areaList.size()]);
    //println(areaListArray.length);
    return areaListArray;
  }
  
  boolean checkValidAreaSearch(String areaName){
    for(int i=0;i<areaListArray.length;i++){
      if(areaName.equalsIgnoreCase(areaListArray[i])){
        return true;
      }
    }
    return false;
  }
  
  void displayAreaNames(String saveState){
    String [] displayArea;
    HashSet<String> displayAreaList = new HashSet<String>();
    for(int i=0;i<table.getRowCount();i++){
      row = table.getRow(i);
      String stateName=row.getString("county/state");
      if(stateName.equalsIgnoreCase(saveState)){
        String areaName=row.getString("area");
        String areaNameUpperCase= areaName.toUpperCase();
        displayAreaList.add(areaNameUpperCase);
      }
      
    }
    println(displayAreaList);
  }
  
  void draw(){
    readTable();
  }
}
