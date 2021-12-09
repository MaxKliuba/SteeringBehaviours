public class Hunter {

  private Field field;
  private int health;
  private PVector position;
  private float velocity;
  private int size;
  private color hunterColor;
  private Weapon weapon;
  private ArrayList<Bullet> bullets = new ArrayList<Bullet>();

  private long time = millis();
  private boolean[] moves = new boolean[4];

  public Hunter(Field field) {
    this.field = field;
    health = 1;
    position = new PVector(field.getWidth() / 2, field.getHeight() / 2);
    velocity = 10;
    size = 30;
    hunterColor = color(0, 128, 128);
    this.weapon = new Weapon(10, 200, 1);
  }

  public PVector getPosition() {
    return position;
  }

  public Weapon getWeapon() {
    return weapon;
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

    fill(hunterColor);
    ellipse(position.x, position.y, size, size);
  }

  public void setMove(int i, boolean state) {
    moves[i] = state;
  }

  public void makeShot(PVector mousePosition) {
    Bullet bullet = weapon.makeShot(new PVector(position.x, position.y), new PVector(mousePosition.x - position.x, mouseY - position.y));

    if (bullet != null) {
      bullets.add(bullet);
    }
  }

  public void applyMove() {
    float deltaTime = (millis() - time) * 0.01f;
    time = millis();

    //if (keyPressed) 
    {
      if (moves[0]) {
        position.y -= velocity * deltaTime;
      } else if (moves[1]) {
        position.y += velocity * deltaTime;
      }

      if (moves[2]) {
        position.x -= velocity * deltaTime;
      } else if (moves[3]) {
        position.x += velocity * deltaTime;
      }
    }
  }
  
  public boolean isOnField() {
    if (position.x > field.getPosition().x && position.y > field.getPosition().y 
      && position.x < field.getPosition().x + field.getWidth() && position.y < field.getPosition().y + field.getHeight()) {
      return true;
    }

    return false;
  }
  
  public void doDamage(int damage) {
    health -= damage;
  }

  public boolean isAlive() {
    return health > 0;
  }
}
