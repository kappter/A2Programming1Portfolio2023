class Star {
  int x, y, speed, diam;
  color c1;

  // Constructor
  Star() {
    x = int(random(width));
    y = int(random(height));
    speed = int(random(2, 7));
    diam = int(random(1, 4));
    c1 = color(random(200,255),random(200,255),random(10,20));
  }

  void display() {
    fill(c1,128);
    ellipse(x, y, diam, diam);
  }

  void move() {
    if (y>height+5) {
      y = -5;
    } else {
      y += speed;
    }
  }
}
