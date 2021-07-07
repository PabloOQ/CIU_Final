class ControlBullet {
  
  private DrawBullet muestraBalas;
  private ArrayList<Bullet> balas;
  
  // PARÁMETROS PASADO DESDE EL PROGRAMA PRINCIPAL
  private int bulletSpeed;
  private float bulletRadius;
  
  public ControlBullet(int bulletSpeed, float bulletRadius, color fill) {
    balas = new ArrayList<Bullet>();
    muestraBalas = new DrawBullet(balas, fill);
    
    this.bulletSpeed = bulletSpeed;
    this.bulletRadius = bulletRadius;
  }
  
  // Dibujamos las balas que tenemos en pantalla
  private void dibuja() {
    muestraBalas.dibuja();
  }
  
  // Creamos una nueva bala que añadimos al contenedor su posición será relativa al ángulo de la nave y su posición
  private void shoot(PVector pos, int angle, int separator) {
    balas.add(new Bullet(new PVector(pos.x - (separator * (-sin(radians(angle - 90)))), pos.y - (separator * cos(radians(angle - 90)))), bulletSpeed, bulletRadius, angle));
  }
  
   // Actualizamos la posición de cada bala en pantalla acorde al ángulo al que fue disparada, su posición previa y su velocidad.
  private synchronized void updateBulletPosition() {
    for (int i = balas.size() - 1; i >= 0; i--) {
      Bullet bala = balas.get(i);
      PVector pos = bala.getPos();
      
      if (bulletOutOfBounds(pos)) {
        balas.remove(i);
      
      } else {
        int angle = bala.getAngle();
        int velocity = bala.getSpeed();
        
        bala.setPos(new PVector((sin(radians(angle - 90)) * velocity) + pos.x, (- cos(radians(angle -90))* velocity)+ pos.y));
      }
    }
  }
  
  // Método auxiliar para comprobar que la nave esta dentro de los limites esperados
  private boolean bulletOutOfBounds(PVector pos) {
    if(pos.x > width || pos.x < 0) {
      return true;
    } if(pos.y > height || pos.y < 0) {
      return true;
    }
    return false;
  }
 
 private boolean checkPolygonCollision(PVector[] contour, GameEye eye){
  boolean res = false;
  for (int i = balas.size() - 1; i >= 0; i--) {
    if (Collisions.circleWithPolygon(balas.get(i).getPos(), bulletRadius, contour)){
      balas.remove(i);
      eye.setHealth(eye.getHealth() - 5);
      if (eye.getHealth() < 0){
        eye.setHealth(0);
      }
      res = true;
    }else{

    }
  }
  return res;
 }

 private boolean checkCircleCollision(Ship ship, float radius){
  boolean res = false;
  for (int i = balas.size() - 1; i >= 0; i--) {
    if (Collisions.circleWithCircle(balas.get(i).getPos(), bulletRadius, ship.getPos(), radius)){
      balas.remove(i);
      ship.setHealth(ship.getHealth() - 5);
      if (ship.getHealth() < 0){
        ship.setHealth(0);
      }
      res = true;
    }else{

    }
  }
  return res;
 }
}
