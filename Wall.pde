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
    fill(c);
    //noStroke();
    rect(pos.x, pos.y, size.x, size.y);
    pop();
  }
}
