import controlP5.*;

private static final int WIDTH = 1200;
private static final int HEIGHT = 800;

private static final int NULL_PAGE = -1;
private static final int MENU_PAGE = 0;
private static final int GAME_PAGE = 1;
private static final int END_GAME_PAGE = 2;

private static final int MAX_RABBIT_COUNT = 50;
private static final int MAX_DEER_COUNT = 50;
private static final int MAX_WOLF_COUNT = 50;

int prevPage = NULL_PAGE;
int currentPage = MENU_PAGE;
boolean isWin = false;
PFont menuFont, infoFont, gameFont;

ControlP5 cp5;
Button startGameButton;
Button exitButton;
Slider rabbitCountSlider;
Slider deerCountSlider;
Slider wolfCountSlider;

Field field = new Field(WIDTH - 100, HEIGHT - 100, 50, color(50, 30, 30), color(80, 140, 45));
Weapon weapon;
Hunter hunter;

void settings() {
  size(WIDTH, HEIGHT, P2D);
  smooth(4);
}

void setup() {
  frameRate(60);
  menuFont = createFont("Consolas", 80, true);
  infoFont = createFont("Consolas", 30, true);
  gameFont = createFont("Consolas", 100, true);

  cp5 = new ControlP5(this);
  cp5.setFont(createFont("Consolas", 30, true));

  rabbitCountSlider = cp5.addSlider("rabbitCountSliderTick")
    .setLabel("rabbit")
    .setPosition(WIDTH / 2 - 250, field.getPosition().y + 220)
    .setSize(500, 40)
    .setRange(1, MAX_RABBIT_COUNT)
    .setValue(15)
    .setNumberOfTickMarks(MAX_RABBIT_COUNT)
    .setColorBackground(color(50, 30, 30))
    .setColorForeground(color(120, 80, 80))
    .setColorActive(color(140, 100, 100));

  deerCountSlider = cp5.addSlider("deerCountSliderTick")
    .setLabel("deer")
    .setPosition(WIDTH / 2 - 250, field.getPosition().y + 300)
    .setSize(500, 40)
    .setRange(1, MAX_DEER_COUNT)
    .setValue(15)
    .setNumberOfTickMarks(MAX_DEER_COUNT)
    .setColorBackground(color(50, 30, 30))
    .setColorForeground(color(120, 80, 80))
    .setColorActive(color(140, 100, 100));

  wolfCountSlider = cp5.addSlider("wolfCountSliderTick")
    .setLabel("wolf")
    .setPosition(WIDTH / 2 - 250, field.getPosition().y + 380)
    .setSize(500, 40)
    .setRange(1, MAX_WOLF_COUNT)
    .setValue(3)
    .setNumberOfTickMarks(MAX_WOLF_COUNT)
    .setColorBackground(color(50, 30, 30))
    .setColorForeground(color(120, 80, 80))
    .setColorActive(color(140, 100, 100));

  startGameButton = cp5.addButton("startGameButtonOnClick")
    .setLabel("play")
    .setPosition(WIDTH / 2 - 100, field.getPosition().y + 550)
    .setSize(200, 50)
    .setColorBackground(color(50, 30, 30))
    .setColorForeground(color(120, 80, 80))
    .setColorActive(color(140, 100, 100));
}

void draw() {
  switch(currentPage) {
  case MENU_PAGE: 
    drawMenuPage(); 
    break;
  case GAME_PAGE: 
    drawGamePage(); 
    break;
  case END_GAME_PAGE: 
    drawEndGamePage();
    break;
  }
}

void drawMenuPage() {
  if (prevPage != currentPage || currentPage != MENU_PAGE) {
    currentPage = MENU_PAGE;
    prevPage = currentPage;
    cp5.show();
  }

  field.update();

  textFont(menuFont);
  textAlign(CENTER);
  fill(color(255, 255, 255));
  text("Hunter Game", WIDTH / 2, field.getPosition().y + 120);
}

