class RealEyebrow extends FShape{
  
  RealFace face;
  
  public RealEyebrow(){
    
  }
  
  public RealFace getFace(){
    return face;
  }
  
  public void setFace(RealFace face){
    this.face = face;
  }
  
  public PVector getTop(){
    if (contour != null && contour[0] != null) {
      PVector top = contour[0];
      for (PVector point : contour){
        if (face.getCenter().y - point.y > face.getCenter().y - top.y) top = point;
      }
      pushStyle();
      noStroke();
      fill(0,255,255);
      ellipse(top.x, top.y,5,5);
      popStyle();
      return top;
    }
    return null;
  }
  
}
