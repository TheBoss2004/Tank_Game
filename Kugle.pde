class Kugle {

  PVector position, velocity;
  float size, kugleVinkel, accel;

  Kugle(PVector pos, float vinkel, float speed) {
    position = new PVector(pos.x, pos.y);
    velocity = PVector.fromAngle(radians(vinkel));
    velocity.mult(speed);
    kugleVinkel = vinkel;
    size = 7;
    accel = 0.99;
  }
  void update() {
    velocity.mult(accel);
    position.add(velocity);
  }

  void draw() {
    push();
    fill(255, 68, 31);
    noStroke();
    circle(position.x, position.y, size);
    pop();
  }

  boolean ramteVæg(ArrayList<Wall> walls) {
    for (Wall wall : walls) {
      PVector wallPos = wall.getPos();
      PVector wallSize = wall.getSize();

      if (position.x >= wallPos.x - wallSize.x / 2 && position.x <= wallPos.x + wallSize.x / 2 && position.y >= wallPos.y - wallSize.y / 2 && position.y <= wallPos.y + wallSize.y / 2) {
        return true;
      }
    }
    return false;
  }

  PVector getPos() {
    return position;
  }
}
