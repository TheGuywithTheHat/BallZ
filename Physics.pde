class PhysicsObject {
  float mass;
  float damping;
  PVector position;
  PVector velocity;
  
  List<PVector> forces;
  
  PhysicsObject(PVector position) {
    mass = 1;
    damping = 1;
    this.position = position;
  }
  
  void commitForces() {
    PVector friction = PVector.mult(velocity, -damping);
    forces.add(friction);
    
    PVector accel = new PVector();
    for(PVector force : forces) {
      accel.add(force);
    }
    accel.div(mass);
    velocity.add(accel);
  }
  
  void move() {
    position.add(velocity);
  }
}
