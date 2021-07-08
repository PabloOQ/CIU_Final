import processing.serial.*;
import processing.sound.*;

int state;

Serial controllerSerial;
Controller currentControllerData;
Controller lastControllerData;

FaceController faceInterface;
boolean currentFaceSuccess = false;
boolean currentFaceUsable = true;
RealFace lastUsableFace;
RealFace currentFace;
int framesWithoutFace = 0;
int timeFromLastFace = 0;
GameFace gameFace;
GameEye gameLeftEye;
GameEye gameRightEye;
PVector[] leftEye;
PVector[] rightEye;
PVector[] mouth;

int faceWidthShow = 125;

SoundFile sadSound;
SoundFile happySound;
SoundFile song;
SoundFile[] mouthSounds;


Palette palette;
int indexPalette;

int max = 0;

volatile boolean bulletsThread = false;

float maxDistance = 65;

PImage bg;
SoundFile hover;
SoundFile click;

Button playButton;
Button aboutButton;
Button quitButton;
Button backButton;

int menuState;

float count;

boolean previouslyPressed;
boolean press;

Bar rightEyeBar;
Bar leftEyeBar;
Bar shipBar;

Ship ship;

volatile ControlObjects objController;

final String[] STATE= {"LOCK",
                  "INTRO",
                  "GAME",
                  "PREGAME",
                  "MENU",
                  "SETUP",
                  "POSTGAME"};
final int LOCK = 0;
final int INTRO = 1;
final int GAME = 2;
final int PREGAME = 3;
final int MENU = 4;
final int SETUP = 5;
final int POSTGAME = 6;

final int waitForNewFaceTime = 1000;

final boolean debug = false;

void setup(){
  size(640,480);

  palette = new Palette(color(43,48,58),
                        color(230,57,70),
                        color(11,0,51),
                        color(73,109,219),
                        color(177,78,237),
                        color(193,202,214));

  state = MENU;

  setupController();
  setupWebcam();
  setupGame();
  setupMenu();

  frameRate(15);
  println("Setup finished");
}

void setupController(){
  println(Serial.list());
  controllerSerial = new Serial(this, Serial.list()[2], 9600);
  controllerSerial.bufferUntil('¿');
  currentControllerData = new Controller();
  lastControllerData = new Controller();
}

void setupWebcam(){
  faceInterface = new FaceController(this, "DroidCam Source 3", 0.35);  //eTronVideo, DroidCam Source 3
  maxDistance =  maxDistance * faceInterface.getCamScale();
}

void setupFace(){
  println("Look to the camera");
  while (!faceInterface.process());
  currentFace = faceInterface.copyFace();
  lastUsableFace = faceInterface.copyFace();
  copyElements(currentFace);
  normalizeElements(currentFace);
}

void copyElements(RealFace face){
  rightEye = copyVectorArr(face.getRightEye().getContour());
  leftEye = copyVectorArr(face.getLeftEye().getContour());
  mouth = copyVectorArr(face.getMouth().getContour());
}

void normalizeElements(RealFace face){
  normalizeElement(rightEye, face);
  normalizeElement(leftEye, face);
  normalizeElement(mouth, face);
}

void normalizeElement(PVector[] arr, RealFace face){
  float imgWidth = faceWidthShow;
  float imgHeight = imgWidth/face.getCropRatio();
  PImage crop = face.getCrop();

  float ratioX = imgWidth/crop.width;
  float ratioY = imgHeight/crop.height;

  for (int i = 0; i < arr.length; i++) {
    arr[i] = Expressions.makeRelative(arr[i], face.getCenter());
    arr[i].x = arr[i].x*ratioX;
    arr[i].y = arr[i].y*ratioY;
    arr[i].x = width/2 + arr[i].x;
    arr[i].y = height/2 + arr[i].y;
  }
}

PVector[] copyVectorArr(PVector[] arr){
  PVector[] res = new PVector[arr.length];
  for(int i = 0; i < arr.length; i++){
    res[i] = arr[i].copy();
  }
  return res;
}

