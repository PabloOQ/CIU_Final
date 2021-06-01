class RealFace extends FShape{
  
  float reference;
  float forehead;
  
  RealEyebrow leftEyebrow;
  RealEyebrow rightEyebrow;
  RealEye leftEye;
  RealEye rightEye;
  RealMouth mouth;
  
  PVector[] vertical;
  PVector chin;
  
  public RealFace(){
    
  }
  
  public RealFace(RealEyebrow leftEyebrow, RealEyebrow rightEyebrow, RealEye leftEye, RealEye rightEye, RealMouth mouth){
    this.leftEyebrow = leftEyebrow;
    this.rightEyebrow = rightEyebrow;
    this.leftEye = leftEye;
    this.rightEye = rightEye;
    this.mouth = mouth;
    setReference();
    setVertical();
  }
  
  /*public float getReference(){
    return reference;
  }*/
  
  public float getReference(){
    return Expressions.distance(leftEye, rightEye);
  }
  
  public void setReference(){
    reference = Expressions.distance(leftEye, rightEye);
  }
  
  public PVector[] getVertical(){
    return null;
  }
  
  public void setVertical(){
    reference = Expressions.distance(leftEye, rightEye);
  }
  
  public RealEyebrow getLeftEyebrow(){
    return leftEyebrow;
  }
  
  public void setLeftEyebrow(RealEyebrow leftEyebrow){
    this.leftEyebrow = leftEyebrow;
    leftEyebrow.setFace(this);
  }
  
  public RealEyebrow getRightEyebrow(){
    return rightEyebrow;
  }
  
  public void setRightEyebrow(RealEyebrow rightEyebrow){
    this.rightEyebrow = rightEyebrow;
    rightEyebrow.setFace(this);
  }
  
  public RealEye getLeftEye(){
    return leftEye;
  }
  
  public void setLeftEye(RealEye leftEye){
    this.leftEye = leftEye;
    leftEye.setFace(this);
  }
  
  public RealEye getRightEye(){
    return rightEye;
  }
  
  public void setRightEye(RealEye rightEye){
    this.rightEye = rightEye;
    rightEye.setFace(this);
  }
  
  public RealMouth getMouth(){
    return mouth;
  }
  
  public void setMouth(RealMouth mouth){
    this.mouth = mouth;
    mouth.setFace(this);
  }
  
  public PVector getChin(){
    return chin;
  }
  
  public void setChin(RealMouth mouth){
    chin = contour[0];
  }
  
  public void print(){
    println("Face: ", this);
    if (leftEyebrow != null && rightEyebrow != null) println("Eyebrows: " + leftEyebrow + ", " + rightEyebrow);
    else println("Eyebrows: null");
    if (leftEye != null && rightEye != null) println("Eye: " + leftEye + ", " + rightEye);
    else println("Eyes: null");
    if (mouth != null) println("Mouth: " + mouth);
    else println("Mouth: null");
    if (chin != null) println("Chin: " + chin);
    else println("Chin: null");
  }
}
