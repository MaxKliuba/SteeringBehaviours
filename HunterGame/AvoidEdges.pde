public class AvoidEdges extends DesiredVelocityProvider {

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
  }
}
