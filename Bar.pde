PImage img;

class Bar {
  volatile private int total;
  volatile private int current;
  
  volatile private int w;
  volatile private int h;
  
  volatile private int titleHeight;
  
  public Bar(int total){
    this.total = total;
    current = total;
    titleHeight = 0;
  }

  public void setTotal(int total){
    this.total = total;
  }
  
  public int getTotal(){
    return total;
  }
  
  public void setCurrent(int current){
    if (current > total) this.current = total;
    else if (current < 0) this.current = 0;
    else this.current = current;
  }
  
  public int getCurrent(){
    return current;
  }
  
  public int getWidth(){
    return w;
  }
  
  public int getHeight(){
    return h;
  }
  
  
  public void setTitleHeight(int titleHeight){
    this.titleHeight = titleHeight;
  }
  
  public int getTitleHeight(){
    return titleHeight;
  }
  
  public synchronized void show(String title, int posX, int posY, int w, int h, int b, int p){
    this.w = w;
    this.h = h;
    if (titleHeight == 0) titleHeight = h;
    pushStyle();
    stroke(255);
    fill(255);
    textSize(titleHeight);
    text(title, posX, posY + titleHeight/2);
    popStyle();
    pushStyle();
    noFill();
    stroke(255);
    strokeWeight(b);
    strokeJoin(MITER);
    rect(posX, posY + titleHeight, w, h);
    popStyle();
    
    pushStyle();
    noStroke();
    fill(255,0,0);
    rect(posX + b/2 + p + 1, posY + b/2 + p + titleHeight + 1, (w - b - p*2) * current / total, h - b - p*2 - 1);
    popStyle();
  }
}