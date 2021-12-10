public class Deer extends Animal {

  public Deer(Field field) {
    super(field, 1, 1, 20, color(210, 90, 40), 25, 25, 10, 300, 50);
  }

  protected ArrayList<Target> getTargets() {
    ArrayList<Target> targets = new ArrayList<Target>();

    targets.add(new AvoidEdges(new PVector(getPosition().x, field.getPosition().y)));
    targets.add(new AvoidEdges(new PVector(field.getPosition().x + field.getWidth(), getPosition().y)));
    targets.add(new AvoidEdges(new PVector(getPosition().x, field.getPosition().y + field.getHeight())));
    targets.add(new AvoidEdges(new PVector(field.getPosition().x, getPosition().y)));

    for (int i = 0; i < field.getOrganisms().size(); i++) {
      Organism organism = field.getOrganisms().get(i);

      if (organism instanceof Deer) {
        targets.add(new Seek(organism.getPosition().copy()));
      }

      if (organism instanceof Wolf || organism instanceof Hunter) {
        targets.add(new Flee(organism.getPosition().copy()));
      }
    }
    targets.add(new Wander(getPosition()));
    //targets.add(new Flee(new PVector(mouseX, mouseY)));

    return targets;
  }
}
