import peasy.*;

PeasyCam cam;

float speed = 0.3;
int dim = 3;
Cubie[] cube = new Cubie[dim* dim * dim];

Move[] allMoves = {
  new Move(0,1,0,1),
  new Move(0,1,0,-1),
  new Move(0,-1,0,1),
  new Move(0,-1,0,-1),
  
  new Move(1,0,0,1),
  new Move(1,0,0,-1),
  new Move(-1,0,0,1),
  new Move(-1,0,0,-1),
  
  new Move(1,0,0,1),
  new Move(1,0,0,-1),
  new Move(-1,0,0,1),
  new Move(-1,0,0,-1),
  
};

ArrayList<Move> sequence = new ArrayList<Move>(); 

int counter = 0;

boolean started = false;

Move currentMove;


void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 400);
  
  int index = 0;
  
  for(int x = -1 ; x <= 1 ; x++) {
    for(int y = -1 ; y <= 1 ; y++) {
      for(int z = -1 ; z <= 1 ; z++) {
        PMatrix3D matrix = new PMatrix3D();
        matrix.translate(x,y,z);
        cube[index] = new Cubie(matrix, x, y, z);
        index ++;
      }
    }
  }
  
  //cube[0].c = color(255, 0,0);
  //cube[2].c = color(0, 0,255);
  
  for(int i = 0; i < 100; i++) {
    int r = (int)random(allMoves.length);
    Move m = allMoves[r];
    
    sequence.add(m);
  }
  
  currentMove = sequence.get(counter);
  
  for(int i = sequence.size() - 1; i >= 0; i--) {
    Move nextMove = sequence.get(i).copy();
    nextMove.reverse();
    
    sequence.add(nextMove);
  }
  
}

void draw() {
  background(51);
  
  textSize(32);
  text(counter+1, 100, 100);
  
  rotateX(-0.5);
  rotateY(0.4);
  rotateZ(0.1);
  
  currentMove.update();
  
  if(currentMove.finished()) {
      if(counter < sequence.size() - 1) {
        counter ++;
        currentMove = sequence.get(counter);
        currentMove.start();
    }
  }
  
  scale(50);
  for(int i = 0 ; i < cube.length ; i++) {
    push();
    if(abs(cube[i].z) > 0 && cube[i].z == currentMove.z) {
      rotateZ(currentMove.angle);
    } else if(abs(cube[i].x) > 0 && cube[i].x == currentMove.x) {
      rotateX(currentMove.angle);
    } else if(abs(cube[i].y) > 0 && cube[i].y == currentMove.y) { 
      rotateY(currentMove.angle);
    }
    cube[i].show();
    pop();
  }
}


void turnZ(int index, int dir) {
  for(int i = 0 ; i < cube.length ; i++) {
    Cubie qb = cube[i];
    if(qb.z == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir * HALF_PI);
      matrix.translate(qb.x, qb.y);
      qb.update(round(matrix.m02), round(matrix.m12), qb.z);
      qb.turnFacesZ(dir);
    }
  }
}

void turnY(int index, int dir) {
  for(int i = 0 ; i < cube.length ; i++) {
    Cubie qb = cube[i];
    if(qb.y == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir * HALF_PI);
      matrix.translate(qb.x, qb.z);
      qb.update(round(matrix.m02), qb.y, round(matrix.m12));
      qb.turnFacesY(dir);
    }
  }
}

void turnX(int index, int dir) {
  for(int i = 0 ; i < cube.length ; i++) {
    Cubie qb = cube[i];
    if(qb.x == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir * HALF_PI);
      matrix.translate(qb.y, qb.z);
      qb.update(qb.x, round(matrix.m02), round(matrix.m12));
      qb.turnFacesX(dir);
    }
  }
}


void applyMove(char move) {
  
  switch(move) {
    
    // Front - Back
    case 'f':
    turnZ(-1,1);
    break;
    case 'F':
    turnZ(-1, -1);
    break;
    case 'b':
    turnZ(1,1);
    break;
    case 'B':
    turnZ(1, -1);
    break;
    
    // Up - Down
    case 'u':
    turnY(1,1);
    break;
    case 'U':
    turnY(1, -1);
    break;
    case 'd':
    turnY(-1, 1);
    break;
    case 'D':
    turnY(-1, -1);
    break;
    
    // Left - Right
    case 'l':
    turnX(-1, 1);
    break;
    case 'L':
    turnX(-1, -1);
    break;
    case 'r':
    turnX(1, 1);
    break;
    case 'R':
    turnX(1, -1);
    break;
    
  }
}

  
void keyPressed() {
  applyMove(key);

  if(key == ' ') {
    //started = true;
    currentMove.start();
  }
}

//String flipCase (char c) {
//  String s = "" + c;
//  if(s.equals(s.toLowerCase())) {
//    return s.toUpperCase();
//  } else return s.toLowerCase();
//}
