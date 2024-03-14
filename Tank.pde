class Tank {
  PVector pos;
  float rotation;
  float speed = 5;
  float turnSpeed = 4;
  int skudCounter = 1;
  ArrayList<Kugle> kugler = new ArrayList<Kugle>();

  final float SKUD_COOLDOWN = 1;
  float sidstSkudt = -SKUD_COOLDOWN;

  char[] movementKeys;

  Tank(float x, float y, float rotation, char w, char s, char a, char d, char shoot) {
    this.pos = new PVector(x, y);
    this.rotation = rotation;
    movementKeys = new char[5];
    movementKeys[0] = w;
    movementKeys[1] = s;
    movementKeys[2] = a;
    movementKeys[3] = d;
    movementKeys[4] = shoot;
    
  } //float

  //vi skal loade librabry til at kunne importere billeder
  void update() {
    if (keys.isDown(movementKeys[0])) {
      PVector movement = PVector.fromAngle(radians(rotation - 90)).mult(speed);
      pos.add(movement);
    }

    if (keys.isDown(movementKeys[1])) {
      PVector movement = PVector.fromAngle(radians(rotation + 90)).mult(speed);
      pos.add(movement);
    }

    if (keys.isDown(movementKeys[2])) {
      rotation -= turnSpeed;
    }

    if (keys.isDown(movementKeys[3])) {
      rotation += turnSpeed;
    }
    
    shoot();
  }

  void shoot() {
    if (millis() - sidstSkudt > SKUD_COOLDOWN && keys.isDown(movementKeys[4])) {
      sidstSkudt = millis();
      PVector forward = PVector.fromAngle(radians(rotation - 90)).mult(5);
      kugler.add(new Kugle(PVector.add(pos, forward), rotation - 90));
      println(kugler.size());
    } //update
  }

  void draw() {
    for (int i = 0; i < kugler.size(); i++) {
      Kugle k = kugler.get(i);
      if (k.life > 0) {
        k.update();
        k.draw();
      } else
        kugler.remove(i);
    }
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(radians(rotation));
    imageMode(CENTER);
    image(imggt, 0, 0);
    imggt.resize(40, 40);
    image(imggt, 0, 0);
    popMatrix();
  }
}//class
