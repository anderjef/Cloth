//Jeffrey Andersen

class Spring extends VerletSpring3D {
  Spring(Particle a, Particle b) {
    super(a, b, springRestLength, springConstant);
  }

  void show() {
    line(a.x, a.y, a.z, b.x, b.y, b.z);
  }
}
