float yOff = 0.0;

void setup() {
  fullScreen();
}

void draw() {  
  background(135, 206, 235);
  stroke(255);

  translate(width/2, height/2);

  float radius = 150;

  beginShape();
  float xOff = 0;
  for (float a = 0; a < TWO_PI; a+=0.1 ) {
    float offset = map(noise(xOff, yOff), 1, 2, -5, 5);
    float r = radius + offset;
    float x = r * cos(a);
    float y = r * sin(a);

    vertex(x, y);
    xOff += 0.1;
  }
  endShape();

  yOff+= 0.01;
}
