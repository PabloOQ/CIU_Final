import processing.serial.*;

Serial controllerSerial;
Controller controllerData;
PVector[] polygon;

FaceController faceInterface;

void setup(){
  size(640,480);
  //println(Serial.list());
  /*controllerSerial = new Serial(this, Serial.list()[2], 9600);
  controllerSerial.bufferUntil('¿');
  controllerData = new Controller();*/

  
  faceInterface = new FaceController(this, "DroidCam Source 3");


  polygon = new PVector[]{new PVector(300,200),
                          new PVector(100,500),
                          new PVector(400,700)};

  //frameRate(30);
}

void draw(){
  collectData();

  background(0);

  faceInterface.getCrop(width/2, height/2);

  PVector[] leftEye = faceInterface.getLeftEye().getContour();

  PVector leftEyeRelative = Expressions.makeRelative(faceInterface.getLeftEye().getCenter(), faceInterface.getCenter());



  fill(0,0,255);
  noStroke();
  beginShape();
  for (int i = 0; i < leftEye.length; i++) {
    leftEye[i] = Expressions.makeRelative(leftEye[i], faceInterface.getCenter());
    leftEye[i].x = width/2 + leftEye[i].x;
    leftEye[i].y = height/2 + leftEye[i].y;

    vertex(leftEye[i].x, leftEye[i].y);
  }
  endShape();

  stroke(255,255,0);
  if (Collisions.circleWithPolygon(new PVector(mouseX, mouseY), 10, leftEye)){
    fill(255,0,0);
  }else{
    fill(0,255,0);
  }

  circle(mouseX, mouseY, 20);
}

void serialEvent(Serial port){
  String received = port.readStringUntil('¿');
  controllerData.parseInputs(received);
}

void collectData(){
  //collectControllerData();
  faceInterface.process();
}

void collectControllerData(){
  controllerSerial.write("monitor\r");
  //We need to wait a little, when this data is needed wait until controllerData.getUpToDate() is true
  //Usually 10ms
}
