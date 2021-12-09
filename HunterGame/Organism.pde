public abstract class Organism {

  private Field field;
  private int health;
  private PVector position;
  private float velocityLimit;
  private float mass;
  private int size;
  private color objColor;

  public Organism(Field field, int health, int mass, PVector position, float velocityLimit, int size, color objColor) {
    this.field = field;
    this.health = health;
    this.mass = mass;
    this.position = position;
    this.velocityLimit = velocityLimit;
    this.size = size;
    this.objColor = objColor;
  }

  public Field getField() {
    return field;
  }

  public int getHealth() {
    return health;
  }

  public void setHealth(int health) {
    this.health = health;
  }

  public float getMass() {
    return mass;
  }

  public void setMass(float mass) {
    this.mass = mass;
  }

  public PVector getPosition() {
    return position;
  }

  public void setPosition(PVector position) {
    this.position = position;
  }

  public float getVelocityLimit() {
    return velocityLimit;
  }

  public int getSize() {
    return size;
  }

  public color getColor() {
    return objColor;
  }

  public abstract void update();

  public boolean isOnField() {
    if (position.x > field.getPosition().x && position.y > field.getPosition().y 
      && position.x < field.getPosition().x + field.getWidth() && position.y < field.getPosition().y + field.getHeight()) {    
      return true;
    }

    doDamage(health);

    return false;
  }

  public boolean doDamage(int damage) {
    health -= damage;

    return !isAlive();
  }

  public boolean isAlive() {
    return health > 0;
  }
}
