class Screen{
  color backgroundColour;
  ArrayList<Widget> widgetList;
  
  Screen(color backgroundColour){
    this.backgroundColour = backgroundColour;
    widgetList = new ArrayList<Widget>();
  }
  
  int getEvent(){
    for(Widget widget : widgetList){
      int event = widget.getEvent(mouseX,mouseY);
      if(event != 0) return event;
    }
    return 0;
  }
  
  void addWidget(Widget widget){
    widgetList.add(widget);
  }
  
  void invalidSearch(){
    println("ERROR.400: The request could not be understood by the server due to malformed syntax. The client SHOULD NOT repeat the request without modifications.");
  }
  
  void draw(){
    background(backgroundColour);
    if(!widgetList.isEmpty()){
      for(Widget widget : widgetList){
        color borderColour;
        if (mouseX > widget.x && mouseX < widget.x + widget.width && mouseY > widget.y && mouseY < widget.y + widget.height){
          borderColour = color(0, 40);
        }
        else{
          borderColour = color(255);
        }
        strokeWeight(5);
        stroke(borderColour);
        widget.draw();
      }
    }
  }
}
