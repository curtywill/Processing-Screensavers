class Cube {
  PVector pos;
  color c;
  Cube() {
    pos = new PVector(random(width), random(height), random(100, 500));
    c = color(random(255), random(255), random(255));
  }

  void show() {
    pushMatrix();
    translate(pos.x, pos.y, -pos.z);
    stroke(c);
    float s = map(pos.z, 100, 500, 15, 0);
    box(s);
    popMatrix();
  }

  void update() {
    pos.z -= speed;
    if (this.done()) {
      pos = new PVector(random(width), random(height), random(100, 500));
      c = color(random(255), random(255), random(255));
    }
  }

  boolean done() {
    return pos.z < -200;
  }
}
