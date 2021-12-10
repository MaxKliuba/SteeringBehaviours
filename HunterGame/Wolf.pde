public class Wolf extends Animal {

  private int damage;
  private int lifeSpan;

  private long lifeTimer;

  public Wolf(Field field) {
    super(field, 1, 1, 25, color(60, 60, 70), 40, 40, 10, 200, 0);

    this.damage = 1;
    this.lifeSpan = 20000;

    this.lifeTimer = millis();
  }

  protected ArrayList<Target> getTargets() {
    ArrayList<Target> targets = new ArrayList<Target>();

    targets.add(new AvoidEdges(new PVector(getPosition().x, field.getPosition().y)));
    targets.add(new AvoidEdges(new PVector(field.getPosition().x + field.getWidth(), getPosition().y)));
    targets.add(new AvoidEdges(new PVector(getPosition().x, field.getPosition().y + field.getHeight())));
    targets.add(new AvoidEdges(new PVector(field.getPosition().x, getPosition().y)));

    for (int i = 0; i < field.getOrganisms().size(); i++) {
      Organism organism = field.getOrganisms().get(i);

      if (!(organism instanceof Wolf)) {
        targets.add(new Seek(organism.getPosition().copy()));
      }
    }
    targets.add(new Wander(getPosition()));

    return targets;
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
