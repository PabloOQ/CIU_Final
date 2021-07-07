class GameFace{
  
  PVector pos;
  GameEye leftEye;
  GameEye rightEye;

  public GameFace(PVector pos, GameEye leftEye, GameEye rightEye){
    setPos(pos);
    this.leftEye = leftEye;
    this.rightEye = rightEye;
  }

  public void setPos(PVector pos){
    this.pos = pos.copy();
  }
  
  public PVector getPos(){
    return pos.copy();
  }

  public GameEye getLeftEye(){
    return leftEye;
  }

  public GameEye getRightEye(){
    return rightEye;
  }
}
