import java.util.HashMap;

class DynamicText extends LXPattern {
  
  private static final String DEFAULT_STRING = "Mayhem Everywhere";
  private static final String ALPHA_NUMERIC = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
 
  private final CharCoordinate[] COORDINATES = new CharCoordinate[] {
    new CharCoordinate(  0,   0,  15,  17),
    new CharCoordinate( 24,   0,  13,  17),
    new CharCoordinate( 49,   0,  15,  17),
    new CharCoordinate( 76,   0,  90,  17)
  };
  
  private final SinLFO xOffset;
  private final SinLFO yOffset;
  private final PImage alphaNumericImage;
  private final color transparent;
  private final HashMap alphaNumericMap;
    
  public DynamicText(HeronLX lx) {
    super(lx);
    xOffset = new SinLFO(-50, 50, 23000);
    yOffset = new SinLFO(260, 160, 30000);
    addModulator(xOffset).trigger();
    addModulator(yOffset).trigger();
    alphaNumericImage = loadImage("alpha.png");
    transparent = alphaNumericImage.get(0, 0);
    alphaNumericMap = new HashMap<String, CharCoordinate>();
    for (int i = 0; i < COORDINATES.length; i++) {
      alphaNumericMap.put(Character.toString(ALPHA_NUMERIC.charAt(i)), COORDINATES[i]);
    }
  }    
  
  public void run(int deltaMs) {
    fill(255,255,150);
    String message = args.length > 0 ? args[0] : DEFAULT_STRING;
    message = "ABCD";
    
    for (int i = 0; i < message.length(); i++) {
      String character = Character.toString(message.charAt(i));
      CharCoordinate coordinate = (CharCoordinate) alphaNumericMap.get(character);
      int xPos = coordinate.getX();
      int yPos = coordinate.getY();
      int width = coordinate.getWidth();
      int height = coordinate.getHeight();
      color transparent = alphaNumericImage.get(0, 0);
    
      for (int x = 0; x < width; ++x) {
        if (x + xPos < 0 || lx.width <= x + xPos) continue;
        for (int y = 0; y < height; ++y) {
          if (y + yPos < 0 || lx.height <= y + yPos) continue;
          if (alphaNumericImage.get(x, y) == transparent) continue;
          setColor(x + xPos, y + yPos, alphaNumericImage.get(x, y));
        }
      }
    }
  }
  
  public class CharCoordinate {
    
    private int mX;
    private int mY;
    private int mWidth;
    private int mHeight;
    
    public CharCoordinate(int x, int y, int width, int height) {
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
