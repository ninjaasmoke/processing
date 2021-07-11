int cols, rows;
int scl = 20; // 20 pixels scale for each polygon
int w = 2000;
int h = 2000;

float flying = 0;
float xD = 0;
float yD = 0;

float[][] terrain;

int r = 155, g = 118, b = 83;

int[] key_lookup = { LEFT, RIGHT, UP, DOWN };
boolean[] keys = { false, false, false, false };

void setup() {
  frameRate(60);
  fullScreen(P3D);
  w = width * 2 + 200;
  //size(width, height, P3D);
  cols = w / scl;
  rows = h /scl;

  terrain = new float[cols][rows];
}

void do_movement() {
  xD += (keys[0]?-1:0) + (keys[1]?1:0);
  yD += (keys[2]?-1:0) + (keys[3]?1:0);
}

void draw() {

  do_movement(); // adds arrow controls to movement

  float yOff = yD/10;
  for (int y = 0; y < rows; y++) {
    float xOff = xD/10;
    for (int x = 0; x < cols; x ++) {
      terrain[x][y] = map(noise(xOff, yOff), 0, 1, -150, 150); // noise = perlin noise
      xOff += 0.1;
    }
    yOff += 0.1;
  }

  background(135, 206, 235);
  stroke(r-40, g-40, b-40);
  noFill();

  textSize(12);
  text("Y: "+(-yD), 20, 20); 
  text("X: "+xD, 20, 40); 
  fill(0, 102, 153);

  translate(width/2, height/2); // translate plane to center
  rotateX(PI/3); // rotate plane for viewer
  translate(-w/2, -h/2 + 100);


  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x ++) {
      // Create mesh of triangles
      //vertex(x*scl, y*scl);
      //vertex(x*scl, (y+1)*scl);

      // Add some random z value to vertices to make shape
      // x & y vals are fixed
      // z vals need to be changed by some algo 
      vertex(x*scl, y*scl, terrain[x][y]);
      fill(r, g, b);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
}

void keyPressed() {
  k(true);
}

void keyReleased() {
  k(false);
}

void k(boolean b) {
  for ( int i = 0; i < key_lookup.length; i++) {
    if ( keyCode == key_lookup[i] ) {
      keys[i] = b;
    }
  }
}
