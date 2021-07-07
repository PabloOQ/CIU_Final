class DrawShip {
  
  private Ship nave;
  private PImage sprite;
  private final int imWidth = 70;
  private final int imHeight = 50;

  public DrawShip(Ship nave) {
    this.nave = nave;
    sprite = loadImage("images/nave.png");
    sprite.resize(imWidth, imHeight);
  }
  
  private void dibuja() {    
    PVector shipPosition = nave.getPos();

    pushMatrix();
    
    translate(shipPosition.x, shipPosition.y);
    rotate(radians(nave.getAngle()));
    image(sprite, -35, -25);
    
    popMatrix();

  }

  public int getWidth(){
    return imWidth;
  }

  public int getHeight(){
    return imHeight;
  }
}
