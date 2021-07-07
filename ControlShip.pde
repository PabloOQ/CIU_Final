class ControlShip {
  
  private Ship nave;
  private DrawShip muestraNave;

  // PARÁMETRO PASADO DESDE EL PROGRAMA PRINCIPAL
  private int maxSpeed;

  public ControlShip(Ship nave, int maxSpeed) {
     muestraNave = new DrawShip(nave); 
     this.nave = nave;
     
     this.maxSpeed = maxSpeed;
  }
  
  private void dibuja() {
    muestraNave.dibuja();
  }
 
  private void resetFrontVelocity(){
    nave.setFrontVelocity(new PVector(1 , 1));
  }

  private void resetBackVelocity(){
    nave.setBackVelocity(new PVector(1 , 1));        
  }

  private void resetVelocity(){
    resetBackVelocity();
    resetFrontVelocity();
  }

  private void frontMovement() {
    resetBackVelocity();
    
    int angle = nave.getAngle();
    PVector pos = nave.getPos();
    
    PVector velocity = nave.getFrontVelocity();
    
    PVector newPos = new PVector((sin(radians(angle - 90)) * velocity.x) + pos.x, (- cos(radians(angle -90))* velocity.y)+ pos.y);
    nave.setPos(adjustPos(newPos));
   
    
    if(velocity.x < maxSpeed) {
      nave.setFrontVelocity(new PVector(velocity.x + 1, velocity.y + 1));
    }
  }
  
  private void backMovement() {
    resetFrontVelocity();
    
    int angle = nave.getAngle();
    PVector pos = nave.getPos();
    
    PVector velocity = nave.getBackVelocity();
    
    PVector newPos = new PVector((-sin(radians(angle - 90)) * velocity.x) + pos.x, (cos(radians(angle -90)) * velocity.y) + pos.y);
    nave.setPos(adjustPos(newPos));
    
    if(velocity.x < maxSpeed) {
      nave.setBackVelocity(new PVector(velocity.x + 1, velocity.y + 1));
    }
  }
  
  // Ajustamos la posición a medida que la nave se sale de la pantalla
  private PVector adjustPos(PVector pos) {
   if(pos.y >= height + 50) {
     pos.y = -50;
   } else if(pos.y <= -50) {
     pos.y = height + 50;
   }
   
   if(pos.x >= width + 70) {
     pos.x = -70;
   } else if(pos.x <= -70) {
     pos.x = width + 70;
   }
   
   return pos;
  }
 
}
 
