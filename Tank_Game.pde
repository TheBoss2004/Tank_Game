import rna.tools.KeyHandler;

Tank tank;
KeyHandler keys;
PImage imggt, imgrt, imgbt, imgpt, imgyt;

Tank firstPlayer = new Tank(20, 20, 0);

void setup() {
  size (500, 500);
  frameRate(30);
  imggt = loadImage("greenTank.png");
  imgrt = loadImage("redTank.png");
  imgbt = loadImage("blueTank.png");
  imgpt = loadImage("purpleTank.png");
  imgyt = loadImage("yellowTank.png");
  keys = new KeyHandler(true);
}

void draw() {
  background (50);

  firstPlayer.update();
  firstPlayer.draw();
}
