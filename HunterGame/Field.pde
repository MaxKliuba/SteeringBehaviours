public class Field {

  private int fieldWidth;
  private int fieldHeight;
  private int chasmSize;

  private color chasmColor;
  private color fieldColor;

  private ArrayList<Organism> organisms;

  public Field (int fieldWidth, int fieldHeight, int chasmSize, color chasmColor, color fieldColor) {
    this.fieldWidth = fieldWidth;
    this.fieldHeight = fieldHeight;
    this.chasmSize = chasmSize;
    this.chasmColor = chasmColor;
    this.fieldColor = fieldColor;

    reset();
  }

  public int getWidth() {
    return fieldWidth;
  }

  public int getHeight() {
    return fieldHeight;
  }

  public int getChasmSize() {
    return chasmSize;
  }

  public PVector getPosition() {
    return new PVector(chasmSize, chasmSize);
  }

  public ArrayList<Organism> getOrganisms() {
    return organisms;
  }

  public void addOrganism(Organism organism) {
    organisms.add(organism);
  }

  public void update() {
    background(chasmColor);
    fill(fieldColor);
    rect(getPosition().x, getPosition().y, fieldWidth, fieldHeight, 15);
  }

  public void reset() {
    organisms = new ArrayList<Organism>();
  }
}
