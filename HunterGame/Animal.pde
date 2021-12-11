public abstract class Animal extends Organism {

  private static final float EPSILON = 0.05f;

  private float steeringForceLimit;
  private float minVelocityLimit;
  private int minFeelDistance;
  private int maxFeelDistance;
  private PVector velocity;
  private PVector acceleration;

  private long time;

  public Animal(Field field, int health, int mass, int size, color objColor, 
    float maxVelocityLimit, float minVelocityLimit, float steeringForceLimit, int maxFeelDistance, int minFeelDistance) {
    super(field, health, mass, size, objColor, 
      new PVector(random(field.getPosition().x + 100, field.getWidth() - 100), random(field.getPosition().y + 100, field.getHeight() - 100)), maxVelocityLimit);

    this.minVelocityLimit = minVelocityLimit;
    this.steeringForceLimit = steeringForceLimit;
    this.maxFeelDistance = maxFeelDistance;
    this.minFeelDistance = minFeelDistance;

    this.velocity = new PVector(0.0f, 0.0f);
    this.acceleration = new PVector(0.0f, 0.0f);

    this.time = millis();
  }

  public float getMinVelocityLimit() {
    return minVelocityLimit;
  }

  public float getSteeringForceLimit() {
    return steeringForceLimit;
  }

  public int getMaxFeelDistance() {
    return maxFeelDistance;
  }

  public int getMinFeelDistance() {
    return minFeelDistance;
  }

  public PVector getVelocity() {
    return velocity;
  }

  public PVector getAcceleration() {
    return acceleration;
  }

  public void update() {
    applyFriction();

    applySteeringForce();

    applyForces();
  }

  protected abstract ArrayList<DesiredVelocityProvider> getDesiredVelocityProviders();

  private void applyForce(PVector force) {
    force.div(getMass());
    acceleration.add(force);
  }

  private void applyFriction() { 
    PVector friction = PVector.mult(velocity, -1).normalize().mult(0.5f);

    applyForce(friction);
  }

  private void applySteeringForce() {
    ArrayList<DesiredVelocityProvider> providers = getDesiredVelocityProviders();
    PVector steering = new PVector(0.0f, 0.0f);

    for (int i = 0; i < providers.size(); i++) {
      PVector desiredVelocity = providers.get(i).getDesiredVelocity(this);
      if (desiredVelocity != null) {
        steering.add(PVector.sub(desiredVelocity, velocity));
      }
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

    if (velocity.mag() > getMaxVelocityLimit()) {
      velocity.setMag(getMaxVelocityLimit());
    } else if (velocity.mag() < EPSILON) {
      velocity.set(0.0f, 0.0f);
    }

    acceleration.set(0.0f, 0.0f);
    setPosition(PVector.add(getPosition(), PVector.mult(velocity, deltaTime)));

    stroke(0);
    fill(getColor());
    circle(getPosition().x, getPosition().y, getSize());
  }
}
