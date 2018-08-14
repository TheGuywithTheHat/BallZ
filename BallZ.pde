import java.util.List;
import java.util.Random;


List<Ball> ballz;
Random random;

void settings() {
  fullScreen();
}

void setup() {
  setupGraphics();
  
  
  ballz = new ArrayList<>(1);
  random = new Random();
  
  ballz.add(new Ball());
}

void draw() {
  surface.setTitle("FPS: " + frameRate);
}

void setupGraphics() {
  surface.setResizable(true);
}
