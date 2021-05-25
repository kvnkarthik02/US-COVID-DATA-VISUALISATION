// 25/03/21 at 17:30 Niall created the widget class
class Widget {
  int x, y, width, height;
  String label; int event;
  color widgetColour, labelColour;
  PFont widgetFont;
  int type;
  Widget(){}
  
  Widget(int x,int y, int width, int height, String label, color widgetColour, PFont widgetFont,  int event){
    this.x=x; this.y=y; this.width = width; this.height= height; 
    this.label=label; this.event = event;
    this.widgetFont=widgetFont; this.widgetColour=widgetColour;
    labelColour= color(255);
  }
  void draw(){
    fill(widgetColour);
    rect(x,y,width,height);
    fill(labelColour);
    strokeWeight(5);
    stroke(0);
    text(label, x+(width/2), y+(height-20));
  }
  
  int getEvent(int mX, int mY){
    if(mX>x && mX < x+width && mY >y && mY <y+height){
      return event;
    }
    return 0;
  }
}
