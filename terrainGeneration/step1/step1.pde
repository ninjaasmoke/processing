int cols, rows;
int scl = 20;

void setup() {
  size(600, 600, OPENGL);
  
  int w = 600;
  int h = 600;
  
  cols = w/scl;
  rows = h/scl;
}

void draw() {
  background(0);
  
    for (int y = 0; y < rows; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x ++) {
      stroke(255);
      noFill();
      vertex(x*scl, y*scl);
      vertex(x*scl, (y+1)*scl);
    }
    endShape();
  }
}
