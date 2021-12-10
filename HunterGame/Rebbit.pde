public class Rebbit extends Animal {

  public Rebbit(Field field) {
    super(field, 1, 1, 15, color(190, 190, 190), 100, 10, 5, 100, 0);
  }

  protected ArrayList<Target> getTargets() {
    ArrayList<Target> targets = new ArrayList<Target>();

    targets.add(new AvoidEdges(new PVector(getPosition().x, field.getPosition().y)));
    targets.add(new AvoidEdges(new PVector(field.getPosition().x + field.getWidth(), getPosition().y)));
    targets.add(new AvoidEdges(new PVector(getPosition().x, field.getPosition().y + field.getHeight())));
    targets.add(new AvoidEdges(new PVector(field.getPosition().x, getPosition().y)));
    
    for (int i = 0; i < field.getOrganisms().size(); i++) {
      if (!field.getOrganisms().get(i).equals(this)) {
        targets.add(new Flee(field.getOrganisms().get(i).getPosition().copy()));
      }
    }
    targets.add(new Wander(getPosition()));
    //targets.add(new Flee(new PVector(mouseX, mouseY)));

    return targets;
  }
}
