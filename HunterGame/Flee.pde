public class Flee extends Target {

  public Flee(PVector position) {
    super(position);
  }

  public PVector getDesiredVelocity(Animal animal) {
    PVector distance = PVector.sub(getPosition(), animal.getPosition());
    
    if (distance.mag() > animal.getMaxFeelDistance()) {
      return null;
    }
    //float k = 1;
    //float arriveRadius = 50;
    //if (distance.mag() < arriveRadius) {
    //  k = arriveRadius / distance.mag();
    //}

    return distance.normalize().mult(-animal.getMaxVelocityLimit());
    //return distance.setMag(map(distance.mag(), 1, animal.getMaxFeelDistance(), animal.getMaxVelocityLimit(), 1)).mult(-1);
  }
}
