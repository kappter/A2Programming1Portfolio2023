// Mr Kapptie | Nov 28 2022 | Spacegame
import processing.sound.*;
SoundFile blaster, explode;
SpaceShip s1;
Timer rockTimer,puTimer;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<PowerUp> powerups = new ArrayList<PowerUp>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
Star[] stars = new Star[200];
int score, level, rockRate, rockCount, rocksPassed, laserCount;
boolean play;

void setup() {
  size(800, 800);
  s1 = new SpaceShip();
  rockRate = 500;
  puTimer = new Timer(5000);
  puTimer.start();
  rockTimer = new Timer(rockRate);
  rockTimer.start();
  blaster = new SoundFile(this, "blaster.wav");
  for (int i=0; i<stars.length; i++) {
    stars[i] = new Star();
  }
  score = 0;
  level = 1;
  rockCount = 0;
  laserCount = 0;
  rocksPassed=0;
  play = false;
}

void draw() {
  if (!play) {
    startScreen();
  } else {
    
     // Level Handling 
    if (frameCount % 1000 == 10) {
      level++;
      rockRate-=10;
    }
    
    background(25);

    // Rendering Stars
    for (int i=0; i<stars.length; i++) {
      stars[i].display();
      stars[i].move();
    }
    noCursor();
    
    // Add PowerUps
    if (puTimer.isFinished()) {
      powerups.add(new PowerUp());
      puTimer.start();
      println("PowerUps:" + powerups.size());
    }
    
    // Rendering PowerUps and Detecting Ship Collision
    for (int i = 0; i < powerups.size(); i++) {
      PowerUp pu = powerups.get(i);
      if (pu.intersect(s1)) {
        if(pu.type == 'H') {
          s1.health+=100;
        } else {
          s1.ammo+=100;
        }
        // add a sound for explosion
        powerups.remove(pu);
      }
      if (pu.reachedBottom()) {
        powerups.remove(pu);
      } else {
        pu.display();
        pu.move();
      }
    }

    // Add Rocks
    if (rockTimer.isFinished()) {
      rocks.add(new Rock());
      rockCount++;
      rockTimer.start();
      println("Rocks:" + rocks.size());
    }

    // Rendering Rocks and Detecting Ship Collision
    for (int i = 0; i < rocks.size(); i++) {
      Rock r = rocks.get(i);
      if (s1.intersect(r)) {
        s1.health-=r.diam;
        // todo call the explostion animation
        // add a sound for explosion
        // todo: consider adding rock health
        score-=r.diam;
        rocks.remove(r);
      }
      if (r.reachedBottom()) {
        rocksPassed++;
        rocks.remove(r);
      } else {
        r.display();
        r.move();
      }
    }

    // Render lasers on the screen and detect rock collision
    for (int i = 0; i < lasers.size(); i++) {
      Laser l = lasers.get(i);
      for (int j = 0; j < rocks.size(); j++) {
        Rock r = rocks.get(j);
        if (r.intersect(l)) {
          score+=r.diam;
          // Todo: add sound
          // Todo: add animation to the collision
          // Todo: dectrament the rock health
          lasers.remove(l);
          r.diam-=50;
          if (r.diam<10) {

            rocks.remove(r);
          }
        }
        if (l.reachedTop()) {
          lasers.remove(l);
        } else {
          l.display();
          l.move();
        }
      }
    }
    s1.display(mouseX, mouseY);
    infoPanel();

    // Game over logic
    if (s1.health<1 || rocksPassed > 10) {
      gameOver();
    }
  }
}

// Add Laser based on event
void mousePressed() {
  if (play) {
    blaster.stop();
    blaster.play();
    handleEvent();
  }
}

void keyPressed() {
  if (play) {
    blaster.stop();
    blaster.play();
    if (key == ' ') {
      handleEvent();
    }
  }
}

void handleEvent() {
  if (s1.fire() && s1.turretCount == 1) {
    lasers.add(new Laser(s1.x, s1.y));
    println("Lasers:" + lasers.size());
  } else if (s1.fire() && s1.turretCount == 2) {
    lasers.add(new Laser(s1.x-20, s1.y));
    lasers.add(new Laser(s1.x+20, s1.y));
    println("Lasers:" + lasers.size());
  } else if (s1.fire() && s1.turretCount == 3) {
    lasers.add(new Laser(s1.x-20, s1.y));
    lasers.add(new Laser(s1.x+20, s1.y));
    lasers.add(new Laser(s1.x, s1.y));
    println("Lasers:" + lasers.size());
  } else if (s1.fire() && s1.turretCount == 4) {
    lasers.add(new Laser(s1.x-20, s1.y));
    lasers.add(new Laser(s1.x+20, s1.y));
    lasers.add(new Laser(s1.x+40, s1.y));
    lasers.add(new Laser(s1.x-40, s1.y));
    println("Lasers:" + lasers.size());
  } else if (s1.fire() && s1.turretCount == 5) {
    lasers.add(new Laser(s1.x-20, s1.y));
    lasers.add(new Laser(s1.x+20, s1.y));
    lasers.add(new Laser(s1.x+40, s1.y));
    lasers.add(new Laser(s1.x-40, s1.y));
    lasers.add(new Laser(s1.x, s1.y));
    println("Lasers:" + lasers.size());
  }
}

void infoPanel() {
  fill(129, 128);
  rectMode(CENTER);
  rect(width/2, 25, width, 50);
  fill(255, 200, 0);
  textSize(18);
  textAlign(CENTER);
  text("SPACEGAME" + " | Rocks Passed:" + rocksPassed +
    " | Health:" + s1.health +
    " | Level:" + level +
    " | Score:" + score +
    " | Ammo:" + s1.ammo, width/2, 35);
}

void startScreen() {
  background(0);
  fill(222);
  textAlign(CENTER);
  text("Press any key to begin...", width/2, height/2);
  if (mousePressed || keyPressed) {
    play = true;
  }
}

void gameOver() {
  background(0);
  fill(222);
  textAlign(CENTER);
  text("Game Over!", width/2, height/2);
  text("Score:" + score, width/2, height/2+20);
  play = false;
  noLoop();
}
