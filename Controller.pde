import processing.serial.*;

class Controller{
  final int ADC_L_TRIG = 0;
  final int ADC_R_TRIG = 1;
  final int L_TRIG = 2;
  final int R_TRIG = 3;
  final int L_BUMP = 4;
  final int R_BUMP = 5;
  final int L_TRACK_X = 6;
  final int L_TRACK_Y = 7;
  final int R_TRACK_X = 8;
  final int R_TRACK_Y = 9;
  final int L_TRACK_CLICK = 10;
  final int L_FRONT = 11;
  final int STEAM_B = 12;
  final int R_FRONT = 13;
  final int R_TRACK_CLICK = 14;
  final int JOY_X = 15;
  final int JOY_Y = 16;
  final int JOY_CLICK = 17;
  final int X_B = 18;
  final int Y_B = 19;
  final int A_B = 20;
  final int B_B = 21;
  final int L_GRIP = 22;
  final int R_GRIP = 23;
  
  int[] inputs = new int[24];

  public Controller(){
    //default values (inactive)  ranges
    inputs[ADC_L_TRIG] = 356;    //355-57(39) click at 129-115-100
    inputs[ADC_R_TRIG] = 659;    //659-918(930) click at 853-870
    inputs[L_TRACK_X] = 600;     //150-1160
    inputs[L_TRACK_Y] = 350;     //0-650
    inputs[R_TRACK_X] = 600;
    inputs[R_TRACK_Y] = 350;
    inputs[JOY_X] = 540;        //812-240
    inputs[JOY_Y] = 486;        //234-776
  }

  void parseInputs(String text){
    int index = text.indexOf('\n') + 3;
    for (int i = 0; i < inputs.length; i++){
      inputs[i] = int(text.substring(index,text.indexOf(' ',index)));
      index = text.indexOf(' ',index) + 1;
    }
  }

  public int[] getData(){
    int[] res = new int[inputs.length];
    System.arraycopy(inputs, 0, res, 0, inputs.length);
    return res;
  }
  
  public int getADC_L_TRIG(){
    return inputs[ADC_L_TRIG];
  }

  public int getADC_R_TRIG(){
    return inputs[ADC_R_TRIG];
  }

  public int getL_TRIG(){
    return inputs[L_TRIG];
  }

  public int getR_TRIG(){
    return inputs[R_TRIG];
  }

  public int getL_BUMP(){
    return inputs[L_BUMP];
  }

  public int getR_BUMP(){
    return inputs[R_BUMP];
  }

  public int getL_TRACK_X(){
    return inputs[L_TRACK_X];
  }

  public int getL_TRACK_Y(){
    return inputs[L_TRACK_Y];
  }

  public int getR_TRACK_X(){
    return inputs[R_TRACK_X];
  }

  public int getR_TRACK_Y(){
    return inputs[R_TRACK_Y];
  }

  public int getL_TRACK_CLICK(){
    return inputs[L_TRACK_CLICK];
  }

  public int getL_FRONT(){
    return inputs[L_FRONT];
  }

  public int getSTEAM_B(){
    return inputs[STEAM_B];
  }

  public int getR_FRONT(){
    return inputs[R_FRONT];
  }

  public int getR_TRACK_CLICK(){
    return inputs[R_TRACK_CLICK];
  }

  public int getJOY_X(){
    return inputs[JOY_X];
  }

  public int getJOY_Y(){
    return inputs[JOY_Y];
  }

  public int getJOY_CLICK(){
    return inputs[JOY_CLICK];
  }

  public int getX_B(){
    return inputs[X_B];
  }

  public int getY_B(){
    return inputs[Y_B];
  }

  public int getA_B(){
    return inputs[A_B];
  }

  public int getB_B(){
    return inputs[B_B];
  }

  public int getL_GRIP(){
    return inputs[L_GRIP];
  }

  public int getR_GRIP(){
    return inputs[R_GRIP];
  }
}
