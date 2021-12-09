public class Rebbit extends Animal {

  public Rebbit(Field field) {
    super(field, 1, 100, 10, 20, color(190, 190, 190));
  }

  protected ArrayList<Target> getTargets() {
    ArrayList<Target> targets = new ArrayList<Target>();
    targets.add(new Target(new PVector(mouseX, mouseY), true));

    return targets;
  }
}
