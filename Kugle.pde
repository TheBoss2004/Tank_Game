class Kugle {

  PVector position, velocity;
  float radius, kugleVinkel, accel;
  int life = 100;

  Kugle(PVector pos, float vinkel) {
    position = new PVector(pos.x, pos.y);
    velocity = new PVector(0, 0);
    kugleVinkel = vinkel;
    radius = 10;
    accel = 22;
  }
  void update() {
    velocity.x = (float)Math.cos(radians(kugleVinkel));
    velocity.y = (float)Math.sin(radians(kugleVinkel));
    velocity.x *= accel;
    velocity.y *=accel;
    position.add(velocity);
    life -= 1;
    // (husk slet) hvad skal der ske med life-variablen?
  }

  void draw() {
    push();
    fill(255, 68, 31);
    noStroke();
    circle(position.x, position.y, 10);
    pop();
  }
}
