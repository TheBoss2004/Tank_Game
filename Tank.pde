class Tank {


  PVector pos;
  float rotation;
  
  float speed = 5;
  float turnSpeed = 5;
  Tank(float x, float y, float rotation) {
    this.pos = new PVector(x, y);
    this.rotation = rotation;
  } //float

  //vi skal loade librabry til at kunne importere billeder
  void update() {
    if (keys.isDown('w')) {
      PVector movement = PVector.fromAngle(radians(rotation - 90)).mult(speed);
      pos.add(movement);
    }

    if (keys.isDown('s')) {
      PVector movement = PVector.fromAngle(radians(rotation + 90)).mult(speed);
      pos.add(movement);
    }

    if (keys.isDown('a')) {
      rotation -= turnSpeed;
    }

    if (keys.isDown('d')) {
      rotation += turnSpeed;
    }
  } //update
  
  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(radians(rotation));
    imageMode(CENTER);
    image(imggt, 0, 0);
    popMatrix();
  }
} //class
