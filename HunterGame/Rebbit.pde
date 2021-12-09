public class Rebbit extends Animal {

  public Rebbit(Field field) {
    super(field, 1, 1, 150, 20, color(190, 190, 190), 10);
  }

  protected ArrayList<Target> getTargets() {
    ArrayList<Target> targets = new ArrayList<Target>();

    for (int i = 0; i < field.getOrganisms().size(); i++) {
      if (!field.getOrganisms().get(i).equals(this)) {
        targets.add(new Flee(field.getOrganisms().get(i).getPosition().copy()));
      }
    }
    targets.add(new Wander(getPosition()));
    targets.add(new Flee(new PVector(mouseX, mouseY)));

    return targets;
  }
}
