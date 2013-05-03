class DynamicText extends LXPattern {
  String message = "Mayhem Everywhere";
  final SinLFO yoffset = new SinLFO(260, 160, 30000);
  final SinLFO xoffset = new SinLFO(-50, 50, 23000);
  
  DynamicText(HeronLX lx){
    super(lx);
    addModulator(xoffset).trigger();
    addModulator(yoffset).trigger();
  }
  
  void showMessage(){
    fill(255,255,150);
    String tempMessage = args.length > 0 ? args[0] : message;
    text(tempMessage, 10, 40);
    }
    //println(lx.height/2 + "  " + lx.width/2);
  }
  

  
  public void run(int deltaMs) {
    showMessage();
  }
}
