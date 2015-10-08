class Spaceship {
  PVector center;  // position of center, in screen coordinates
  float angle;
  PVector velocity;

  Spaceship(PVector c, PVector v_, float a) {
    center = c;
    velocity = v_;
    angle = a;
  }

  Spaceship () {
    center = new PVector ((width/2), (height/2));
    velocity = new PVector(0, 0);
    angle = -60;
  }

  ArrayList<Breaker> breakers = new ArrayList();

  void spaceRender () {
    fill(255,0,0);
    beginShape ();
    vertex((center.x+(20*(cos(angle+60)))), (center.y-(20*(sin(angle+60)))));
    vertex((center.x-(20*(cos(angle+60)))), (center.y+(20*(sin(angle+60)))));
    vertex((center.x+(20*(cos(angle)))), (center.y-(20*(sin(angle)))));
    endShape(CLOSE);
  }

  void move () {
    center.x = center.x + cos(angle)*velocity;
    center.y = center.y + cos(angle)*velocity;
  }

  void arrows () {
    if (keyPressed) {
      if (keyCode == UP) {
        velocity = velocity + 2;
      } else if (keyCode == RIGHT) {
        angle = angle + 5;
      } else if (keyCode == LEFT) {
        angle = angle - 5;
      }
    }
    if (angle == 360) {
      angle = 0;
    }
    println(velocity);
    println(angle);
  }

  void shoot () {
    if (keyPressed) {
      if (keyCode == DOWN) {
        Breaker bullet = new Breaker(center, angle);
        breakers.add(bullet);
      }
    }
  }

  void draw () {
    for (Breaker b : breakers) {
      b.render();
    }
  }
}