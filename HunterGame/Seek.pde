public class Seek extends Target {

  public Seek(PVector position) {
    super(position);
  }

  public PVector getDesiredVelocity(Animal animal) {
    PVector distance = PVector.sub(getPosition(), animal.getPosition());
    //float k = 1;
    //float arriveRadius = animal.getVelocityLimit();
    //if (distance.mag() < arriveRadius) {
    //  k = distance.mag() / arriveRadius;
    //} else {
      
    //}
    
    if (distance.mag() > animal.getMaxFeelDistance()) {
      return null;
    }
    
    return distance.setMag(map(distance.mag(), 0, animal.getMaxFeelDistance(), animal.getMaxVelocityLimit(), 1));
    
    //float k = 1;
    //float arriveRadius = 50;
    //if (distance.mag() < arriveRadius) {
    //  k = distance.mag() / arriveRadius;
    //}

    //return distance.normalize().mult(animal.getMaxVelocityLimit() * k);
  }
}
