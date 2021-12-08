ArrayList<Animal> animals = new ArrayList<Animal>();

void setup() {
  size(1200, 600, P2D);
  smooth(4);
  frameRate(60);
  background(color(46, 33, 31));

  animals.add(new Rebbit());
}

void draw() {
  fill(color(80, 140, 43));
  rect(50, 50, width - 100, height - 100, 15);

  for (int i = 0; i < animals.size(); i++) {
    animals.get(i).update();
  }
}
