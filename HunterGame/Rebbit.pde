public class Rebbit extends Animal {

  public Rebbit() {
    super(1, 10, 1, 20, color(190, 190, 190));
  }

  protected PVector[] getTargets() {
    return new PVector[] {new PVector(mouseX, mouseY)};
  }
}
