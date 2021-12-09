public class Field {

  private int fieldWidth;
  private int fieldHeight;

  private color chasmColor;
  private color fieldColor;

  private ArrayList<Organism> organisms;

  public Field (int fieldWidth, int fieldHeight, color chasmColor, color fieldColor) {
    this.fieldWidth = fieldWidth;
    this.fieldHeight = fieldHeight;
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

  public PVector getPosition() {
    return new PVector((width - fieldWidth) / 2, (height - fieldHeight) / 2);
  }

  public ArrayList<Organism> getOrganisms() {
    return organisms;
  }

  public void addOrganism(Organism organism) {
    organisms.add(organism);
  }

  public void update() {
    PVector position = getPosition();
    background(chasmColor);
    fill(fieldColor);
    rect(position.x, position.y, fieldWidth, fieldHeight, 15);
  }
  
  public void reset() {
    organisms = new ArrayList<Organism>();
  }
}
