class RealMouth extends FShape{
  
  RealFace face;
  
  public RealMouth(){
    
  }
  
  public void setFace(RealFace face, float camSize){
    this.face = face;
    this.camSize = camSize;
  }
  
  public boolean isOpen(){
    return Expressions.isOpen(this);
  }
  
  public RealMouth copy(PImage img, int cam_x, int cam_y){
    PVector[] contour = new PVector[this.contour.length];
    for(int i = 0; i < this.contour.length; i++){
      contour[i] = this.contour[i].copy();
    }
    
    RealMouth newMouth = new RealMouth();
    newMouth.setPoints(contour, img, (int)cam_x, (int)cam_y);
    return newMouth;
  }
  
}
