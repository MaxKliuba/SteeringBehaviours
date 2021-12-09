public class Hunter extends Organism {

  private Weapon weapon;
  private ArrayList<Bullet> bullets;

  private long time;
  private boolean[] moves;

  public Hunter(Field field, Weapon weapon) {
    super(field, 1, 1, new PVector(field.getWidth() / 2, field.getHeight() / 2), 10, 30, color(0, 128, 128));

    this.weapon = weapon;
    bullets = new ArrayList<Bullet>();
    moves = new boolean[4];

    time = millis();
  }

  public Weapon getWeapon() {
    return weapon;
  }

  public void setWeapon(Weapon weapon) {
    this.weapon = weapon;
  }

  public ArrayList<Bullet> getBullets() {
    return bullets;
  }

  public void update() {
    for (int i = 0; i < bullets.size(); i++) {
      bullets.get(i).update();
      if (!bullets.get(i).isMoving()) {
        bullets.remove(i);
      }
    }

    applyMove();

    stroke(0);
    fill(getColor());
    ellipse(getPosition().x, getPosition().y, getSize(), getSize());
  }

  public void setMove(int i, boolean state) {
    moves[i] = state;
  }

  public void makeShot(PVector mousePosition) {
    Bullet bullet = weapon.makeShot(new PVector(getPosition().x, getPosition().y), new PVector(mousePosition.x - getPosition().x, mouseY - getPosition().y));

    if (bullet != null) {
      bullets.add(bullet);
    }
  }

  public void applyMove() {
    float deltaTime = (millis() - time) * 0.01f;
    time = millis();

    if (moves[0]) {
      getPosition().y -= getVelocityLimit() * deltaTime;
    } else if (moves[1]) {
      getPosition().y += getVelocityLimit() * deltaTime;
    }

    if (moves[2]) {
      getPosition().x -= getVelocityLimit() * deltaTime;
    } else if (moves[3]) {
      getPosition().x += getVelocityLimit() * deltaTime;
    }
  }
}
