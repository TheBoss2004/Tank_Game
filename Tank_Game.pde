import rna.tools.KeyHandler;
import java.util.Collections;

KeyHandler keys;
Tilemap map;
PImage imggt, imgrt, imgbt, imgpt, imgyt;

ArrayList<Tank> tanks;


void setup() {
  size(800, 800);
  imggt = loadImage("greenTank.png");
  imgrt = loadImage("redTank.png");
  imgbt = loadImage("blueTank.png");
  imgpt = loadImage("purpleTank.png");
  imgyt = loadImage("yellowTank.png");
  keys = new KeyHandler(true);
  map = new Tilemap();
  tanks = new ArrayList<Tank>();
  tanks.add(new Tank(imggt, width / 4, height / 2, 0, 'w', 's', 'a', 'd', ' '));
  tanks.add(new Tank(imgrt, width / 4 * 3, height / 2, 0, 'i', 'k', 'j', 'l', 'b'));
}

void draw() {
  background(50);
  map.update();
  map.renderMap();
  for (Tank tank : tanks){
    tank.update();
    tank.draw();
  }
  //noLoop();
}
