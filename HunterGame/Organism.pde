public abstract class Organism {

  private Field field;
  private int health;
  private float mass;
  private int size;
  private color objColor;
  private PVector position;
  private float maxVelocityLimit;

  public Organism(Field field, int health, int mass, int size, color objColor, PVector position, float maxVelocityLimit) {
    this.field = field;
    this.health = health;
    this.mass = mass;
    this.size = size;
    this.objColor = objColor;
    this.position = position;
    this.maxVelocityLimit = maxVelocityLimit;
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

  public int getSize() {
    return size;
  }

  public color getColor() {
    return objColor;
  }

  public void setPosition(PVector position) {
    this.position = position;
  }

  public float getMaxVelocityLimit() {
    return maxVelocityLimit;
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
