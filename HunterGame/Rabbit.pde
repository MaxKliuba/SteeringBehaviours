public class Rabbit extends Animal {

  public Rabbit(Field field, boolean avoidCursor) {
    super(field, 1, 1, 15, color(190, 190, 190), 70, 10, 5, 100, 0, avoidCursor);
  }

  protected ArrayList<DesiredVelocityProvider> getDesiredVelocityProviders() {
    ArrayList<DesiredVelocityProvider> providers = new ArrayList<DesiredVelocityProvider>();

    providers.add(new AvoidEdges(new PVector(getPosition().x, field.getPosition().y)));
    providers.add(new AvoidEdges(new PVector(field.getPosition().x + field.getWidth(), getPosition().y)));
    providers.add(new AvoidEdges(new PVector(getPosition().x, field.getPosition().y + field.getHeight())));
    providers.add(new AvoidEdges(new PVector(field.getPosition().x, getPosition().y)));

    for (int i = 0; i < field.getOrganisms().size(); i++) {
      Organism organism = field.getOrganisms().get(i);

      if (!organism.equals(this)) {
        providers.add(new Flee(organism.getPosition().copy()));
      }
    }
    providers.add(new Wander(getPosition()));
    if (isAvoidCursor()) {
      providers.add(new Flee(new PVector(mouseX, mouseY)));
    }

    return providers;
  }
}
