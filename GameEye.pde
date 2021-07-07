class GameEye{
  volatile int health;
  
  public GameEye(){
    setHealth(100);
  }
  
  public synchronized void setHealth(int health){
    this.health = health;
  }
/*
  public void setPos(PVector pos){
    this.pos = pos.copy();
  }
  
  public void setSize(PVector size){
    if (size.x <= 0 && size.y <= 0){
      throw new java.lang.RuntimeException("Eye size can't be less or equal to 0");
    }
    this.size = size.copy();
  }

  public float getMaxRadius(){
    return max(size.x, size.y);
  }

  public float getMinRadius(){
    return min(size.x, size.y);
  }
  */
  public synchronized int getHealth(){
    return health;
  }
  /*
  public PVector getPos(){
    return pos.copy();
  }

  public PVector getSize(){
    return size.copy();
  }*/
}
