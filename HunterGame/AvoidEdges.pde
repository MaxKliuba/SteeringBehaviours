public class AvoidEdges extends Target {

  public AvoidEdges(PVector position) {
    super(position);
  }

  public PVector getDesiredVelocity(Animal animal) {
    PVector distance = getPosition().sub(animal.getPosition());
    float k = 1;
    float arriveRadius = 200;
    if (distance.mag() < arriveRadius) {
      k = arriveRadius / distance.mag();
    }

    return distance.normalize().mult(animal.getVelocityLimit() * -k);
  }
}
