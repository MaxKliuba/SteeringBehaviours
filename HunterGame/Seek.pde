public class Seek extends DesiredVelocityProvider {

  public Seek(PVector position) {
    super(position);
  }

  public PVector getDesiredVelocity(Animal animal) {
    PVector distance = PVector.sub(getPosition(), animal.getPosition());

    if (distance.mag() > animal.getMaxFeelDistance()) {
      return null;
    }

    float k = distance.mag() < animal.getMinFeelDistance() ? -1.5 : 1;

    return distance.setMag(map(distance.mag(), 0, animal.getMaxFeelDistance(), animal.getMaxVelocityLimit(), 0)).mult(k);
  }
}
