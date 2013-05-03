class DynamicText extends LXPattern {
  String message = "Mayhem Everywhere";
  final SinLFO yoffset = new SinLFO(260, 160, 30000);
  final SinLFO xoffset = new SinLFO(-50, 50, 23000);
  
  void showMessage(){
    fill(255,255,150);
    if(args.length > 0){
    text(args[0], 10,40);
    }
    else{
      text(message, 10,40);
    }
    //println(lx.height/2 + "  " + lx.width/2);
  }
  
  DynamicText(HeronLX lx){
    super(lx);
    addModulator(xoffset).trigger();
    addModulator(yoffset).trigger();
  }
  
  public void run(int deltaMs) {
    showMessage();
  }
}