void drawGamePage() {
  if (prevPage != currentPage || currentPage != GAME_PAGE) {
    currentPage = GAME_PAGE;
    prevPage = currentPage;
    cp5.hide();
  }

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
        currentPage = END_GAME_PAGE;
        isWin = false;
      }
    }

    noStroke();
    fill(color(255, 0, 0));
    ellipse(mouseX, mouseY, 5, 5);

    textFont(infoFont);
    textAlign(LEFT);
    fill(color(255, 255, 255));
    text(String.format("[%s/%s]", hunter.getWeapon().getBulletCount(), hunter.getWeapon().getMaxBulletCount()), 50, 40);
  }
}

void drawEndGamePage() {
  if (prevPage != currentPage || currentPage != END_GAME_PAGE) {
    currentPage = END_GAME_PAGE;
    prevPage = currentPage;
    cp5.hide();
  }

  field.update();

  textFont(gameFont);
  textAlign(CENTER);
  fill(color(255, 255, 255));
  text((isWin ? "YOU WIN!" : "GAME OVER"), WIDTH / 2, HEIGHT / 2);

  textFont(infoFont);
  textAlign(CENTER);
  fill(color(255, 255, 255));
  text("Press [ENTER] to continue", WIDTH / 2, HEIGHT - 15);
}

void keyPressed() {
  switch(currentPage) {
  case MENU_PAGE: 
    if (keyCode == ENTER) {
      startGameButtonOnClick();
    } 
    break;
  case GAME_PAGE: 
    final char keyChar = Character.toUpperCase(key);
    if (keyCode == UP || keyChar == 'W') {
      hunter.setMove(0, true);
    } else if (keyCode == DOWN || keyChar == 'S') {
      hunter.setMove(1, true);
    } else if (keyCode == LEFT || keyChar == 'A') {
      hunter.setMove(2, true);
    } else if (keyCode == RIGHT || keyChar == 'D') {
      hunter.setMove(3, true);
    } else if (keyCode == ESC) {
      currentPage = MENU_PAGE;
      key = 0;
    } 
    break;
  case END_GAME_PAGE: 
    if (keyCode == ENTER) {
      currentPage = MENU_PAGE;
    }
    break;
  }
}

void keyReleased() {
  if (currentPage == GAME_PAGE) {
    final char keyChar = Character.toUpperCase(key);

    if (keyCode == UP || keyChar == 'W' || keyChar == 'Ц') {
      hunter.setMove(0, false);
    } else if (keyCode == DOWN || keyChar == 'S' || keyChar == 'І' || keyChar == 'Ы') {
      hunter.setMove(1, false);
    } else if (keyCode == LEFT || keyChar == 'A' || keyChar == 'Ф') {
      hunter.setMove(2, false);
    } else if (keyCode == RIGHT || keyChar == 'D' || keyChar == 'В') {
      hunter.setMove(3, false);
    }
  }
}

void startGameButtonOnClick() {
  currentPage = GAME_PAGE;

  field.getOrganisms().clear();

  weapon = new Weapon(100, 300, 1);
  hunter = new Hunter(field, weapon);

  for (int i = 0; i < rabbitCountSlider.getValue(); i++) {
    field.addOrganism(new Rabbit(field));
  }

  for (int i = 0; i < deerCountSlider.getValue(); i++) {
    field.addOrganism(new Deer(field));
  }

  for (int i = 0; i < wolfCountSlider.getValue(); i++) {
    field.addOrganism(new Wolf(field));
  }

  field.addOrganism(hunter);
}

void mouseClicked() {
  if (currentPage == GAME_PAGE && prevPage == currentPage ) {
    hunter.makeShot(new PVector(mouseX, mouseY));
  }
}

void rabbitCountSliderTick(int value) {
}

void deerCountSliderTick(int value) {
}

void wolfCountSliderTick(int value) {
}
