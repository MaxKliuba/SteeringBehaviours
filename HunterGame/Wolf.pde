public class Wolf extends Animal {

  private int damage;
  private int lifeSpan;

  private long lifeTimer;

  public Wolf(Field field, boolean avoidCursor) {
    super(field, 1, 1, 25, color(60, 60, 70), 40, 40, 10, 200, 0, avoidCursor);

    this.damage = 1;
    this.lifeSpan = 20000;

    this.lifeTimer = millis();
  }

  protected ArrayList<DesiredVelocityProvider> getDesiredVelocityProviders() {
    ArrayList<DesiredVelocityProvider> providers = new ArrayList<DesiredVelocityProvider>();

    providers.add(new AvoidEdges(new PVector(getPosition().x, field.getPosition().y)));
    providers.add(new AvoidEdges(new PVector(field.getPosition().x + field.getWidth(), getPosition().y)));
    providers.add(new AvoidEdges(new PVector(getPosition().x, field.getPosition().y + field.getHeight())));
    providers.add(new AvoidEdges(new PVector(field.getPosition().x, getPosition().y)));

    for (int i = 0; i < field.getOrganisms().size(); i++) {
      Organism organism = field.getOrganisms().get(i);

      if (!(organism instanceof Wolf)) {
        providers.add(new Seek(organism.getPosition().copy()));
      }
    }
    providers.add(new Wander(getPosition()));
    if (isAvoidCursor()) {
      providers.add(new Flee(new PVector(mouseX, mouseY)));
    }

    return providers;
  }

  public void update() {
    super.update();

    if (millis() - lifeTimer > lifeSpan) {
      applyDamage(getHealth());
    }
  }

  public int getDamage() {
    return damage;
  }

  public boolean canDoDamage(Organism organism) {
    if (PVector.sub(getPosition(), organism.getPosition()).mag() <= organism.getSize()) {
      lifeTimer = millis();
      return true;
    }

    return false;
  }
}
