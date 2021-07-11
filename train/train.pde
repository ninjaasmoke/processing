float x = 0;
float y = 0;
int[] key_lookup = { LEFT, RIGHT, UP, DOWN };
boolean[] keys = { false, false, false, false };
 
void setup () { 
  size (900, 400 );
} 
void draw () {
  background(209);
  do_movement();
  translate(x, y);
  origin_marker();
  draw_train();
}
 
void do_movement(){
  x += (keys[0]?-1:0) + (keys[1]?1:0);
  y += (keys[2]?-1:0) + (keys[3]?1:0);
}
 
void draw_train() {  
  fill (0, 0, 120); 
  ellipse (100, 150, 80, 80); 
  ellipse (240, 155, 60, 60); 
  strokeWeight (6); 
  rect (140, 140, 70, 30); 
  line (100, 150, 100, 20); 
  line (100, 20, 180, 20); 
  line (180, 20, 180, 100); 
  line (180, 100, 245, 100); 
  line (245, 100, 245, 155); 
  fill (209); 
  rect (210, 50, 5, 50); 
  rect (120, 50, 30, 50);
}
 
void origin_marker() {
  pushStyle();
  strokeWeight(1);
  stroke(255, 0, 0);
  line(0, 0, 100, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 100);
  popStyle();
}
 
void keyPressed(){
  k(true);
}
 
void keyReleased(){
  k(false);
}
 
void k(boolean b){
  for( int i = 0; i < key_lookup.length; i++){
    if( keyCode == key_lookup[i] ){
      keys[i] = b;
    }
  }
}
