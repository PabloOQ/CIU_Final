class Ship{
  int health;
  PVector pos;
  
  public Ship(PVector pos, int health){
    setPos(pos);
    setHealth(health);
  }

  public void setHealth(int health){
    this.health = health;
  }
  
  public void setPos(PVector pos){
    this.pos = pos.copy();
  }
    
  public int getHealth(){
    return health;
  }
  
  public PVector getPos(){
    return pos.copy();
  }
}