void setupGame(){
  gameFace = new GameFace(new PVector(width/2, height/2),
                          new GameEye(),
                          new GameEye());
  PVector shipPos = new PVector(width - 50, height - 50);
  int shipHealth = 70;
  ship = new Ship(shipPos, shipHealth);
  int maxVelocityShip = 10;
  int bulletVelocity = 10;
  int framesBetweenBullets = 10;
  int framesBetweenFaceBullets = framesBetweenBullets * 2;
  float bulletRadius = 10;
  objController = new ControlObjects(this, ship, maxVelocityShip, bulletVelocity, framesBetweenBullets, framesBetweenFaceBullets, bulletRadius);
  rightEyeBar = new Bar(gameFace.getRightEye().getHealth());
  leftEyeBar = new Bar(gameFace.getLeftEye().getHealth());
  shipBar = new Bar(ship.getHealth());

  sadSound = new SoundFile(this, "sounds/sad_end.wav");
  happySound = new SoundFile(this, "sounds/happy_end.wav");
  song = new SoundFile(this, "sounds/song1.wav");
}

void setupMenu(){
  bg = loadImage("images/bg.jpg");
  hover = new SoundFile(this, "sounds/Hit6.wav");
  click = new SoundFile(this, "sounds/Hit7.wav");

  previouslyPressed = false;
  press = true;
  menuState = 0;
  count = 0;

  playButton = new Button();
  aboutButton = new Button();
  quitButton = new Button();
  backButton = new Button();
}

void draw(){
  pushStyle();
  //tint(255, 255, 255, 127);
  count += 0.05;
  float imgW = width*2;
  float imgH = height*1.5;
  image(bg, sin(radians(count))* imgW/4 + (-imgW/2 + width/2), 0, imgW, imgH);
  popStyle();

  if (debug){
    printText(new String[]{"","","","","",STATE[state],
          "Frame rate: "+frameRate});
  }
  switch(state){
    case INTRO:
      introLogic();
      introShow();
      break;
    case MENU:
      menuLogic();
      menuShow();
      break;
    case GAME:
      gameLogic();
      gameShow();
      RealFace face;
      if (currentFaceSuccess){
        face = currentFace;
      }else{
        face = lastUsableFace;
      }
      if (debug){
        beginShape();
        for (int i = 0; i < leftEye.length; i++) {
          fill(0,0,255);
          vertex(leftEye[i].x, leftEye[i].y);
        }
        endShape();
        beginShape();
        for (int i = 0; i < rightEye.length; i++) {
          fill(0,0,255);
          vertex(rightEye[i].x, rightEye[i].y);
        }
        endShape();
        beginShape();
        for (int i = 0; i < mouth.length; i++) {
          fill(0,0,255);
          vertex(mouth[i].x, mouth[i].y);
        }
        endShape();
      }
      lastUsableFace = currentFace;
      break;
    case POSTGAME:
      gameShow();
      postgameShow();
    case LOCK:
      break;
    default:
      throw new java.lang.RuntimeException("State is not contemplated");
  }  
}

void serialEvent(Serial port){
  String received = port.readStringUntil('¿');
  currentControllerData.parseInputs(received);
  currentControllerData.setUpdated(true);
}

void collectControllerData(){
  currentControllerData.setUpdated(false);
  lastControllerData.updateData(currentControllerData);
  controllerSerial.write("monitor\r");
  //We need to wait a little, when this data is needed just wait until currentControllerData.getUpToDate() is true
  //Usually 10ms
}


void keyAllScreens(){
  Palette[] colors= { new Palette(color(43,48,58),
                                  color(230,57,70),
                                  color(11,0,51),
                                  color(73,109,219),
                                  color(177,78,237),
                                  color(193,202,214)),
                      new Palette(color(255,255,255),
                                  color(80,81,79),
                                  color(72,172,240),
                                  color(10,1,79),
                                  color(3,208,164),
                                  color(139,104,127))};
  if (key == CODED){
    boolean changePalette = false;
    switch(keyCode){
      case LEFT:
        indexPalette--;
        changePalette = true;
        break;
      case RIGHT:
        indexPalette++;
        changePalette = true;
        break;
    }
    if (changePalette){
      if (indexPalette < 0){
        indexPalette = colors.length - 1;
      }else if (colors.length <= indexPalette){
        indexPalette = 0;
      }
      palette = colors[indexPalette];
    }
  }
}

