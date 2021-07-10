int cols, rows;
int scl = 20; // 20 pixels scale for each polygon
int w = 2000;
int h = 2000;

float flying = 0;

float[][] terrain;

int r = 155, g = 118, b = 83;

void setup() {
  frameRate(60);
  fullScreen(P3D);
  w = width * 2 + 200;
  //size(width, height, P3D);
  cols = w / scl;
  rows = h /scl;
  
  terrain = new float[cols][rows];
}

void draw() {
  
  flying -= 0.04;
  
  float yOff = flying;
  for(int y = 0; y < rows; y++) {
    float xOff = 0;
    for(int x = 0; x < cols; x ++) {
      terrain[x][y] = map(noise(xOff, yOff), 0, 1, -100, 100); // noise = perlin noise
      xOff += 0.1;
    }
    yOff += 0.1;
  }
  
  background(135, 206, 235);
  stroke(r-30, g-30, b-30);
  noFill();
  
  translate(width/2, height/2); // translate plane to center
  rotateX(PI/3); // rotate plane for viewer
  translate(-w/2, -h/2 + 100);
  
  for(int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for(int x = 0; x < cols; x ++) {
      // Create mesh of triangles
      //vertex(x*scl, y*scl);
      //vertex(x*scl, (y+1)*scl);

      // Add some random z value to vertices to make shape
      // x & y vals are fixed
      // z vals need to be changed by some algo 
      vertex(x*scl, y*scl, terrain[x][y]);
      fill(r,g,b);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      
    }
    endShape();
  }
}
