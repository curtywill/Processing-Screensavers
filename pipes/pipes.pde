// Curtiss Williams
// 3D self-avoiding walker screensaver written in Processing4

float angle;
float spacing = 40;
int xSize, ySize, zSize;
int xSpot, ySpot, zSpot;
boolean [][][] grid;
PVector colour;
PVector step;

void setup() {
  size(800, 800, P3D);
  background(0);
  xSize = floor((width+200)/spacing); // make the grid a little bigger (200 px) than the actual resolution
  ySize = floor((height+200)/spacing);
  zSize = ySize;
  grid = new boolean[xSize][ySize][zSize];
  for (int x = 0; x < xSize; x++) {
    for (int y = 0; y < ySize; y++) {
      for (int z = 0; z < zSize; z++) {
        grid[x][y][z] = false;
      }
    }
  }
  reset();
  angle = random(-PI/4, PI/4);
}

void reset() {
  do {
    xSpot = floor(random(xSize));
    ySpot = floor(random(ySize));
    zSpot = floor(random(zSize));
  } while (grid[xSpot][ySpot][zSpot]); // loop until an empty spot is found
  colour = new PVector(random(255), random(255), random(255));
}

PVector getStep() {
  ArrayList<PVector> options = new ArrayList<PVector>();
  if (xSpot+1 < xSize && !grid[xSpot+1][ySpot][zSpot])options.add(new PVector(1, 0, 0));
  if (xSpot-1 >= 0 && !grid[xSpot-1][ySpot][zSpot])   options.add(new PVector(-1, 0, 0));
  if (ySpot+1 < ySize && !grid[xSpot][ySpot+1][zSpot])options.add(new PVector(0, 1, 0));
  if (ySpot-1 >= 0 && !grid[xSpot][ySpot-1][zSpot])   options.add(new PVector(0, -1, 0));
  if (zSpot+1 < zSize && !grid[xSpot][ySpot][zSpot+1])options.add(new PVector(0, 0, 1));
  if (zSpot-1 >= 0 && !grid[xSpot][ySpot][zSpot-1])   options.add(new PVector(0, 0, -1));
  int s = options.size();
  if (s == 0) {
    return null;
  }
  return options.get(floor(random(s)));
}

void draw() {
  if (frameCount % 1080 == 0) { // start a new animation
    for (int x = 0; x < xSize; x++) { // reset the grid
      for (int y = 0; y < ySize; y++) {
        for (int z = 0; z < zSize; z++) {
          grid[x][y][z] = false;
        }
      }
    }
    background(0);
    reset();
    angle = random(-PI/4, PI/4);
  }
  fill(colour.x, colour.y, colour.z);
  stroke(255);
  rotateY(angle);
  pushMatrix();
  translate(xSpot*spacing, ySpot*spacing, -zSpot*spacing); // -z so the boxes go backwards into the screen
  box(spacing);
  popMatrix();
  grid[xSpot][ySpot][zSpot] = true;
  step = getStep();
  if (step == null) {
    reset();
  } else {
    xSpot += step.x;
    ySpot += step.y;
    zSpot += step.z;
    if (xSpot >= xSize || xSpot < 0 || ySpot >= ySize || ySpot < 0 || zSpot >= zSize || zSpot < 0) {
      reset();
    }
  }
}
