// Niall and Karthik, working on text-search widget, 3:41Pm, 7/4/21
// Karthik, created function to create a list of States, 2:33PM, 12/04/21
// Karthik, made the search bar such that it accepts only valid inputs, 4PM, 12/04/21
class TextWidget extends Widget {
  int maxlen;
  
  TextWidget(int x, int y, int width, int height, String label, color widgetColour, PFont font, int event, int maxlen){
    this.x=x; this.y=y; this.width = width; this.height= height;
    this.label=label; this.event=event;
    this.widgetColour = widgetColour; this.widgetFont = font;
    labelColour = color(255); this.maxlen = maxlen;
  }
  
  void append(char s){
    if(screen == 1){
      if(s==BACKSPACE){
        if(!label.equals("")){
          label = label.substring(0,label.length()-1);
        }
      }
      else if( s==ENTER){
        d.draw();
        saveStateName=getText();
        if(d.checkValidStateSearch(saveStateName)){
          saveStateName=getText();
          stateInfo.getTotalNumberOfCases(saveStateName);
          stateInfo.draw();
          screen=2;
          d.displayAreaNames(saveStateName);
          println("________________________________________________");
          
        }
        else{
          screenTwo.invalidSearch();
        }
      }
      else if (label.length() < maxlen){
        if(screen==1){
          label = label + str(s);
          label = label.toUpperCase();
        }
        
        

      }
    }
    
    if(screen == 2){
      if(s==BACKSPACE){
        if(!label.equals("")){
          label = label.substring(0,label.length()-1);
        }
      }
      else if( s==ENTER){
        d.draw();
        saveAreaName=getText();
        if(d.checkValidAreaSearch(saveAreaName)){
          saveAreaName=getText();
          stateInfo.getTotalNumberOfCases(saveAreaName);
          stateInfo.draw();
          screen=2;
        }
        else{
          screenTwo.invalidSearch();
        }
      }
      else if (label.length() < maxlen){
        label = label + str(s);
        label = label.toUpperCase();
      }
    }
    
  }
  
  String getText(){
    return label;
  }
  
}
