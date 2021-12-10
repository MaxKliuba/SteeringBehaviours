public class Wolf extends Animal {

  private int damage;
  private int lifeSpan;

  private long lifeTimer;

  public Wolf(Field field, int damage, int lifeSpan) {
    super(field, 1, 1, 25, color(60, 60, 70), 75, 75, 10, 300, 0);

    this.damage = damage;
    this.lifeSpan = lifeSpan;

    lifeTimer = millis();
  }

  protected ArrayList<Target> getTargets() {
    ArrayList<Target> targets = new ArrayList<Target>();

    targets.add(new AvoidEdges(new PVector(getPosition().x, field.getPosition().y)));
    targets.add(new AvoidEdges(new PVector(field.getPosition().x + field.getWidth(), getPosition().y)));
    targets.add(new AvoidEdges(new PVector(getPosition().x, field.getPosition().y + field.getHeight())));
    targets.add(new AvoidEdges(new PVector(field.getPosition().x, getPosition().y)));

    for (int i = 0; i < field.getOrganisms().size(); i++) {
      Organism organism = field.getOrganisms().get(i);

      if (organism instanceof Rebbit || organism instanceof Hunter) {
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