//Logic
void introLogic(){

}

void menuLogic(){
  
  
  if (mousePressed && !previouslyPressed) {
    previouslyPressed = true;
    playButton.click();
    aboutButton.click();
    quitButton.click();
    backButton.click();
  } 
  if (previouslyPressed && !mousePressed) {
    previouslyPressed = false;
    if (backButton.release()) menuState = 0;
    if (playButton.release()){
      state = GAME;
      setupFace();
      if (!debug){
        song.loop();
      }
    }
    if (aboutButton.release()) menuState = 2;
    if (quitButton.release()){
      menuState = 3;
      exit();
    }
  }
}

void gameLogic(){
  collectControllerData();
  thread("bulletsThread");
  //Process takes a lot of CPU, so we initialize all threads before doing it
  currentFaceSuccess = faceInterface.process(debug);
  checkValues();
  //After that we ensure all threads have finished
  while (!bulletsThread){
  }
  if ((gameFace.getLeftEye().getHealth() <= 0 && gameFace.getRightEye().getHealth() <= 0) || ship.getHealth() <= 0){
    state = POSTGAME;
    song.stop();
    if (ship.getHealth() <= 0){
      sadSound.play();
    }else{
      happySound.play();
    }
  }
}

void checkValues(){
  //If the interface can't get a new functional frame we use the last one
  if (currentFaceSuccess){
    currentFace = faceInterface.copyFace();
  }else{
    currentFace = lastUsableFace;
  }
  copyElements(currentFace);
  normalizeElements(currentFace);
  //If the distance between the current face and the one from the last frame is too big
  //it means that there is a "ghost", so we use the last face we detected
  float distance = dist(currentFace.getCenter().x, currentFace.getCenter().y,
                        lastUsableFace.getCenter().x , lastUsableFace.getCenter().y);
  int currentTime = millis();
  if (maxDistance < distance){
    if (currentTime - timeFromLastFace < waitForNewFaceTime){
      currentFace = lastUsableFace;
    }
  }else{
    if (currentFaceSuccess){
      timeFromLastFace = millis();
    }
  }
}

synchronized void checkHitbox(RealFace face){

}

//Show

void introShow(){
  String[] text = {"ESTADO EN DESUSO"};
  printText(text);
}

void menuShow(){
  /**Desactivar todos los botones existentes antes del switch
   *No desactivarlos provoca que se puedan clickar incluso sin
   *ser visibles*/
  playButton.disable();
  aboutButton.disable();
  quitButton.disable();

  switch(menuState) {
    case 0:
      //main menu
      pushMatrix();
      pushStyle();
      textAlign(CENTER, TOP);
      textSize(50);
      text("THE MIRACLE", width/2, 90);
      popStyle();
  
      playButton.display("Play", width/2 - width/6, 210, width/3, 50);
      aboutButton.display("About", width/2 - width/6, 270, width/3, 50);
      quitButton.display("Quit", width/2 - width/6, 330, width/3, 50);
      popMatrix();
      break;
    case 1:
      pushMatrix();
      pushStyle();
      textAlign(CENTER, TOP);
      textSize(50);
      text("Play", width/2, 90);
      popStyle();
      backButton.display("Back", width/2 - width/6, 330, width/3, 50);
      popMatrix();
      break;
    case 2:
      pushMatrix();
      pushStyle();
      textAlign(CENTER, TOP);
      textSize(50);
      text("About", width/2, 90);
      textAlign(CENTER,CENTER);
      textSize(15);
      text("Game by:", width/2, height/2 - 50);
      text("\nInspired by the bullet hell genre.", width/2, height/2 + 100);
      
      textSize(20);
      text("\nChristian García Viguera" +
        "\nPablo Morales Gómez"+
        "\nPablo Ortigosa Quevedo", width/2, height/2);
  
      popStyle();
      backButton.display("Back", width/2 - width/6, height/2 + 150, width/3, 50);
      popMatrix();
      break;
    case 3:
      pushMatrix();
      pushStyle();
      textAlign(CENTER, TOP);
      textSize(50);
      text("yo u pressed quit?", width/2, 90);
      popStyle();
  
      popMatrix();
      break;
  }

  circle(mouseX, mouseY, 10);
}

