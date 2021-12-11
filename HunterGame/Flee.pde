public class Flee extends DesiredVelocityProvider {

  public Flee(PVector position) {
    super(position);
  }

  public PVector getDesiredVelocity(Animal animal) {
    PVector distance = PVector.sub(getPosition(), animal.getPosition());

    if (distance.mag() > animal.getMaxFeelDistance()) {
      return null;
    }

    return distance.normalize().mult(-animal.getMaxVelocityLimit());
  }
}
