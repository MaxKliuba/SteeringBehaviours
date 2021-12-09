public abstract class Animal extends Organism {

  private static final float EPSILON = 0.05f;

  private float steeringForceLimit;
  private PVector velocity;
  private PVector acceleration;

  private long time;

  public Animal(Field field, int health, int mass, float velocityLimit, int size, color objColor, float steeringForceLimit) {
    super(field, health, mass, new PVector(random(field.getPosition().x + 100, field.getWidth() - 100), random(field.getPosition().y + 100, field.getHeight() - 100)), velocityLimit, size, objColor);

    this.steeringForceLimit = steeringForceLimit;

    this.velocity = new PVector(0.0f, 0.0f);
    this.acceleration = new PVector(0.0f, 0.0f);

    time = millis();
  }

  public float getSteeringForceLimit() {
    return steeringForceLimit;
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

  protected abstract ArrayList<Target> getTargets();

  private void applyForce(PVector force) {
    force.div(getMass());
    acceleration.add(force);
  }

  private void applyFriction() { 
    PVector friction = PVector.mult(velocity, -1).normalize().mult(0.5f);

    applyForce(friction);
  }

  private void applySteeringForce() {
    ArrayList<Target> targets = getTargets();
    targets.add(new AvoidEdges(new PVector(getPosition().x, field.getPosition().y)));
    targets.add(new AvoidEdges(new PVector(field.getPosition().x + field.getWidth(), getPosition().y)));
    targets.add(new AvoidEdges(new PVector(getPosition().x, field.getPosition().y + field.getHeight())));
    targets.add(new AvoidEdges(new PVector(field.getPosition().x, getPosition().y)));

    PVector steering = new PVector(0.0f, 0.0f);

    for (int i = 0; i < targets.size(); i++) {
      PVector desiredVelocity = targets.get(i).getDesiredVelocity(this);
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

    if (velocity.mag() > getVelocityLimit()) {
      velocity.setMag(getVelocityLimit());
    } else if (velocity.mag() < EPSILON) {
      velocity.set(0.0f, 0.0f);
    }

    acceleration.set(0.0f, 0.0f);
    setPosition(PVector.add(getPosition(), PVector.mult(velocity, deltaTime)));

    stroke(0);
    fill(getColor());
    ellipse(getPosition().x, getPosition().y, getSize(), getSize());
  }
}
