class Ribbon {
  PVector[] start;
  PVector[] c1;
  PVector[] c2;
  PVector[] end;
  float[] t;
  int curves;
  int current;
  float transparency;
  color c;

  Ribbon() {
    curves = floor(random(1, 4));
    current = 0;
    t = new float[curves];
    for (int i = 0; i < curves; i++) t[i] = 0;
    start = new PVector[curves];
    c1 = new PVector[curves];
    c2 = new PVector[curves];
    end = new PVector[curves];
    c = color(random(360), random(50, 100), 100);
    transparency = 255;
    setPoints();
  }

  PVector getOffScreenPoint() {
    float dir = random(1);
    if (dir < 0.25) return new PVector(random(width), random(-150, -50));
    else if (dir < 0.5) return new PVector(width+random(50, 150), random(height));
    else if (dir < 0.75) return new PVector(random(width), height+random(50, 150));
    return new PVector(random(-150, -50), random(height));
  }

  void setPoints() {
    start[0] = getOffScreenPoint();
    end[curves-1] = getOffScreenPoint();

    for (int i = 0; i < curves; i++) {
      if (i > 0) start[i] = end[i-1];
      c1[i] = new PVector(random(width), random(height));
      c2[i] = new PVector(random(width), random(height));
      if (i < curves-1) end[i] = new PVector(random(width), random(height));
    }
  }

  boolean done() {
    return transparency <= 0;
  }

  void show() {
    stroke(c, transparency);
    strokeWeight(16);
    noFill();
    if (t[current] > 1) {
      current++;
    }
    current = constrain(current, 0, curves-1);
    for (int i = 0; i <= current; i++) {
      beginShape();
      for (float _t = 0; _t <= t[i]; _t += 0.05) {
        PVector p = cubicBezier(start[i], c1[i], c2[i], end[i], _t);
        vertex(p.x, p.y);
      }
      endShape();
    }
    t[current] += 0.05;
    if (current == curves-1) transparency -= 5;
  }
}
