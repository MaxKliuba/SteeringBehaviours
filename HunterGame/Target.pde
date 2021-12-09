public abstract class Target {

  private PVector position;

  public Target(PVector position) {
    this.position = position;
  }

  public PVector getPosition() {
    return position;
  }
  
  public abstract PVector getDesiredVelocity(Animal animal);

  public String toString() { 
    return String.format("[%s; %s]", position);
  }
}
