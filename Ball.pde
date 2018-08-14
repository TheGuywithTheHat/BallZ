static final int DETAIL = 8; // number of points
static final int SIZE = 64; // radius

class Ball extends PhysicsObject {
  PhysicsObject[] vertices;
  
  Ball() {
    super(new PVector(random.nextInt(width), random.nextInt(height)));
    
    vertices = new PhysicsObject[DETAIL];
    PVector vertexOffset = new PVector(0, -SIZE);
    for(int i = 0; i < vertices.length; i++) {
      vertices[i] = new PhysicsObject(PVector.add(position, vertexOffset));
      vertexOffset.rotate(TWO_PI / DETAIL);
    }
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
  }
}
