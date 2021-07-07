static class MathUtils{
  static public int angle(int x, int y){
    int angle;
    if (x != 0){
      angle = (int) (atan2(y,x) * 180 / PI);
    } else {
      if (y > 0){
        angle = 90;
      }else{
        angle = -90;
      }
    }
    return angle;
  }
}