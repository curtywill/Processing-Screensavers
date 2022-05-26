// Curtiss Williams
// Flying cube screensaver made in Processing 4
Cube[] cubes;
float speed = 10;
int size = 250;

void setup() {
  size(800, 800, P3D);
  cubes = new Cube[size];
  for (int i = 0; i < size; i++) {
    cubes[i] = new Cube();
  }
}

void draw() {
  background(0);
  noFill();
  for (int i = 0; i < size; i++) {
    cubes[i].update();
    cubes[i].show();
  }
}
