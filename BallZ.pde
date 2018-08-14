import java.util.List;
import java.util.Random;


List<Ball> ballz;
Random random;

void settings() {
  size(displayWidth / 2, displayHeight / 2);
}

void setup() {
  setupGraphics();
  setupInput();
  
  ballz = new ArrayList(1);
  random = new Random();
  
  ballz.add(new Ball(true));
  for(int i = 0; i < 8; i++) {
    ballz.add(new Ball());
  }
}

void draw() {
  surface.setTitle("FPS: " + round(frameRate));
  
  for(Ball ball : ballz) {
    ball.update();
  }
  
  background(0);
  for(Ball ball : ballz) {
    ball.draw();
  }
}

void setupGraphics() {
  surface.setResizable(true);
}
