private static final int WIDTH = 1200;
private static final int HEIGHT = 800;

boolean isGameOver = false;
PFont infoFont, gameFont;

Field field = new Field(WIDTH - 100, HEIGHT - 100, color(46, 33, 31), color(80, 140, 43));
Weapon weapon;
Hunter hunter;

void settings() {
  size(WIDTH, HEIGHT, P2D);
  smooth(4);
}

void setup() {
  frameRate(60);
  infoFont = createFont("Consolas", 30, true);
  gameFont = createFont("Consolas", 60, true);

  startGame();
}

void draw() {
  if (!isGameOver) {
    field.update();

    for (int i = 0; i < field.getOrganisms().size(); i++) {
      Organism organism = field.getOrganisms().get(i);

      organism.update();

      organism.isOnField();

      if (!(organism instanceof  Hunter) && organism.isAlive()) {
        ArrayList<Bullet> bullets = hunter.getBullets();
        for (int j = 0; j < bullets.size(); j++) {
          if (bullets.get(j).canDoDamage(organism) && organism.applyDamage(bullets.get(j).getDamage())) {
            hunter.getBullets().remove(j);
            break;
          }
        }
      }

      if (!(organism instanceof Wolf) && organism.isAlive()) {
        for (int j = 0; j < field.getOrganisms().size(); j++) {
          if (field.getOrganisms().get(j) instanceof Wolf) { 
            Wolf wolf = (Wolf) field.getOrganisms().get(j);

            if (wolf.canDoDamage(organism)) {
              organism.applyDamage(wolf.getDamage());
            }
          }
        }
      }

      if (!organism.isAlive()) {
        field.getOrganisms().remove(i);

        if (organism instanceof Hunter) {
          isGameOver = true;
        }
      }
    }

    noStroke();
    fill(color(255, 0, 0));
    ellipse(mouseX, mouseY, 5, 5);

    textFont(infoFont);
    textAlign(LEFT);
    fill(color(255, 255, 255));
    text(String.format("[%s/%s]", hunter.getWeapon().getBulletCount(), hunter.getWeapon().getMaxBulletCount()), 50, 40);
  } else {
    background(0);
    textFont(gameFont);
    textAlign(CENTER);
    fill(color(255, 255, 255));
    text("GAME OVER", width / 2, height / 2);

    textFont(infoFont);
    textAlign(CENTER);
    fill(color(255, 255, 255));
    text("Press [ENTER] to restart\nPress [ESC] to exit", width / 2, (height / 2) + 100);

    if (keyPressed) {
      if (keyCode == ENTER) {
        startGame();
      } else if (keyCode == ESC) {
        exit();
      }
    }
  }
}

void startGame() {
  field.getOrganisms().clear();

  weapon = new Weapon(100, 300, 1);
  hunter = new Hunter(field, weapon);

  for (int i = 0; i < 10; i++) {
    field.addOrganism(new Rebbit(field));
  }

  for (int i = 0; i < 3; i++) {
    field.addOrganism(new Wolf(field, 1, 10000));
  }

  field.addOrganism(hunter);

  isGameOver = false;
}

void mouseClicked() {
  hunter.makeShot(new PVector(mouseX, mouseY));
}

void keyPressed() {
  if (!isGameOver) {
    final char keyChar = Character.toUpperCase(key);

    if (keyCode == UP || keyChar == 'W') {
      hunter.setMove(0, true);
    } else if (keyCode == DOWN || keyChar == 'S') {
      hunter.setMove(1, true);
    } else if (keyCode == LEFT || keyChar == 'A') {
      hunter.setMove(2, true);
    } else if (keyCode == RIGHT || keyChar == 'D') {
      hunter.setMove(3, true);
    }
  }
}

void keyReleased() {
  if (!isGameOver) {
    final char keyChar = Character.toUpperCase(key);

    if (keyCode == UP || keyChar == 'W') {
      hunter.setMove(0, false);
    } else if (keyCode == DOWN || keyChar == 'S') {
      hunter.setMove(1, false);
    } else if (keyCode == LEFT || keyChar == 'A') {
      hunter.setMove(2, false);
    } else if (keyCode == RIGHT || keyChar == 'D') {
      hunter.setMove(3, false);
    }
  }
}
