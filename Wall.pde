class Wall {

  PVector pos;
  PVector size;
  color c;

  Wall(float x, float y, float w, float h, color c) {
    this.pos = new PVector(x, y);
    this.size = new PVector(w, h);
    this.c = c;
  }

  void draw() {
    push();
    rectMode(CENTER);
    fill(c);
    //noStroke();
    rect(pos.x, pos.y, size.x, size.y);
    for (PVector corner : getCorners()){
      //circle(corner.x, corner.y, 10);
    }
    pop();
  }
  
  PVector[] getCorners() {
    PVector[] corners = new PVector[4];
    
    PVector UR = new PVector(size.x / 2, -size.y / 2);
    corners[0] = PVector.add(pos, UR);
    
    PVector LR = new PVector(size.x / 2, size.y / 2);
    corners[1] = PVector.add(pos, LR);
    
    PVector LL = new PVector(-size.x / 2, size.y / 2);
    corners[2] = PVector.add(pos, LL);
    
    PVector UL = new PVector(-size.x / 2, -size.y / 2);
    corners[3] = PVector.add(pos, UL);
    return corners;
  }
  
  PVector getPos() {
    return pos;
  }
  
  PVector getSize() {
    return size;
  }
}
