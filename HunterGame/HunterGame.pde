private static final int WIDTH = 1200;
private static final int HEIGHT = 800;

boolean isGameOver = false;
PFont font;

Field field = new Field(WIDTH - 100, HEIGHT - 100, color(46, 33, 31), color(80, 140, 43));
Hunter hunter = new Hunter(field);
ArrayList<Animal> animals = new ArrayList<Animal>();

void settings() {
  size(WIDTH, HEIGHT, P2D);
  smooth(4);
}

void setup() {
  frameRate(60);
  font = createFont("Consolas", 30, true);

  animals.add(new Rebbit(field));
}

void draw() {
  if (!isGameOver) {
    field.update();

    for (int i = 0; i < animals.size(); i++) {
      animals.get(i).update();

      if (!animals.get(i).isOnField()) {
        animals.remove(i);
        continue;
      }

      ArrayList<Bullet> bullets = hunter.getBullets();
      for (int j = 0; j < bullets.size(); j++) {
        if (bullets.get(j).isHit(animals.get(i))) { 
          animals.get(i).doDamage(bullets.get(j).getDamage());

          if (!animals.get(i).isAlive()) {
            animals.remove(i);
            bullets.remove(j);
            break;
          }
        }
      }
    }

    hunter.update();

    if (!hunter.isOnField() || !hunter.isAlive()) {
      isGameOver = true;
    }

    printInfo();
  } else {
    background(0);
  }
}

void printInfo() {
  textSize(30);
  textFont(font);
  fill(color(255, 255, 255));
  text(String.format("[%s/%s]", hunter.getWeapon().getBulletCount(), hunter.getWeapon().getMaxBulletCount()), 50, 40);
}

void mouseClicked() {
  hunter.makeShot(new PVector(mouseX, mouseY));
}

void keyPressed() {
  switch(keyCode) {
  case UP: 
    hunter.setMove(0, true);
    break;
  case DOWN: 
    hunter.setMove(1, true);
    break;
  case LEFT: 
    hunter.setMove(2, true);
    break;         
  case RIGHT: 
    hunter.setMove(3, true);
    break;
  }
}

void keyReleased() {
  switch(keyCode) {
  case UP: 
    hunter.setMove(0, false); 
    break;
  case DOWN: 
    hunter.setMove(1, false); 
    break;
  case LEFT: 
    hunter.setMove(2, false); 
    break;         
  case RIGHT: 
    hunter.setMove(3, false); 
    break;
  }
}
