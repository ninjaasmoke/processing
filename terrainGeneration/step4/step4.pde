int cols, rows;
int scl = 20;
int w = 2000;
int h = 1600;

float[][] terrain;
float fly = 0;

void setup() {
  size(600, 600, P3D);

  cols = w/scl;
  rows = h/scl;
  
  terrain = new float[cols][rows];
  
}

void draw() {
  fly += 0.04;
  
  float yOff = fly;
  for (int y = 0; y < rows; y++) {
    float xOff = 0;
    for (int x = 0; x < cols; x ++) {
      terrain[x][y] = map(noise(xOff,yOff), 0, 1, -100, 100);
      xOff += 0.1;
    }
    yOff -=0.1;
  }

  background(255);
  stroke(20);
  noFill();
  
  translate(width/2, height/2+50);
  rotateX(PI/2.4);
  
  translate(-w/2, -h/2);
  
  for (int y = 0; y < rows -1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x ++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl,terrain[x][y+1]);
    }
    endShape();
  }
}
