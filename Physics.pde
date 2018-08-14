class PhysicsObject {
  float mass;
  float damping;
  PVector position;
  PVector velocity;
  
  List<PVector> forces;
  
  PhysicsObject(PVector position) {
    mass = 1;
    damping = 0.1;
    this.position = position;
    velocity = new PVector();
    forces = new ArrayList();
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
    forces = new ArrayList();
  }
  
  void move() {
    position.add(velocity);
  }
}
