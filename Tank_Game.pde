import rna.tools.KeyHandler;
import java.util.Collections;

KeyHandler keys;
Tilemap map;
PImage imggt, imgrt;

ArrayList<Tank> tanks;

String gameOver = "";

void setup() {
  size(800, 800);
  imggt = loadImage("greenTank.png");
  imgrt = loadImage("redTank.png");
  keys = new KeyHandler(true);
  map = new Tilemap();
  tanks = new ArrayList<Tank>();
  tanks.add(new Tank(imggt, width / 4, height / 2, 0, 'w', 's', 'a', 'd', ' '));
  tanks.add(new Tank(imgrt, width / 4 * 3, height / 2, 0, 'i', 'k', 'j', 'l', 'b'));
  
}
 //<>//
void draw() {
  background(50);
  if (gameOver != ""){
    fill(255);
    textSize(50);
    textAlign(CENTER, CENTER);
    text(gameOver, width / 2, height / 2);
    return;
  }
  for (int i = 0; i < tanks.size(); i++) {
    Tank tank = tanks.get(i);
    tank.update();
    tank.draw();
  }
  map.update();
  map.renderMap();
  //noLoop();
}
