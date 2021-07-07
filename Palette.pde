class Palette{
  color background;
  color text;
  color backgroundAlt;
  color textAlt;
  color extra;
  color extraAlt;
  
  Palette(color background, color text, color backgroundAlt, color textAlt, color extra, color extraAlt){
    this.background = background;
    this.text = text;
    this.backgroundAlt = backgroundAlt;
    this.textAlt = textAlt;
    this.extra = extra;
    this.extraAlt = extraAlt;
  }
  
  color getBackground(){
    return background;
  }
  
  color getText(){
    return text;
  }
  
  color getBackgroundAlt(){
    return backgroundAlt;
  }
  
  color getTextAlt(){
    return textAlt;
  }

  color getExtra(){
    return extra;
  }

  color getExtraAlt(){
    return extraAlt;
  }
}
