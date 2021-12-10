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

    //float k = 1;
    //float arriveRadius = 200;
    //if (distance.mag() < arriveRadius) {
    //  k = arriveRadius / distance.mag();
    //}

    //return distance.normalize().mult(animal.getVelocityLimit() * -k);
    return distance.setMag(map(distance.mag(), 0, avoidDistance, -animal.getMaxVelocityLimit(), 0));
  }
}
