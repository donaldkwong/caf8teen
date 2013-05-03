import java.util.HashMap;

class DynamicText extends LXPattern {
  
  private static final String DEFAULT_STRING = "Mayhem Everywhere";
  private static final String ALPHA_NUMERIC = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
 
  private final int[][] COORDINATES = new int[][] {
    {   0,   0,  15,  17 },
    {  24,   0,  13,  17 }
  };
  
  private final SinLFO xOffset;
  private final SinLFO yOffset;
  private final PImage alphaNumericImage;
  private final HashMap alphaNumericMap;
    
  public DynamicText(HeronLX lx) {
    super(lx);
    xOffset = new SinLFO(-50, 50, 23000);
    yOffset = new SinLFO(260, 160, 30000);
    addModulator(xOffset).trigger();
    addModulator(yOffset).trigger();
    alphaNumericImage = loadImage("alpha.png");
    alphaNumericMap = new HashMap<String, int[]>();
    alphaNumericMap.put("A", COORDINATES[0]);
    alphaNumericMap.put("B", COORDINATES[1]);
  }    
  
  private void showMessage() {
    fill(255,255,150);
    String message = args.length > 0 ? args[0] : DEFAULT_STRING;
    text(message, 10, 40);
    //println(lx.height/2 + "  " + lx.width/2);
  }
  
  public void run(int deltaMs) {
    showMessage();
    
    int[] coordinates = (int[]) alphaNumericMap.get("A");
    int xPos = coordinates[0];
    int yPos = coordinates[1];
    int width = coordinates[2];
    int height = coordinates[3];
    color transparent = alphaNumericImage.get(0, 0);
    
    for (int x = 0; x < width; ++x) {
        if (x + xPos < 0 || lx.width <= x + xPos) continue;
        for (int y = 0; y < height; ++y) {
          if (y + yPos < 0 || lx.height <= y + yPos) continue;
          if (alphaNumericImage.get(x, y) == transparent) continue;
          setColor(x + xPos, y + yPos, alphaNumericImage.get(x, y));
        }
      }
    
    
    
    
//    setColor(0, 0, color(210, 100, 40));
  }
  
  public class CharData {
    
    private int mX;
    private int mY;
    private int mWidth;
    private int mHeight;
    
    public CharData(int x, int y, int width, int height) {
      mX = x;
      mY = y;
      mWidth = width;
      mHeight = height; 
    }
    
    public int getX() {
      return mX;
    }
    
    public int getY() {
      return mY;
    }
    
    public int getWidth() {
      return mWidth;
    }
    
    public int getHeight() {
      return mHeight;
    }
  }
}
