class Tank {
  PImage img;
  PVector pos;
  float rotation;
  float speed = 2.5;
  float turnSpeed = 2;
  int skudCounter = 1;
  ArrayList<Kugle> kugler = new ArrayList<Kugle>();

  final float SKUD_COOLDOWN = 1000;
  float sidstSkudt = -SKUD_COOLDOWN;

  char[] movementKeys;

  boolean dead = false;

  Tank(PImage img, float x, float y, float rotation, char w, char s, char a, char d, char shoot) {
    this.img = img.copy();
    this.img.resize(40, 62);
    this.pos = new PVector(x, y);
    this.rotation = rotation;
    movementKeys = new char[5];
    movementKeys[0] = w;
    movementKeys[1] = s;
    movementKeys[2] = a;
    movementKeys[3] = d;
    movementKeys[4] = shoot;
  } 


  void update() {
    PVector movement = new PVector(0, 0);
    if (keys.isDown(movementKeys[0])) {
      movement.add(PVector.fromAngle(radians(rotation - 90)).mult(speed));
    }

    if (keys.isDown(movementKeys[1])) {
      movement.add(PVector.fromAngle(radians(rotation + 90)).mult(speed));
    }

    if (!collidingWithWall(PVector.add(pos, movement), rotation, map.walls) && !collidingWithTank(PVector.add(pos, movement), rotation, tanks)) {
      pos.add(movement);
    }

    float rotation = 0;

    if (keys.isDown(movementKeys[2])) {
      rotation -= turnSpeed;
    }

    if (keys.isDown(movementKeys[3])) {
      rotation += turnSpeed;
    }

    if (!collidingWithWall(pos, this.rotation + rotation, map.walls) && !collidingWithTank(pos, this.rotation + rotation, tanks)) {
      this.rotation += rotation;
    }

    shoot();
    
    if (collidingWithKugle(pos, tanks)){
      // Hvad sker der når en tank dør? 
      int tankNummer = tanks.indexOf(this) + 1;
      if (tankNummer == 1){
        gameOver = "Spiller 2 vandt!";
      } else {
        gameOver = "Spiller 1 vandt!";
      }
      
    }
  }

  void shoot() {
    if (millis() - sidstSkudt > SKUD_COOLDOWN && keys.isDown(movementKeys[4])) {
      sidstSkudt = millis();
      PVector forward = PVector.fromAngle(radians(rotation - 90)).mult(5);
      kugler.add(new Kugle(this, PVector.add(pos, forward), rotation - 90, 10));
      println(kugler.size());
    } //update
  }

  void draw() {
    for (int i = 0; i < kugler.size(); i++) {
      Kugle k = kugler.get(i);
      k.update();
      k.draw();
    }
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(radians(rotation));
    imageMode(CENTER);
    image(img, 0, 0);
    popMatrix();

    /* This shows the dots
     for (PVector corner : getBodyCorners(pos, rotation)) {
     fill(255, 0, 0);
     circle(corner.x, corner.y, 3);
     }
     
     for (PVector corner : getBarrelCorners(pos, rotation)) {
     fill(0, 255, 0);
     circle(corner.x, corner.y, 3);
     }*/
  }
 
  boolean collidingWithKugle(PVector pos, ArrayList<Tank> tanks) {
    for (Tank otherTank : tanks) {
      if (otherTank == this) {
        continue;
      }

      for (Kugle kugle : otherTank.kugler) {
        if (pointInTank(kugle.getPos(), PVector.sub(getBarrelCorners()[1], pos))) {
          kugle.fjernKugle();
          println("hit: " + frameCount);
          return true;
        }

        if (pointInTank(kugle.getPos(), PVector.sub(getBodyCorners()[1], pos))) {
          kugle.fjernKugle();
          println("hit: " + frameCount);
          return true;
        }
      }
    }
    return false;
  }

  boolean collidingWithTank(PVector pos, float rotation, ArrayList<Tank> tanks) {

    for (Tank otherTank : tanks) {
      if (otherTank == this) {
        continue;
      }

      PVector[] barrelCorner = getBarrelCorners(pos, rotation);
      PVector[] bodyCorner = getBodyCorners(pos, rotation);

      PVector[] secondBarrelCorner = otherTank.getBarrelCorners();
      PVector[] secondBodyCorner = otherTank.getBodyCorners();

      if (rectanglesColliding(barrelCorner, secondBarrelCorner)) {
        return true;
      }
      if (rectanglesColliding(bodyCorner, secondBarrelCorner)) {
        return true;
      }
      if (rectanglesColliding(bodyCorner, secondBodyCorner)) {
        return true;
      }
      if (rectanglesColliding(barrelCorner, secondBodyCorner)) {
        return true;
      }
    }

    return false;
  }//tankscollition

