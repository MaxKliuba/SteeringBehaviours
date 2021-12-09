public class Wander extends Target {

  private float circleDistance = 100;
  private float circleRadius = 100;
  private int angleChangeStep = 15;
  private int angle = 0;

  public Wander(PVector position) {
    super(position);
  }

  public PVector getDesiredVelocity(Animal animal) {
    //float rnd = random(0, 2);
    //if (rnd < 1) {
    //  angle += angleChangeStep;
    //} else {
    //  angle -= angleChangeStep;
    //}

    //PVector futurePos = PVector.add(animal.getPosition(), animal.getVelocity()).normalize().mult(circleDistance);
    //PVector vector = new PVector(cos(radians(angle)), sin(radians(angle))).mult(circleRadius);

    //return PVector.add(futurePos, vector).sub(animal.getPosition()).normalize().mult(animal.getVelocityLimit());
    
    return animal.getVelocity().copy().rotate(radians(1));
  }
}
