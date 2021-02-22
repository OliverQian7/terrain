public class Rover {
  private int x, y;
  private final int SPEED = 3, SIZE = 10;
  private color c = #FF0000;
  public Rover(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  public void move() {
   PVector direction = pickDirection(getNearby(getTerrain()));
   x += direction.x * SPEED;
   y += direction.y * SPEED;
  }
  
  private PVector pickDirection(float[][] nearby) {
    float[][] diffs = new float[nearby.length][nearby[0].length];
    float myHeight = nearby[1][1];
    for(int row = 0; row < nearby.length; row++) {
      for(int col = 0; col < nearby[0].length; col++) {
        diffs[row][col] = abs(nearby[row][col] - myHeight);
      }
    }
    float min = 0;
    PVector direction = null;
    for(int row = 0; row < nearby.length; row++) {
      for(int col = 0; col < nearby[0].length; col++) {
        if (row == 1 && col == 1) continue;
        float diff = diffs[row][col];
        if (diff > min){
          min = diff;
          direction = new PVector(col-1, row-1);
        }
      }
    }   
    return direction;
  }
  public float[][] getNearby(float[][] terrain) {
    float[][] nearby = new float[3][3];
    int xi = (int)(this.x/3);
    int yi = (int)(this.y/3);
    nearby[1][1] = terrain[yi][xi];
    nearby[0][0] = terrain[yi-1][xi-1];
    nearby[1][0] = terrain[yi][xi-1];
    nearby[2][0] = terrain[yi+1][xi-1];
    nearby[0][1] = terrain[yi-1][xi];
    nearby[0][2] = terrain[yi-1][xi+1];
    nearby[1][2] = terrain[yi][xi+1];
    nearby[2][1] = terrain[yi+1][xi];
    nearby[2][2] = terrain [yi+1][xi+1];
    return nearby;
  }
  
  public void draw() {
   fill(c);
   circle(x,y,SIZE);
  }
}
