class Rock {
  int x, y, speed, diam;
  PImage rock;

  // Constructor
  Rock() {
    x = int(random(width));
    y = -50;
    speed = int(random(2,6));
    diam = int(random(30, 90));
    //rock = loadImage("rock.png");
    // for multiple images
    int rand = int(random(5));
    if (rand == 0) {
      rock = loadImage("rock0.png");
    } else if (rand == 1) {
      rock = loadImage("rock1.png");
    } else if (rand == 2) {
      rock = loadImage("rock2.png");
    } else if (rand == 3) {
      rock = loadImage("rock3.png");
    } else if (rand == 4) {
      rock = loadImage("rock4.png");  
    }
  }

  void display() {
    imageMode(CENTER);
    rock.resize(diam, diam);
    image(rock, x, y);
  }

  void move() {
    y += speed;
  }

  boolean reachedBottom() {
    if (y>height+100) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean intersect(Laser laser) {
    float d = dist(x, y, laser.x, laser.y);
    if (d<30) {
      return true;
    } else {
      return false;
    }
  }
}
