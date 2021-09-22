//Jeffrey Andersen

import toxi.geom.*;
import toxi.physics3d.*;
import toxi.physics3d.behaviors.*;

int w = 1600, h = 900;
float resolution = 20; //note that springs like to get tangled up (unrealistically so thought to be because of how the ToxicLibs library is implemented) for higher resolution values
float particleRadius = 0;
float springRestLength = 30; //note that springs like to get tangled up (unrealistically so thought to be because of how the ToxicLibs library is implemented) for lower spring rest lengths
float springConstant = 1.5; //note that springs like to get tangled up (unrealistically so thought to be because of how the ToxicLibs library is implemented) for higher spring constants
boolean holdDraggableParticles = false;

int numRows = int(h / resolution), numColumns = int(w / resolution);
ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Spring> springs = new ArrayList<Spring>();
VerletPhysics3D physics = new VerletPhysics3D();
ArrayList<Particle> draggableParticles = new ArrayList<Particle>(); //middle few particles are draggable via the mouse

void setup() {
  size(1600, 1600, P3D);
  physics.addBehavior(new GravityBehavior3D(new Vec3D(0, 1, 0)));
  for (int row = 0; row < numRows; row++) {
    for (int column = 0; column < numColumns; column++) {
      Particle p = new Particle(column * resolution, height / 8, -9 * min(width, height) / 16 + row * resolution);
      particles.add(p);
      physics.addParticle(p);
    }
  }
  particles.get(0).lock();
  particles.get(numColumns - 1).lock();
  particles.get((numRows - 1) * numColumns).lock();
  particles.get(numRows * numColumns - 1).lock();
  draggableParticles.add(particles.get(floor((numRows - 1) / 2.0) * numColumns + floor((numColumns - 1) / 2.0)));
  if (numColumns % 2 == 0) {
    draggableParticles.add(particles.get(floor((numRows - 1) / 2.0) * numColumns + ceil((numColumns - 1) / 2.0)));
  }
  if (numRows % 2 == 0) {
    draggableParticles.add(particles.get(ceil((numRows - 1) / 2.0) * numColumns + floor((numColumns - 1) / 2.0)));
    if (numColumns % 2 == 0) {
      draggableParticles.add(particles.get(ceil((numRows - 1) / 2.0) * numColumns + ceil((numColumns - 1) / 2.0)));
    }
  }
  for (int row = 0; row < numRows; row++) {
    for (int column = 0; column < numColumns; column++) {
      if (column != numColumns - 1) { //if not last column
        Spring s = new Spring(particles.get(row * numColumns + column), particles.get(row * numColumns + column + 1));
        springs.add(s);
        physics.addSpring(s);
      }
      if (row != numRows - 1) { //if not last row
        Spring s = new Spring(particles.get(row * numColumns + column), particles.get(row * numColumns + column + numColumns));
        springs.add(s);
        physics.addSpring(s);
      }
    }
  }
  println(springs.size());
  fill(255);
  stroke(255);
}

void draw() {
  background(0);
  if (mousePressed) {
    for (Particle p : draggableParticles) {
      p.x = mouseX;
      p.y = mouseY;
      if (holdDraggableParticles) {
        p.lock();
      }
    }
  }
  physics.update();
  if (particleRadius != 0) {
    for (Particle p : particles) {
      p.show();
    }
  }
  for (Spring s : springs) {
    s.show();
  }
}
