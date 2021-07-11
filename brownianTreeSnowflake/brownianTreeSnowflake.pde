Particle current;
ArrayList<Particle> snowFlake;

void setup () {
  fullScreen();
  current = new Particle(width/2, random(0, 10));
  snowFlake = new ArrayList<Particle>();
}

void draw() {
  
  translate(width / 2, height / 2);
  rotate(PI/6);
  
  background(0);
  current.update();
  
  while(!current.finished() && !current.intersects(snowFlake)) {
    current.update();
   }
   snowFlake.add(current);
  current = new Particle(width / 2,0);
   
   for(int i = 0; i < 6; i++) {
     rotate(PI/3);
     current.show();
     for(Particle p : snowFlake) {
       p.show();
     }
     
     pushMatrix();
     scale(1, -1);
     for(Particle p : snowFlake) {
       p.show();
     }
     popMatrix();
   }
  
  
}
