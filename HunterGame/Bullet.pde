public class Bullet {

  private PVector startPosition;
  private PVector position;
  private PVector direction;
  private int maxDistance;
  private int damage;
  private float velocity;
  private int size;
  private color bulletColor;

  private long time = millis();

  public Bullet(PVector startPosition, PVector direction, int maxDistance, int damage) {
    this.startPosition = startPosition;
    this.position = startPosition.copy();
    this.direction = direction;
    this.maxDistance = maxDistance;
    this.damage = damage;
    this.velocity = 50;
    this.size = 5;
    this.bulletColor = color(0);
  }
  
  public int getDamage() {
    return damage;
  }

  public void update() {
    float deltaTime = (millis() - time) * 0.01f;
    time = millis();

    position.add(PVector.mult(direction, velocity * deltaTime));

    fill(bulletColor);
    ellipse(position.x, position.y, size, size);
  }

  public boolean isMoving() {
    return PVector.sub(position, startPosition).mag() <= maxDistance;
  }

  public boolean isHit(Animal animal) {
    return PVector.sub(position, animal.getPosition()).mag() <= animal.getSize();
  }
}
