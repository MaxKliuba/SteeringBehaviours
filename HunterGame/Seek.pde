public class Seek extends Target {

  public Seek(PVector position) {
    super(position);
  }

  public PVector getDesiredVelocity(Animal animal) {
    PVector distance = PVector.sub(getPosition(), animal.getPosition());
    float k = 1;
    //float arriveRadius = animal.getVelocityLimit();
    //if (distance.mag() < arriveRadius) {
    //  k = distance.mag() / arriveRadius;
    //} else {
      
    //}
    return distance.setMag(map(distance.mag(), 1, animal.getMaxVelocityLimit(), animal.getMaxVelocityLimit(), 1));
  }
}
