class Button {
  
  int posX, posY, sizeX, sizeY;
  int goToState;
  
  boolean isClicked;
  boolean active;
  boolean playClick;
  boolean playHover;
  
  public Button() {
    isClicked = false;
    playClick = false;
    playHover = false;
  }
  
  public void display(String text, int posX, int posY, int sizeX, int sizeY){
    active = true;
    this.posX = posX;
    this.posY = posY;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    
    pushMatrix();
    translate(posX,posY);
    pushStyle();
    if (isClicked) fill(127,127,127,127);
    else if (isHovered()) fill(255,255,255,127); 
    else noFill();
    noStroke();
    rect(0,0, sizeX, sizeY);
    
    pushMatrix();
    translate(sizeX/2, sizeY/2);
    if (isClicked) fill(255);
    else if (isHovered()) fill(0);
    else fill(255);
    textAlign(CENTER, CENTER);
    textSize(sizeY/3);
    text(text, 0, 0);
    popMatrix();
    popMatrix();
    popStyle();
  }
  
  private boolean isHovered(){
    if (mouseX >= posX && mouseX <= posX + sizeX && mouseY >= posY && mouseY <= posY + sizeY) {
      if (playClick) hover.play();
      playClick = false;
      return true;
    } else {
      playClick = true;
      return false;
    }
  }
  
  private void click(){
    if (active) {
      if (isHovered()){
        click.play();
        isClicked = true;
      } else {
        isClicked = false;
      }
    }
  }
  
  private boolean release(){
    if (active) {
      isClicked = false;
      if (isHovered()){
        return true;
      }
    }
    return false;
  }
  
  private void disable(){
    active = false;
  }
}