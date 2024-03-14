import rna.tools.KeyHandler;
Tank tank;
KeyHandler keys;
Tilemap map;
PImage imggt, imgrt, imgbt, imgpt, imgyt;
Tank firstPlayer = new Tank(20, 20, 0);


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
}

void draw() {
  background (50);
  map.renderMap();
  firstPlayer.update();
  firstPlayer.draw();
  
  //noLoop();
}
