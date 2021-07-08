static class Collisions{
  //Si el punto es relativo al ojo se puede evitar hacer la suma pos.x

  static public boolean pointWithRecangle(PVector point, PVector recPos, PVector recSize){
    return  recPos.x - recSize.x <= point.x &&
            point.x <= recPos.x + recSize.x &&
            recPos.y - recSize.y <= point.y &&
            point.y <= recPos.y + recSize.y;
  }

  //FIXME innecesario?
  static public boolean pointLeftOfLine(PVector point, PVector linePointA, PVector linePointB){
    if (linePointA.x == linePointB.x){
      //Remove?
      return point.x <= linePointA.x;
    }else{
      if((linePointB.x < linePointA.x && linePointA.y < linePointB.y) ||
          (linePointA.x < linePointB.x && linePointB.y < linePointA.y)){
        return pointBottomOfLine(point, linePointA, linePointB);
      }else{
        return pointTopOfLine(point, linePointA, linePointB);
      }
    }
  }

  static public boolean pointRightOfLine(PVector point, PVector linePointA, PVector linePointB){
    if (linePointA.x == linePointB.x){
      //si no comprobamos el tamaño de la elipse en pointWithAngledEllipse por qué deberíamos comprobar aquí que 2 puntos no estén en la misma x
      return linePointA.x <= point.x;
    }else{
      if((linePointB.x < linePointA.x && linePointA.y < linePointB.y) ||
          (linePointA.x < linePointB.x && linePointB.y < linePointA.y)){
        return pointTopOfLine(point, linePointA, linePointB);
      }else{
        return pointBottomOfLine(point, linePointA, linePointB);
      }
    }
  }

  static public boolean pointBottomOfLine(PVector point, PVector linePointA, PVector linePointB){
    return point.y - linePointA.y <= ((linePointB.y - linePointB.y) / (linePointB.x - linePointB.x))*(point.x - linePointA.x);
  }

  static public boolean pointTopOfLine(PVector point, PVector linePointA, PVector linePointB){
    return point.y - linePointA.y >= ((linePointB.y - linePointB.y) / (linePointB.x - linePointB.x))*(point.x - linePointA.x);
  }

  static public boolean pointInLineSegment(PVector point, PVector linePointA, PVector linePointB){
    float buffer = 0.1;
    float lineLen = dist(linePointA.x, linePointA.y, linePointB.x , linePointB.y);
    float d1 = dist(point.x, point.y, linePointA.x, linePointA.y);
    float d2 = dist(point.x, point.y, linePointB.x, linePointB.y);
    if (d1+d2 >= lineLen-buffer && d1+d2 <= lineLen+buffer) {
      return true;
    }
    return false;
  }

  static public boolean pointInLine(PVector point, PVector linePointA, PVector linePointB){
    return point.y - linePointA.y == ((linePointB.y - linePointB.y) / (linePointB.x - linePointB.x))*(point.x - linePointA.x);
  }
    
  static public boolean pointWithPolygon(PVector point, PVector[] polygon){
    boolean col = false;

    int next = 0;
    for (int current = 0; current < polygon.length; current++){
      next = current + 1;
      if (next == polygon.length){
        next = 0;
      }
      if (((polygon[current].y >= point.y && polygon[next].y < point.y) ||
        (polygon[current].y < point.y && polygon[next].y >= point.y)) &&
        (point.x < (polygon[next].x - polygon[current].x) * (point.y - polygon[current].y) / (polygon[next].y - polygon[current].y) + polygon[current].x)){
        col = !col;
      }
    }
    return col;
  }

  //FIXME: división por 0
  //se podría comprobar antes de llamar, ninguna elipse tiene tamaño 0
  static public boolean pointWithAngledEllipse(PVector point, PVector ellPos, PVector ellSize, float ellRads){
    return (pow(((point.x - ellPos.x)*cos(ellRads)-(point.y-ellPos.y)*sin(ellRads)),2)/ pow(ellSize.x,2)) +
           (pow(((point.x - ellPos.x)*sin(ellRads)-(point.y-ellPos.y)*cos(ellRads)),2)/ pow(ellSize.y,2)) <= 1;
  }

  static public boolean pointWithCircle(PVector point, PVector cirPos, float radius){
    return dist(point.x, point.y, cirPos.x, cirPos.y) <= radius;
  }

  //LineWith
  static public boolean lineSegmentWithCircle(PVector linePointA, PVector linePointB, PVector cirPos, float radius){
    //Checking if collides with border
    if (pointWithCircle(linePointA, cirPos, radius) || pointWithCircle(linePointB, cirPos, radius)){
      return true;
    }
    PVector aux = new PVector(linePointA.x - linePointB.x, linePointA.y - linePointB.y);
    float lineLen = sqrt(aux.x*aux.x + aux.y*aux.y);

    float dot = (((cirPos.x - linePointA.x) * (linePointB.x - linePointA.x)) +
                ((cirPos.y - linePointA.y) * (linePointB.y - linePointA.y))) /
                (lineLen*lineLen);

    PVector closest = new PVector(linePointA.x + (dot * (linePointB.x - linePointA.x)),
                                  linePointA.y + (dot * (linePointB.y - linePointA.y)));

    if (!pointInLineSegment(closest, linePointA, linePointB)){
      return false;
    }

    aux = new PVector(closest.x - cirPos.x, closest.y - cirPos.y);
    float distToLine = sqrt(aux.x*aux.x + aux.y*aux.y);

    return distToLine <= radius;
  }

  //remember to check if radius is the param you are using
  static public boolean circleWithCircle(PVector cirAPos, float radiusA, PVector cirBPos, float radiusB){    
    if (dist(cirAPos.x, cirAPos.y, cirBPos.x, cirBPos.y) <= radiusA + radiusB){
      return true;
    }else{
      return false;
    }
  }


  static public boolean circleWithPolygon(PVector cirPos, float radius, PVector[] polygon){
    boolean collision = false;
    int j;
    for (int i = 0; i < polygon.length; i++) {
      j = i + 1;
      if (j == polygon.length){
        j = 0;
      }

      PVector current = polygon[i];
      PVector next = polygon[j];

      if (lineSegmentWithCircle(current, next, cirPos, radius)){
        return true;
      }
    }
    return pointWithPolygon(cirPos, polygon);
    //return false;
  }

}