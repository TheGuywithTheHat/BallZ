import java.awt.event.KeyEvent;

final int KEY_UP = KeyEvent.VK_W;
final int KEY_DOWN = KeyEvent.VK_S;
final int KEY_LEFT = KeyEvent.VK_A;
final int KEY_RIGHT = KeyEvent.VK_D;

boolean[] keys;

void setupInput() {
  keys = new boolean[526];
}

boolean getKey(int _keyCode) {
  if(_keyCode >= keys.length) {
    return false;
  } else {
    return keys[_keyCode];
  }
}

void setKey(int _keyCode, boolean value) {
  keys[_keyCode] = value;
}

void keyPressed() {
  setKey(keyCode, true);
}

void keyReleased() {
  setKey(keyCode, false);
}
