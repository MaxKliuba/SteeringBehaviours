public class Target {

  private PVector position;
  private boolean isSeek;

  public Target(PVector position, boolean isSeek) {
    this.position = position;
    this.isSeek = isSeek;
  }

  public PVector getPosition() {
    return position;
  }

  public boolean isSeek() {
    return isSeek;
  }

  public float getDirection() {
    return isSeek ? 1 : -1;
  }

  public String toString() { 
    return String.format("[%s; %s]", position, getDirection());
  }
}
