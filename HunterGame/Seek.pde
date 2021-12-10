public class Seek extends Target {

  public Seek(PVector position) {
    super(position);
  }

  public PVector getDesiredVelocity(Animal animal) {
    PVector distance = PVector.sub(getPosition(), animal.getPosition());

    if (distance.mag() > animal.getMaxFeelDistance() || distance.mag() < animal.getMinFeelDistance()) {
      return null;
    }

    return distance.setMag(map(distance.mag(), 0, animal.getMaxFeelDistance(), animal.getMaxVelocityLimit(), 0));
  }
}
