class DynamicText extends LXPattern {
  String message = "Mayhem Everywhere";

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
  }
  
  public void run(int deltaMs) {
    showMessage();
  }
}
