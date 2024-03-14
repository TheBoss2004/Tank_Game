class Tank {


  PVector pos;
  float rotation;
  float speed = 5;
  float turnSpeed = 4;
  int skudCounter = 1;
  ArrayList<Kugle> kugler = new ArrayList<Kugle>();

  final float SKUD_COOLDOWN = 1;
  float sidstSkudt = -SKUD_COOLDOWN;

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

    if (millis() - sidstSkudt > SKUD_COOLDOWN && keys.isDown (' ')) {
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
