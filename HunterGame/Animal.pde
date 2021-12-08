public abstract class Animal {

  private final float EPSILON = 0.05f;

  private PVector position;
  private PVector velocity;
  private PVector acceleration;
  private float mass;
  private float velocityLimit;
  private float steeringForceLimit;
  private int size;
  private color animalColor;

  private long time = millis();

  public Animal(int mass, float velocityLimit, float steeringForceLimit, int size, color animalColor) {
    this.position = new PVector(100.0f, 100.0f);
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

  public void update() {
    applyFriction();

    applySteeringForce();

    applyForces();
  }

  protected abstract PVector[] getTargets();

  private void applyForce(PVector force) {
    force.div(mass);
    acceleration.add(force);
  }

  private void applyFriction() { 
    PVector friction = PVector.mult(velocity, -1).normalize().mult(0.5f);;

    applyForce(friction);
  }

  private void applySteeringForce() {
    PVector[] targets = getTargets();
    PVector steering = new PVector(0.0f, 0.0f);

    for (int i = 0; i < targets.length; i++) {
      PVector desiredVelocity = getDesiredVelocity(targets[i]);
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

  private PVector getDesiredVelocity(PVector target) {
    PVector distance = new PVector(target.x, target.y);
    distance.sub(position);
    float k = 1;
    float arriveRadius = velocityLimit;
    if (distance.mag() < arriveRadius) {
      k = distance.mag() / arriveRadius;
    }

    return distance.normalize().mult(velocityLimit * k);
  }
}