  boolean collidingWithWall(PVector pos, float rotation, ArrayList<Wall> walls) {
    PVector[] bodyCorners = getBodyCorners(pos, rotation);

    for (Wall wall : walls) {
      PVector[] wallCorners = wall.getCorners();
      if (rectanglesColliding(bodyCorners, wallCorners)) {
        return true;
      }
    }

    PVector[] barrelCorners = getBarrelCorners(pos, rotation);

    for (Wall wall : walls) {
      PVector[] wallCorners = wall.getCorners();
      if (rectanglesColliding(barrelCorners, wallCorners)) {
        return true;
      }
    }
    return false;
  }//tankwallcollusion

  PVector[] getAxisFromPoints(PVector[] corners) {
    PVector[] axis = new PVector[2];
    axis[0] = PVector.sub(corners[0], corners[3]);
    axis[1] = PVector.sub(corners[2], corners[3]);
    axis[0].normalize();
    axis[1].normalize();
    return axis;
  }

  boolean rectanglesColliding(PVector[] rect1Corners, PVector[] rect2Corners) {
    PVector[] rect1Axis = getAxisFromPoints(rect1Corners);
    PVector[] rect2Axis = getAxisFromPoints(rect2Corners);

    for (PVector axis : rect1Axis) {
      if (!checkCollisionOnAxis(rect1Corners, rect2Corners, axis)) {
        return false;
      }// if
    }// for each

    for (PVector axis : rect2Axis) {
      if (!checkCollisionOnAxis(rect1Corners, rect2Corners, axis)) {
        return false;
      }// if
    }// for each

    return true;
  }

  boolean checkCollisionOnAxis(PVector[] corners1, PVector[] corners2, PVector axis) {
    ArrayList<Float> corners1Scalars = new ArrayList<Float>();
    ArrayList<Float> corners2Scalars = new ArrayList<Float>();

    for (int i = 0; i < corners1.length; i++) {
      PVector projected = PVector.mult(axis, PVector.dot(corners1[i], axis) / axis.magSq());
      corners1Scalars.add(projected.dot(axis));
    }// for i

    for (int i = 0; i < corners2.length; i++) {
      PVector projected = PVector.mult(axis, PVector.dot(corners2[i], axis) / axis.magSq());
      corners2Scalars.add(projected.dot(axis));
    }// for i

    float min1 = Collections.min(corners1Scalars);
    float max1 = Collections.max(corners1Scalars);
    float min2 = Collections.min(corners2Scalars);
    float max2 = Collections.max(corners2Scalars);

    return min2 <= max1 && max2 >= min1;
  }

  boolean pointInTank(PVector point, PVector corner) {
    PVector localPoint = PVector.sub(point, pos);
    localPoint.rotate(radians(-rotation));

    localPoint.x = abs(localPoint.x);
    localPoint.y = abs(localPoint.y);

 /*abs bliver brugt til så tanks prostioner er hele tiden positiv*/
    if (localPoint.x <= abs(corner.x) && localPoint.y <= abs(corner.y)) {
      return true;
    }// if

    return false;
  }

  PVector[] getBodyCorners() {
    return getBodyCorners(pos, rotation);
  }

  PVector[] getBodyCorners(PVector pos, float rotation) {
    PVector[] corners = new PVector[4];

    PVector UR = new PVector(img.width / 2, -img.height / 2 * 0.44);
    UR.rotate(radians(rotation));
    corners[0] = PVector.add(pos, UR);

    PVector LR = new PVector(img.width / 2, (img.height / 2));
    LR.rotate(radians(rotation));
    corners[1] = PVector.add(pos, LR);

    PVector LL = new PVector(-img.width / 2, img.height / 2);
    LL.rotate(radians(rotation));
    corners[2] = PVector.add(pos, LL);

    PVector UL = new PVector(-img.width / 2, -img.height / 2 * 0.44);
    UL.rotate(radians(rotation));
    corners[3] = PVector.add(pos, UL);
    return corners;
  }

  PVector[] getBarrelCorners() {
    return getBarrelCorners(pos, rotation);
  }

  PVector[] getBarrelCorners(PVector pos, float rotation) {
    PVector[] corners = new PVector[4];

    float xScalar = 0.28;

    PVector UR = new PVector(img.width / 2 * xScalar, -img.height / 2);
    UR.rotate(radians(rotation));
    corners[0] = PVector.add(pos, UR);

    PVector LR = new PVector(img.width / 2 * xScalar, -img.height / 2 * 0.44);
    LR.rotate(radians(rotation));
    corners[1] = PVector.add(pos, LR);

    PVector LL = new PVector(-img.width / 2 * xScalar, -img.height / 2 * 0.44);
    LL.rotate(radians(rotation));
    corners[2] = PVector.add(pos, LL);

    PVector UL = new PVector(-img.width / 2 * xScalar, -img.height / 2);
    UL.rotate(radians(rotation));
    corners[3] = PVector.add(pos, UL);
    return corners;
  }
 
  void fjernKugle(Kugle kugle) {
    kugler.remove(kugle);
  }
}//class
