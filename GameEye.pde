class GameEye{
  volatile int health;
  
  public GameEye(){
    setHealth(35);
  }
  
  public synchronized void setHealth(int health){
    this.health = health;
  }

  public synchronized int getHealth(){
    return health;
  }
}
