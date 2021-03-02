public class Rover {
  private int x, y;
  private final int SPEED = 3, SIZE = 10;
  private color c = #FF0000;
  private ArrayList<PVector> locations = new ArrayList();

  public Rover(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public void move() {
    PVector direction = pickDirection(getNearby(getTerrain()));
    x += direction.x * SPEED;
    y += direction.y * SPEED;
    locations.add(new PVector(x, y));
  }

  private PVector pickDirection(float[][] nearby) {
    float[][] diffs = new float[nearby.length][nearby[0].length];
    float myHeight = nearby[1][1];
    for (int row = 0; row < nearby.length; row++) {
      for (int col = 0; col < nearby[0].length; col++) {
        diffs[row][col] = abs(nearby[row][col] - myHeight);
      }
    }
    float min = 255;
    PVector direction = null;
    boolean finished = false;
    int count = 0;
    while (finished == false) {
      System.out.println("Try Pick Direction");
      if (count >= 8) locations.clear();
      for (int row = 0; row < nearby.length; row++) {
        for (int col = 0; col < nearby[0].length; col++) {
          if (row == 1 && col == 1) continue;
          float diff = diffs[row][col];
          //look for element in arraylist
          boolean beenThereDoneThat = false;
          PVector tryDirection = new PVector (col-1, row-1);
          for (PVector location : locations) {
            if (beenThereDoneThat(location, tryDirection)) {
              beenThereDoneThat = true;
              break;
            }
          }
          if (!beenThereDoneThat) {
            finished = true;
          }
          if (diff < min && !beenThereDoneThat) {
            min = diff;
            direction = tryDirection;
          }
        }
      }
      if (direction !=null) {
       finished = true; 
      }
      count ++;
    }
    return direction;
  }

  private boolean beenThereDoneThat(PVector l, PVector d) {
    return (x + d.x *SPEED == l.x && y+d.y * SPEED == l.y);
  }

  public float[][] getNearby(float[][] terrain) {
    float[][] nearby = new float[3][3];
    int xi = (int)(this.x/3);
    int yi = (int)(this.y/3);
    for (int i = 0; i < nearby.length; i++) {
      for (int j = 0; j<nearby[0].length; j++) {
        nearby[i][j] = terrain[yi+i-1][xi+j-1];
      }
    }    
    return nearby;
  }

  public void draw() {
    fill(c);
    circle(x, y, SIZE);
  }
}
