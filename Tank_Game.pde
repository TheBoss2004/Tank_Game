import rna.tools.KeyHandler;
Tank tank;
KeyHandler keys;
Tilemap map;
PImage imggt, imgrt, imgbt, imgpt, imgyt;
Tank firstPlayer;
Tank secondPlayer;


void setup() {
  size(800, 800);
  frameRate(30);
  imggt = loadImage("greenTank.png");
  imgrt = loadImage("redTank.png");
  imgbt = loadImage("blueTank.png");
  imgpt = loadImage("purpleTank.png");
  imgyt = loadImage("yellowTank.png");
  keys = new KeyHandler(true);
  map = new Tilemap();
  firstPlayer = new Tank(width / 2, height / 2, 0, 'w', 's', 'a', 'd', ' ');
  secondPlayer = new Tank(width / 2, height / 2, 0, 'i', 'k', 'j', 'l', 'b');
}

void draw() {
  background(50);
  map.update();
  map.renderMap();
  firstPlayer.update();
  firstPlayer.draw();
  secondPlayer.update();
  secondPlayer.draw();

  //noLoop();
}
