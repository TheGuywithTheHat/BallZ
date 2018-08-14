static final int DETAIL = 32; // number of points
static final float SIZE = 64; // radius

static final float MOVE_ACCEL = 0.7;

class Ball extends PhysicsObject {
  PhysicsObject[] vertices;
  boolean control;
  
  Ball() {
    super(new PVector(random.nextInt(width), random.nextInt(height)));
    
    vertices = new PhysicsObject[DETAIL];
    PVector vertexOffset = new PVector(0, -SIZE);
    for(int i = 0; i < vertices.length; i++) {
      vertices[i] = new PhysicsObject(PVector.add(position, vertexOffset));
      vertexOffset.rotate(TWO_PI / DETAIL);
    }
    control = false;
  }
  
  Ball(boolean control) {
    this();
    this.control = control;
  }
  
  void update() {
    if(control) {
      if(getKey(KEY_UP)) {
        forces.add(new PVector(0, -MOVE_ACCEL));
      }
      if(getKey(KEY_DOWN)) {
        forces.add(new PVector(0, MOVE_ACCEL));
      }
      if(getKey(KEY_LEFT)) {
        forces.add(new PVector(-MOVE_ACCEL, 0));
      }
      if(getKey(KEY_RIGHT)) {
        forces.add(new PVector(MOVE_ACCEL, 0));
      }
    }
    
    commitForces();
    move();
    
    for(int i = 0; i < vertices.length; i++) {
      PhysicsObject vertex = vertices[i];
      
      /*
      PVector target = new PVector(0, -SIZE).rotate(TWO_PI / DETAIL * i).add(position);
      vertex.forces.add(target.sub(vertex.position).mult(0.1));
      */

      PVector rotTarget = PVector.add(vertices[Math.floorMod(i - 1, vertices.length)].position, vertices[Math.floorMod(i + 1, vertices.length)].position);
      vertex.forces.add(rotTarget.mult(0.5).sub(vertex.position).mult(0.1));
      
      PVector radialForce = PVector.sub(vertex.position, position).setMag(SIZE - PVector.dist(vertex.position, position));
      vertex.forces.add(radialForce.mult(0.3));
      
      for(int j = 0; j < vertices.length; j++) {
        if(j == i) {
          continue;
        }
        float dist = TWO_PI * SIZE / DETAIL;
        if(PVector.dist(vertex.position, vertices[j].position) < dist) {
          PVector correctionForce = PVector.sub(vertex.position, vertices[j].position);
          correctionForce.setMag(dist - correctionForce.mag());
          vertex.forces.add(correctionForce.mult(0.3));
        }
      }
      
      for(Ball ball : ballz) {
        if(ball == this) {
          continue;
        }
        if(PVector.dist(vertex.position, ball.position) < SIZE) {
          PVector repelForce = PVector.sub(vertex.position, ball.position);
          repelForce.setMag(SIZE - repelForce.mag());
          vertex.forces.add(repelForce.mult(0.2));
        }
      }
      
      vertex.commitForces();
    }
    for(PhysicsObject vertex : vertices) {
      vertex.move();
    }
    
    PVector middleTarget = new PVector();
    for(PhysicsObject vertex : vertices) {
      middleTarget.add(vertex.position);
    }
    forces.add(middleTarget.div(DETAIL).sub(position).mult(0.03));
  }
  
  void draw() {
    stroke(200, 64, 64);
    strokeWeight(1);
    fill(255, 192);
    beginShape();
    for(PhysicsObject vertex : vertices) {
      vertex(vertex.position.x, vertex.position.y);
    }
    endShape(CLOSE);
    strokeWeight(4);
    point(position.x, position.y);
  }
}
