import java.util.HashMap;

class DynamicText extends LXPattern {

  private static final String DEFAULT_STRING = "WELCOME TO CAFE 18";
  private static final String ALPHA_NUMERIC = " ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";

  private final SinLFO xOffset;
  private final SinLFO yOffset;
  private final PImage[] alphaNumericImages;
  private final PImage alphaNumericImageRed;
  private final PImage alphaNumericImageGreen;
  private final PImage alphaNumericImageBlue;
  private final PImage alphaNumericImageYellow;
  private final PImage alphaNumericImageViolet;
  private final PImage alphaNumericImageOrange;
  private final CharCoordinate[] coordinates;
  private final HashMap alphaNumericMap;
  
  int xPosition = -1000;
  int runNumber = 1;
  int xPos = 1;
  int offset = 0;
  int corLength = 0;
  int xFade = 1;
  int maxXPos = 0;

  /**
   * Animation that prints out the given message text.
   */
  public DynamicText(HeronLX lx) {
    super(lx);
    xOffset = new SinLFO(-50, 50, 23000);
    yOffset = new SinLFO(260, 160, 30000);
    addModulator(xOffset).trigger();
    addModulator(yOffset).trigger();
    alphaNumericImageRed = loadImage("alpha_red.png");
    alphaNumericImageGreen = loadImage("alpha_green.png");
    alphaNumericImageBlue = loadImage("alpha_blue.png");
    alphaNumericImageYellow = loadImage("alpha_yellow.png");
    alphaNumericImageViolet = loadImage("alpha_violet.png");
    alphaNumericImageOrange = loadImage("alpha_orange.png");
    alphaNumericImages = new PImage[] {
      alphaNumericImageRed, 
      alphaNumericImageGreen, 
      alphaNumericImageBlue, 
      alphaNumericImageYellow, 
      alphaNumericImageViolet, 
      alphaNumericImageOrange
    };
    coordinates = new CharCoordinate[] {
      new CharCoordinate( 15, 0, 9, 17), // " "
      new CharCoordinate(  0, 0, 15, 17), // A
      new CharCoordinate( 24, 0, 13, 17), 
      new CharCoordinate( 49, 0, 15, 17), 
      new CharCoordinate( 76, 0, 14, 17), 
      new CharCoordinate(103, 0, 13, 17), 
      new CharCoordinate(130, 0, 12, 17), // F
      new CharCoordinate(154, 0, 15, 17), 
      new CharCoordinate(182, 0, 14, 17), 
      new CharCoordinate(209, 0, 11, 17), 
      new CharCoordinate(  2, 28, 10, 17), // J
      new CharCoordinate( 23, 28, 14, 17), 
      new CharCoordinate( 49, 28, 13, 17), 
      new CharCoordinate( 74, 28, 16, 17), 
      new CharCoordinate(102, 28, 14, 17), 
      new CharCoordinate(128, 28, 16, 17), // O
      new CharCoordinate(155, 28, 14, 17), 
      new CharCoordinate(179, 28, 16, 19), 
      new CharCoordinate(204, 28, 14, 17), 
      new CharCoordinate(  1, 55, 12, 17), 
      new CharCoordinate( 24, 55, 13, 17), // T
      new CharCoordinate( 48, 55, 14, 17), 
      new CharCoordinate( 74, 55, 14, 17), 
      new CharCoordinate( 98, 55, 21, 17), 
      new CharCoordinate(130, 55, 12, 17), 
      new CharCoordinate(155, 55, 14, 17), 
      new CharCoordinate(179, 55, 12, 17), // Z
      new CharCoordinate(  2, 83, 5, 17), // 1
      new CharCoordinate( 20, 83, 12, 17), 
      new CharCoordinate( 43, 83, 12, 17), 
      new CharCoordinate( 65, 83, 14, 17), 
      new CharCoordinate( 89, 83, 12, 17), // 5
      new CharCoordinate(113, 83, 12, 17), 
      new CharCoordinate(137, 83, 11, 17), 
      new CharCoordinate(159, 83, 13, 17), 
      new CharCoordinate(181, 83, 14, 17), 
      new CharCoordinate(205, 83, 14, 17)  // 0
    };
    alphaNumericMap = new HashMap<String, CharCoordinate>();
    for (int i = 0; i < coordinates.length; i++) {
      alphaNumericMap.put(Character.toString(ALPHA_NUMERIC.charAt(i)), coordinates[i]);
    }
  }    

  public void run(int deltaMs) {
    fill(255, 255, 150);
    StringBuffer sb = new StringBuffer();
    if (args.length > 0) {
      sb.append(args[0]);
    } else {
      sb.append(DEFAULT_STRING);
    }
    sb.append(" ");
    String message = sb.toString();    

    xPos++;
    if (maxXPos < 2) { 
      runNumber = 0; 
      xPos = 0;
    };
    
    if (xPos%10 < 9) { 
      runNumber++; 
      offset++;
    }
    
    xPosition = (lx.width) - runNumber;
    corLength = corWidth(coordinates);

    for (int i = 0; i < message.length(); i++) {
      int index = i % alphaNumericImages.length;
      PImage alphaNumericImage = alphaNumericImages[index];
      color transparent = alphaNumericImage.get(0, 0);

      if (xPosition > lx.width - 1) {
        break;
      }

      String character = Character.toString(message.charAt(i));
      CharCoordinate coordinate = (CharCoordinate) alphaNumericMap.get(character);
      int xStart = coordinate.getX();
      int yStart = coordinate.getY();
      int width = coordinate.getWidth();
      int height = coordinate.getHeight();

      for (int x = 0; x < width; x++) {
        if (xPosition > lx.width - 1) {
          break;
        }

        for (int y = 0; y < height; y++) {
          if (y > lx.height - 1) {
            break;
          }

          if (alphaNumericImage.get(x, y) == transparent) {
            continue;
          }

          if (lx.width / 2 - runNumber < 0) { 
            if (xPosition < 0 || i == (message.length()) ) { 
              continue;
            }
            
            setColor(xPosition, y+3, alphaNumericImage.get(xStart + x, yStart + y));
          } else {
            setColor(xPosition, y+3, alphaNumericImage.get(xStart + x, yStart + y));
          }
        }

        xPosition++;
      }
      maxXPos = xPosition - 1;
    }
  }

  private int corWidth(CharCoordinate[] cor) {
    int corLength = 0;
    for (int i = 0; i < cor.length; i++) {
      corLength += cor[i].getWidth();
    }
    return corLength;
  }

  /**
   * Class to map the top left coordinate and dimension of a letter in the alpha-numeric picture.
   */
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

