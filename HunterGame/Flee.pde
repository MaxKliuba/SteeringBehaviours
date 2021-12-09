public class Flee extends Target {

  public Flee(PVector position) {
    super(position);
  }

  public PVector getDesiredVelocity(Animal animal) {
    PVector distance = getPosition().sub(animal.getPosition());
    //float k = 1;
    //float arriveRadius = 50;
    //if (distance.mag() < arriveRadius) {
    //  k = arriveRadius / distance.mag();
    //}

    return distance.setMag(map(distance.mag(), 1, field.getWidth(), animal.getVelocityLimit(), 0)).mult(-1);
  }
}
