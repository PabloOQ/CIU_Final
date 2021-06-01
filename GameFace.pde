class GameFace{
  
  PVector pos;
  
  public GameFace(PVector pos){
    setPos(pos);
  }

  public void setPos(PVector pos){
    this.pos = pos.copy();
  }
  
  public PVector getPos(){
    return pos.copy();
  }
}
