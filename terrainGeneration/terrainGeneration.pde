int cols, rows;
int scl = 18; // pixels scale for each polygon
int w = 600;
int h = 1200;

float flying = 0;
float xD = 0;
float yD = 0;

float[][] terrain;

int r = 155, g = 118, b = 83;
int skyR = 35, skyG = 106, skyB = 135;

int[] key_lookup = { LEFT, RIGHT, UP, DOWN };
boolean[] keys = { false, false, false, false };

void setup() {
  frameRate(60);
  size(600, 600, P3D);
  //fullScreen(P3D);
  w = width * 2 + 200;
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
  yD -= 1; // comment for manual forward
  
  //yD *= 1.001; // auto acceleration
  
  //pointLight(255, 255, 255, width/2, 0, -100);
  lights();

  float yOff = yD / 10;
  for (int y = 0; y < rows; y++) {
    float xOff = xD / 10;
    for (int x = 0; x < cols; x ++) {
      terrain[x][y] = map(noise(xOff, yOff), 0, 1, -50, 160); // noise = perlin noise
      xOff += 0.1;
    }
    yOff += 0.1;
  }

  background(skyR, skyG, skyB);
  //stroke(r-40, g-40, b-40);
  noStroke();
  noFill();

  //textSize(16);
  //text("Y: "+(-yD), 10, 30); 
  //text("X: "+xD, 10, 48); 
  //fill(0, 102, 153);

  translate(width/2, height/2 + 100); // translate plane to center
  rotateX(PI/2.1); // rotate plane for 3d view
  
  translate(-w/2, -h/2);


  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x ++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      
       fill(r,g,b);
       //stroke(r-40,g-40,b-40);
      
      
      //int ter = (int)terrain[x][y] ;
      //fill(ter % 80 + 90, ter % 200+ 90, ter % 20 + 90);
      
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
