int cols, rows;
int scl = 12; // pixels scale for each polygon
int w = 100;
int h = 2000;

float flying = 0;
float xD = 0;
float yD = 0;

float[][] terrain;

int r = 155, g = 118, b = 83;
int skyR = 3, skyG = 16, skyB = 30;

int[] key_lookup = { LEFT, RIGHT, UP, DOWN };
boolean[] keys = { false, false, false, false };

Star[] stars = new Star[200];
float speed;

float rX;

PImage[] textures = new PImage[5];
PImage ss = new PImage();

void setup() {
  frameRate(60);
  //size(800, 400, P3D);
  fullScreen(P3D);
  w = width * 2;
  cols = w / scl;
  rows = h /scl;

  terrain = new float[cols][rows];
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  
  speed = 0.4;
  
  textures[0] = loadImage("mars.jpg");
  textures[1] = loadImage("neptune.jpg");
  textures[2] = loadImage("earth.jpg");
  textures[3] = loadImage("moon.jpg");
  textures[4] = loadImage("milky.jpg");
  
  //ss = loadImage("ss.png");
  
  rX = 1.0;
}

void do_movement() {
  xD += (keys[0]?-1:0) + (keys[1]?1:0);
  yD += (keys[2]?-1:0) + (keys[3]?1:0);
  speed = 4;
}

void draw() {

  do_movement(); // adds arrow controls to movement
  yD -= 1; // comment for manual forward
  
  //yD -= 0.001; // auto acceleration

  background(textures[4]);
  noFill();
  
  //renderParticlesScene();
  
  
  //renderBlackHole();

  //renderPlanetA();
  //renderPlanetB();
  
  //renderMoonScene();

  float yOff = yD / 10;
  for (int y = 0; y < rows; y++) {
    float xOff = xD / 10;
    for (int x = 0; x < cols; x ++) {
      terrain[x][y] = map(noise(xOff, yOff), 0, 1, -100, 160); // noise = perlin noise
      xOff += 0.1;
    }
    yOff += 0.1;
  }
  
  renderTerrain();
  
  //renderSpaceShip();
  
  rX += 0.003;
  
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

void renderTerrain() {
  
  pushMatrix();
    
  pointLight(50, 50, 90, -mouseX, -mouseY, height * 0.6);
  
  //directionalLight(200, 0, 0, mouseX, mouseY, height / 2);
 
  spotLight(150, 150, 205, mouseX, height/2, height * 0.8, 0, 0, -1, PI/6, 10);
  
  translate(width/2, height/2 + 100); // translate plane to center
  rotateX(PI/2.1); // rotate plane for 3d view
  
  translate(-w/2, -h/2);

  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    noStroke();
    for (int x = 0; x < cols; x ++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      
       fill(r,g,b);
       
       //stroke(r-40,g-40,b-40);
       
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
  popMatrix();
}

void renderParticlesScene() {
  //speed = map(mouseX, 0, width, 0, 50);
  //speed = 0.4;
  pushMatrix();
  translate(width/2, height/2);
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
  popMatrix();
}

void renderMoonScene() {
  PShape globe;
  float yPos = -yD % (height * 4);
  pushMatrix();
  fill(200);
  noStroke();
  globe = createShape(SPHERE, 100);
  globe.setTexture(textures[3]);
  translate(width/2 - xD/3 - 200, height/2 - yPos/3, -height+yPos/2);
  rotateY(rX);
  shape(globe);
  popMatrix();
}

void renderPlanetA() {
  PShape globe;
  float yPos = -yD% (height * 4);
  pushMatrix();
  fill(100);
  noStroke();
  globe = createShape(SPHERE, 600);
  globe.setTexture(textures[0]);
  translate(width*1.6-yD/4, height/6 - yPos/3, -width-yPos/4);
  rotateY(-rX/3);
  rotateX(-rX/3);
  shape(globe);
  popMatrix();
  translate(0,0,0);
}

void renderPlanetB() {
  PShape globe;
  float yPos = -yD% (height * 4);
  pushMatrix();
  fill(88);
  noStroke();
  globe = createShape(SPHERE, 300);
  globe.setTexture(textures[1]);
  translate(-width/2, -200-yPos/6, -width);
  rotateZ(-rX/2);
  rotateY(-rX);
  shape(globe);
  popMatrix();
}

void renderBlackHole () {
  PShape globe;
  pushMatrix();
  fill(255);
  noStroke();
  globe = createShape(SPHERE, 200);
  globe.setTexture(textures[4]);
  translate(width / 2 + 400, 100, -width*1.2);
  shape(globe);
  rotateX(rX);
  popMatrix();
}

void renderSpaceShip() {
  pushMatrix();
  fill(0);
  translate(width/2 - 422, height/2 - 242, height/2);
  image(ss, 422/1.5, 242/1.5, 422/2, 242/2);
  popMatrix();
}
