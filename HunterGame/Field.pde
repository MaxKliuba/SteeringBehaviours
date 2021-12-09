public class Field {

  private int fieldWidth;
  private int fieldHeight;

  private color chasmColor;
  private color fieldColor;

  public Field (int fieldWidth, int fieldHeight, color chasmColor, color fieldColor) {
    this.fieldWidth = fieldWidth;
    this.fieldHeight = fieldHeight;
    this.chasmColor = chasmColor;
    this.fieldColor = fieldColor;
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

  public void update() {
    PVector position = getPosition();
    background(chasmColor);
    fill(fieldColor);
    rect(position.x, position.y, fieldWidth, fieldHeight, 15);
  }
}
