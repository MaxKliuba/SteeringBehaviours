public abstract class Animal {

  private static final float EPSILON = 0.05f;

  private Field field;
  private int health;
  private PVector position;
  private PVector velocity;
  private PVector acceleration;
  private float mass;
  private float velocityLimit;
  private float steeringForceLimit;
  private int size;
  private color animalColor;

  private long time = millis();

  public Animal(Field field, int mass, float velocityLimit, float steeringForceLimit, int size, color animalColor) {
    this.field = field;
    health = 1;
    this.position = new PVector(random(field.getPosition().x, field.getWidth()), random(field.getPosition().y, field.getHeight()));
    this.velocity = new PVector(0.0f, 0.0f);
    this.acceleration = new PVector(0.0f, 0.0f);

    this.mass = mass;
    this.velocityLimit = velocityLimit;
    this.steeringForceLimit = steeringForceLimit;
    this.size = size;
    this.animalColor = animalColor;
  }

  public PVector getPosition() {
    return position;
  }

  public int getSize() {
    return size;
  }

  public void update() {
    applyFriction();

    applySteeringForce();

    applyForces();
  }

  protected abstract ArrayList<Target> getTargets();

  private void applyForce(PVector force) {
    force.div(mass);
    acceleration.add(force);
  }

  private void applyFriction() { 
    PVector friction = PVector.mult(velocity, -1).normalize().mult(0.5f);

    applyForce(friction);
  }

  private void applySteeringForce() {
    ArrayList<Target> targets = getTargets();
    //targets.add(new Target(new PVector(position.x, field.getPosition().y), false));
    //targets.add(new Target(new PVector(field.getPosition().x + field.getWidth(), position.y), false));
    //targets.add(new Target(new PVector(position.x, field.getPosition().y + field.getHeight()), false));
    //targets.add(new Target(new PVector(field.getPosition().x, position.y), false));
    //println(targets);

    PVector steering = new PVector(0.0f, 0.0f);

    for (int i = 0; i < targets.size(); i++) {
      PVector desiredVelocity = getDesiredVelocity(targets.get(i));
      steering.add(PVector.sub(desiredVelocity, velocity));
    }
    steering.sub(velocity);

    if (steering.mag() > steeringForceLimit) {
      steering.setMag(steeringForceLimit);
    }

    applyForce(steering);
  }

  private void applyForces() {
    float deltaTime = (millis() - time) * 0.01f;
    time = millis();

    velocity.add(PVector.mult(acceleration, deltaTime));

    if (velocity.mag() > velocityLimit) {
      velocity.setMag(velocityLimit);
    } else if (velocity.mag() < EPSILON) {
      velocity.set(0.0f, 0.0f);
    }

    acceleration.set(0.0f, 0.0f);
    position.add(PVector.mult(velocity, deltaTime));

    fill(animalColor);
    ellipse(position.x, position.y, size, size);
  }

  private PVector getDesiredVelocity(Target target) {
    PVector distance = target.getPosition().sub(position);
    float k = 1;
    float arriveRadius = velocityLimit;
    if (distance.mag() < arriveRadius) {
      k = distance.mag() / arriveRadius;
    }

    return distance.normalize().mult(velocityLimit * k).div(target.getDirection());
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
