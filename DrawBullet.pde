class DrawBullet {
  
  private ArrayList<Bullet> bullets;
  private color fill;
  private color stroke;

  public DrawBullet(ArrayList<Bullet> bullets, color fill) {
    this.bullets = bullets;
    this.fill = fill;
    stroke = color(0,0,0);
  }

  private void dibuja() {
    pushStyle();
    fill(fill);
    stroke(stroke);
    for(Bullet bullet :bullets) {
        
      PVector pos = bullet.getPos();
      float radius = bullet.getRadius();
      
      ellipse(pos.x, pos.y, radius, radius);
    }
    popStyle();
  }
}