void gameShow(){
  gameFaceShow();

  fill(255,0,20);
  //Damaged left eye
  if (gameFace.getLeftEye().getHealth() == 0){
    beginShape();
      for (int i = 0; i < leftEye.length; i++) {
        vertex(leftEye[i].x, leftEye[i].y);
      }
    endShape();
  }

  //Damaged right eye
  if (gameFace.getRightEye().getHealth() == 0){
    beginShape();
      for (int i = 0; i < rightEye.length; i++) {
        vertex(rightEye[i].x, rightEye[i].y);
      }
    endShape();
  }

  objController.dibuja();

  leftEyeBar.setCurrent(gameFace.getLeftEye().getHealth());
  rightEyeBar.setCurrent(gameFace.getRightEye().getHealth());

  shipBar.setCurrent(ship.getHealth());
  int defaultSeparator = 20;
  int eyeBarXSize = 200;
  leftEyeBar.show("Crazy eye",
                  defaultSeparator, defaultSeparator,
                  eyeBarXSize, 20, 0, 0);
  rightEyeBar.show("Master eye",
                  defaultSeparator*2 + eyeBarXSize, defaultSeparator,
                  eyeBarXSize, 20, 0, 0);
  int shipBarYSize = 20;
  shipBar.show("XE-991",
              defaultSeparator, height - shipBarYSize - 40,
              200, shipBarYSize, 0, 0);
}

void gameFaceShow(){
  //Face
  PImage currentFaceImage;
  currentFaceImage = currentFace.getCrop();
  float imgWidth = faceWidthShow;
  float imgHeight = imgWidth/currentFace.getCropRatio();
  image(currentFaceImage,
        (float) width/2 - imgWidth/2,(float) height/2 - imgHeight/2,
        imgWidth, imgHeight);
}

void postgameShow(){
  pushStyle();
  int titleHeight = 70;
  textAlign(CENTER, TOP);
  textSize(titleHeight);
  String text;
  if (ship.getHealth() <= 0){
    text = "FACE WINS";
  }else{
    text = "SHIP WINS";
  }
  stroke(255);
  fill(255);
  text(text, width/2, height/2 - titleHeight/2);
  popStyle();
}

void printText(String[] text){
  pushStyle();
  textMode(MODEL);
  textSize(20);
  fill(palette.getText());
  for (int i = 0; i < text.length; i++){
    text(text[i], 10, 25*(i+1));
  }
  popStyle();
}



//Threads

synchronized void bulletsThread(){
  bulletsThread = false;

  float mouthDist = dist(mouth[3].x, mouth[3].y, mouth[9].x, mouth[9].y);
  float leftEyeDist = dist(leftEye[5].x, leftEye[5].y, leftEye[1].x, leftEye[1].y);
  float rightEyeDist = dist(rightEye[4].x, rightEye[4].y, rightEye[2].x, rightEye[2].y);
  float mouthThreshold = 27;
  float eyeThreshold = 7.3; //6.3; //0.11; //0.105?


  boolean mouthOpen = mouthThreshold < mouthDist;
  boolean rightEyeOpen = eyeThreshold < rightEyeDist;
  boolean leftEyeOpen = eyeThreshold < leftEyeDist;
  println(leftEyeDist);
  println(rightEyeDist);
  RealFace face = currentFace;
  if (mouthOpen){
    if ((rightEyeOpen && 0 < gameFace.getRightEye().getHealth()) ||
        (leftEyeOpen && 0 < gameFace.getLeftEye().getHealth())){
      PVector center = new PVector((mouth[9].x + mouth[3].x) / 2,
        (mouth[9].y + mouth[3].y) / 2);
      objController.faceShoot(center);
    }
  }

  objController.checkController(lastControllerData, currentControllerData);
  objController.moveBullets();
  if (leftEyeOpen && gameFace.getLeftEye().getHealth() != 0){
    objController.checkEyeCollision(leftEye, gameFace.getLeftEye());
  }

  if (rightEyeOpen && gameFace.getRightEye().getHealth() != 0){
    objController.checkEyeCollision(rightEye, gameFace.getRightEye());
  }
  objController.checkCircleCollision();
  bulletsThread = true;
}