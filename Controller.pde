import processing.serial.*;

class Controller{
  public static final int ADC_L_TRIG = 0;
  public static final int ADC_R_TRIG = 1;
  public static final int L_TRIG = 2;
  public static final int R_TRIG = 3;
  public static final int L_BUMP = 4;
  public static final int R_BUMP = 5;
  public static final int L_TRACK_X = 6;
  public static final int L_TRACK_Y = 7;
  public static final int R_TRACK_X = 8;
  public static final int R_TRACK_Y = 9;
  public static final int L_TRACK_CLICK = 10;
  public static final int L_FRONT = 11;
  public static final int STEAM_B = 12;
  public static final int R_FRONT = 13;
  public static final int R_TRACK_CLICK = 14;
  public static final int JOY_X = 15;
  public static final int JOY_Y = 16;
  public static final int JOY_CLICK = 17;
  public static final int X_B = 18;
  public static final int Y_B = 19;
  public static final int A_B = 20;
  public static final int B_B = 21;
  public static final int L_GRIP = 22;
  public static final int R_GRIP = 23;

  //default values (inactive)  ranges
  public static final int DEFAULT_ADC_L_TRIG = 356; //355-57(39) click at 129-115-100
  public static final int DEFAULT_ADC_R_TRIG = 659; //659-918(930) click at 853-870
  public static final int DEFAULT_L_TRACK_X = 600;  //150-1160
  public static final int DEFAULT_L_TRACK_Y = 350;  //0-650
  public static final int DEFAULT_R_TRACK_X = 600;
  public static final int DEFAULT_R_TRACK_Y = 350;
  public static final int DEFAULT_JOY_X = 540;      //812-240
  public static final int DEFAULT_JOY_Y = 486;      //234-776

  public static final int MAX_JOY_X = 812;
  public static final int MIN_JOY_X = 240;
  public static final int MAX_JOY_Y = 776;
  public static final int MIN_JOY_Y = 234;
  /*public static final int MAP_MAX_JOY_X;
  public static final int MAP_MIN_JOY_X;
  public static final int MAP_MAX_JOY_Y;
  public static final int MAP_MIN_JOY_Y;*/

  private volatile boolean updated = true;

  volatile int[] inputs = new int[24];

  /*static {
    MAP_MAX_JOY_X = ;
    MAP_MIN_JOY_X = ;
    MAP_MAX_JOY_Y = ;
    MAP_MIN_JOY_Y = ;
  }*/

  public Controller(){
    inputs[ADC_L_TRIG] = 356;
    inputs[ADC_R_TRIG] = 659;
    inputs[L_TRACK_X] = 600;
    inputs[L_TRACK_Y] = 350;
    inputs[R_TRACK_X] = 600;
    inputs[R_TRACK_Y] = 350;
    inputs[JOY_X] = 540;
    inputs[JOY_Y] = 486;
  }

  public synchronized void parseInputs(String text){
    int index = text.indexOf('\n') + 3;
    for (int i = 0; i < inputs.length; i++){
      inputs[i] = int(text.substring(index,text.indexOf(' ',index)));
      index = text.indexOf(' ',index) + 1;
    }
  }

  public synchronized void updateData(Controller newController){
/*    println("before");
    for (int i = 0; i < inputs.length; i++) {
      println("[" + i + "]: " + inputs[i]);
    }
    println("l_bump :" + inputs[L_BUMP]);*/
    System.arraycopy(newController.retrieveData(), 0, inputs, 0, inputs.length);
    /*println("after");
    println("l_bump :" + inputs[L_BUMP]);
    for (int i = 0; i < inputs.length; i++) {
      println("[" + i + "]: " + inputs[i]);
    }*/
  }

  private synchronized int[] retrieveData(){
    return inputs;
  }

  public synchronized void setUpdated(boolean val){
    updated = val;
  }

  public synchronized boolean getUpdated(){
    return updated;
  }

  public synchronized int[] getData(){
    int[] res = new int[inputs.length];
    System.arraycopy(inputs, 0, res, 0, inputs.length);
    return res;
  }
  
  public synchronized int getADC_L_TRIG(){
    return inputs[ADC_L_TRIG];
  }

  public synchronized int getADC_R_TRIG(){
    return inputs[ADC_R_TRIG];
  }

  public synchronized int getL_TRIG(){
    return inputs[L_TRIG];
  }

  public synchronized int getR_TRIG(){
    return inputs[R_TRIG];
  }

  public synchronized int getL_BUMP(){
    return inputs[L_BUMP];
  }

  public synchronized int getR_BUMP(){
    return inputs[R_BUMP];
  }

  public synchronized int getL_TRACK_X(){
    return inputs[L_TRACK_X];
  }

  public synchronized int getL_TRACK_Y(){
    return inputs[L_TRACK_Y];
  }

  public synchronized int getR_TRACK_X(){
    return inputs[R_TRACK_X];
  }

  public synchronized int getR_TRACK_Y(){
    return inputs[R_TRACK_Y];
  }

  public synchronized int getL_TRACK_CLICK(){
    return inputs[L_TRACK_CLICK];
  }

  public synchronized int getL_FRONT(){
    return inputs[L_FRONT];
  }

  public synchronized int getSTEAM_B(){
    return inputs[STEAM_B];
  }

  public synchronized int getR_FRONT(){
    return inputs[R_FRONT];
  }

  public synchronized int getR_TRACK_CLICK(){
    return inputs[R_TRACK_CLICK];
  }

  public synchronized int getJOY_X(){
    return inputs[JOY_X];
  }

  public synchronized int getJOY_Y(){
    return inputs[JOY_Y];
  }

  public synchronized int getJOY_CLICK(){
    return inputs[JOY_CLICK];
  }

  public synchronized int getX_B(){
    return inputs[X_B];
  }

  public synchronized int getY_B(){
    return inputs[Y_B];
  }

  public synchronized int getA_B(){
    return inputs[A_B];
  }

  public synchronized int getB_B(){
    return inputs[B_B];
  }

  public synchronized int getL_GRIP(){
    return inputs[L_GRIP];
  }

  public synchronized int getR_GRIP(){
    return inputs[R_GRIP];
  }
}
