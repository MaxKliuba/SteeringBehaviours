public class Bullet {

  private PVector startPosition;
  private PVector position;
  private PVector direction;
  private int maxDistance;
  private int damage;
  private float velocityLimit;
  private int size;
  private color objColor;

  private long time;

  public Bullet(PVector startPosition, PVector direction, int maxDistance, int damage) {
    this.startPosition = startPosition;
    this.position = startPosition.copy();
    this.direction = direction;
    this.maxDistance = maxDistance;
    this.damage = damage;
    this.velocityLimit = 50;
    this.size = 5;
    this.objColor = color(0);

    time = millis();
  }

  public int getDamage() {
    return damage;
  }

  public void update() {
    float deltaTime = (millis() - time) * 0.01f;
    time = millis();

    position.add(PVector.mult(direction, velocityLimit * deltaTime));

    noStroke();
    fill(objColor);
    circle(position.x, position.y, size);
  }

  public boolean isMoving() {
    return PVector.sub(position, startPosition).mag() <= maxDistance;
  }

  public boolean canDoDamage(Organism organism) {
    return PVector.sub(position, organism.getPosition()).mag() <= organism.getSize();
  }
}
