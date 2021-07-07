class Bullet{
  
  float radius;
  PVector pos;
  int speed;
  int angle;

  public Bullet(PVector pos, int speed, float radius, int angle){
    setPos(pos);
    setSpeed(speed);
    setRadius(radius);
    
    this.angle = angle;
  }

  public void setSpeed(int speed){
    this.speed = speed;
  }

  public void setPos(PVector pos){
    this.pos = pos.copy();
  }

  public void setRadius(float radius){
    this.radius = radius;
  }

  public int getSpeed(){
    return speed;
  }

  public PVector getPos(){
    return pos.copy();
  }

  public float getRadius(){
    return radius;
  }
  
  public int getAngle() {
    return angle;
  }
  
}
