class Bird {
  PVector pos, vel, acc;
  float r = 16;
  
  Bird() {
    pos = new PVector(36,height/2);
    vel = new PVector(0,0);
    acc = new PVector();
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void update() {
    applyForce(gravity);
    pos.add(vel);
    vel.add(acc);
    vel.limit(4);
    acc.mult(0);
  }
  
  void show() {
    fill(255);
    stroke(255);
    ellipse(pos.x,pos.y,r*2, r*2);
  }
  
}
