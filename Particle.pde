//Jeffrey Andersen

class Particle extends VerletParticle3D {
  Particle(float x, float y, float z) {
    super(x, y, z);
  }

  void show() {
    pushMatrix();
    translate(x, y, z);
    sphere(particleRadius);
    popMatrix();
  }
}
