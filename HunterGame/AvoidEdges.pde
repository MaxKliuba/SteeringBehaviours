public class AvoidEdges extends Target {

  public AvoidEdges(PVector position) {
    super(position);
  }

  public PVector getDesiredVelocity(Animal animal) {
    float avoidDistance = 100;  
    PVector distance = getPosition().sub(animal.getPosition());

    if (distance.mag() > avoidDistance) {
      return null;
    }

    return distance.normalize().mult(-animal.getMaxVelocityLimit());
    //return distance.setMag(map(distance.mag(), 0, avoidDistance, -animal.getMaxVelocityLimit(), 0));
  }
}
