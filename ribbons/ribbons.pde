// Curtiss Williams
// Ribbons screensaver inspired by https://www.youtube.com/watch?v=cElhIDdGz7M using Bezier curves in Processing 4
ArrayList<Ribbon> ribs;

void setup() {
  size(800, 800);
  frameRate(20);
  colorMode(HSB, 360, 100, 100);
  ribs = new ArrayList<Ribbon>();
}

// formula from https://en.wikipedia.org/wiki/B%C3%A9zier_curve#Cubic_B%C3%A9zier_curves
PVector cubicBezier(PVector p0, PVector p1, PVector p2, PVector p3, float t) { // returns a point on the cubic bezier curve where 0 <= t <= 1
  float a = pow(1-t, 3);
  float b = 3 * pow(1-t, 2) * t;
  float c = 3 * (1-t) * pow(t, 2);
  float d = pow(t, 3);
  float x = a * p0.x + b * p1.x + c * p2.x + d * p3.x;
  float y = a * p0.y + b * p1.y + c * p2.y + d * p3.y;

  return new PVector(x, y);
}

void draw() {
  background(0);
  if (ribs.size() == 0) {
    for (int i = 0; i < floor(random(6)); i++) {
      ribs.add(new Ribbon());
    }
  }
  for (int i = ribs.size()-1; i >= 0 ; i--) {
    Ribbon rib = ribs.get(i);
    rib.show();
    if (rib.done()) {
      ribs.remove(i);
    }
  }
}
