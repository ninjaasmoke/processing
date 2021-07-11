class Particle {
  
  PVector pos;
  float r;
  
  Particle(float x, float y) {
    pos = new PVector(x,y);
    r =  3;
  }
  
  void update() {
    pos.x -= 2;
    pos.y += random(-4, 4);
    
    float angle = pos.heading();
    angle = constrain(angle, 0, PI/6);
    
    float magnitude = pos.mag();
    pos = PVector.fromAngle(angle);
    
    pos.setMag(magnitude);
  }
  
  void show () {
    fill(255);
    stroke(250);
    ellipse(pos.x,pos.y,r*2, r*2);
  }
  
  boolean finished() {
    return (pos.x < 1);
  }
  
  boolean intersects(ArrayList<Particle> snowFlake) {
    boolean result = false;
    for(Particle s : snowFlake) {
      float d = dist(s.pos.x, s.pos.y, pos.x, pos.y);
      if(d < r*2) {
        result = true;
        break;
      }
    }
    return result;
  }
}
