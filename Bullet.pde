class Bullet{
  float radius;
  PVector pos;
  PVector speed;

  public Bullet(PVector pos, PVector speed, float radius){
    setPos(pos);
    setSpeed(speed);
    setRadius(radius);
  }

  public void setSpeed(PVector speed){
    this.speed = speed.copy();
  }

  public void setPos(PVector pos){
    this.pos = pos.copy();
  }

  public void setRadius(float radius){
    this.radius = radius;
  }

  public PVector getSpeed(){
    return speed.copy();
  }

  public PVector getPos(){
    return pos.copy();
  }

  public float getRadius(){
    return radius;
  }
}