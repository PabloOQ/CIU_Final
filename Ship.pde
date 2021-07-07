class Ship{
  
  private int health;
  private PVector pos;
  
  private PVector backVelocity;
  private PVector frontVelocity;
  
  private int angle;
  
  public Ship(PVector pos, int health){
    setPos(pos);
    setHealth(health);
    
    frontVelocity = new PVector(1, 1);
    backVelocity = new PVector(1, 1);
    
    angle = 0;
  }

  private void setHealth(int health){
    this.health = health;
  }
  
  private void setPos(PVector pos){
    this.pos = pos.copy();
  }
    
  private int getHealth(){
    return health;
  }
  
  private PVector getPos(){
    return pos.copy();
  }
  
  // Incrementamos el ángulo según el valor pasado por parámetro
  private void setAngle(int angle) {
    this.angle = angle % 360;
  }
  
  private int getAngle() {
    return angle;
  }
  
  private void setFrontVelocity(PVector newVelocity) {
    frontVelocity = newVelocity;
  }
  
  private void setBackVelocity(PVector newVelocity) {
    backVelocity = newVelocity;
  }
  
  private PVector getBackVelocity() {
    return backVelocity.copy();
  }
  
  private  PVector getFrontVelocity() {
    return frontVelocity.copy();
  }
}
