import processing.sound.*;

class ControlObjects{
  
  private PApplet parent;

  private ControlBullet ctrlShipBullet;
  private ControlBullet ctrlFaceBullet;
  private ControlShip ctrlShip;

  private int framesLastBulletFace;

  private int framesLastBullet;
  private Ship nave;
  
  // PARÁMETRO PASADO DESDE EL PROGRAMA PRINCIPAL
  private int framesBetweenBullets;
  private int framesBetweenFaceBullets;

  SoundFile[] mouthSounds;
  SoundFile hurtSound;
  SoundFile shootSound;
  SoundFile panSound;


  public ControlObjects(PApplet parent, Ship nave, int maxVelocityShip, int bulletSpeed, int framesBetweenBullets, int framesBetweenFaceBullets, float bulletRadius) {
    this.parent = parent;

    this.nave = nave;
    
    ctrlShipBullet = new ControlBullet(bulletSpeed, bulletRadius, color(255, 255, 0));
    ctrlFaceBullet = new ControlBullet(bulletSpeed, bulletRadius, color(0, 255, 255));
    ctrlShip = new ControlShip(nave, maxVelocityShip);
    framesLastBullet = frameCount;
    framesLastBulletFace = frameCount;
    
    this.framesBetweenBullets = framesBetweenBullets;
    this.framesBetweenFaceBullets = framesBetweenFaceBullets;

    mouthSounds = new SoundFile[7];
    for (int i = 0; i < mouthSounds.length; i++) {
      mouthSounds[i] = new SoundFile(parent, "sounds/boca" + i + ".wav");
    }

    panSound = new SoundFile(parent, "sounds/pan.wav");
    hurtSound = new SoundFile(parent, "sounds/hurt.wav");
    shootSound = new SoundFile(parent, "sounds/laser.wav");
  }

  private synchronized void moveBullets(){
    ctrlShipBullet.updateBulletPosition();
    ctrlFaceBullet.updateBulletPosition();
  }

  private void dibuja() {     
    ctrlShip.dibuja();
    ctrlShipBullet.dibuja();
    ctrlFaceBullet.dibuja();
  }

  private synchronized void checkController(Controller lastControllerData, Controller currentControllerData) {

    int deadZone = 40;
    if (currentControllerData.getJOY_X() <= Controller.DEFAULT_JOY_X + deadZone &&
        currentControllerData.getJOY_X() >= Controller.DEFAULT_JOY_X - deadZone &&
        currentControllerData.getJOY_Y() <= Controller.DEFAULT_JOY_Y + deadZone &&
        currentControllerData.getJOY_Y() >= Controller.DEFAULT_JOY_Y - deadZone){
      //Nothing
    }else{
      int range = 200;
      nave.setAngle(MathUtils.angle((int) map(currentControllerData.getJOY_X(), Controller.MIN_JOY_X, Controller.MAX_JOY_X, -range, range),
        (int) map(currentControllerData.getJOY_Y(), Controller.MIN_JOY_Y, Controller.MAX_JOY_Y, -range, range)));
    }


    if (currentControllerData.getR_BUMP() == 1){
      if(framesLastBullet < frameCount - framesBetweenBullets) {
        ctrlShipBullet.shoot(nave.getPos(), nave.getAngle(), 40);
        shootSound.play();
        framesLastBullet = frameCount;
      }
    }

    if (currentControllerData.getR_TRIG() == 1){
      ctrlShip.frontMovement();
    }else if(currentControllerData.getL_TRIG() == 1){
      ctrlShip.backMovement();
    }else{
      ctrlShip.resetVelocity();
    }

    if (currentControllerData.getL_TRACK_CLICK() == 1){
      println("Still works");
    }
  }

  private synchronized void faceShoot(PVector pos){
    if(framesLastBulletFace < frameCount - framesBetweenFaceBullets){
      int bullets = (int) random(3,5) * 5;
      int angle = (int) 360/bullets;
      for (int i = 0; i < bullets; i++){
        ctrlFaceBullet.shoot(pos, (int) (((i*angle) + random(0,20)) % 360), 10);
      }
      mouthSounds[(int) random(0,mouthSounds.length - 1)].play();
      framesLastBulletFace = frameCount;
    }
  }

  private synchronized void checkEyeCollision(PVector[] polygon, GameEye eye){
    if (ctrlShipBullet.checkPolygonCollision(polygon, eye)){
      hurtSound.play();
    }
  }

  private synchronized void checkCircleCollision(){
    //Size of ship image, hardcoded
    if (ctrlFaceBullet.checkCircleCollision(nave, 23)){
      panSound.play();
    }
  }
}
