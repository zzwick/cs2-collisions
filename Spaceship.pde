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
    angle = 0;
  }

  ArrayList<Breaker> breakers = new ArrayList();

  void spaceRender () {
    fill(255, 0, 0);
    beginShape ();
    vertex(center.x+(10*cos(angle+(PI/3))), center.y-(10*sin(angle+(PI/3))));
    vertex(center.x-(10*cos(angle+(PI/3))), center.y+(10*sin(angle+(PI/3))));
    vertex(center.x+(10*cos(angle)), center.y-(10*sin(angle)));
    endShape(CLOSE);
  }

  void move () {
    /*   center.x = center.x + cos(angle)*velocity;
     center.y = center.y + cos(angle)*velocity;
     */
    center = center.add(velocity);
  }

  void arrows () {
    if (keyPressed) {
      if (keyCode == UP) {
        velocity.set((velocity.x + cos(angle)*.5), (velocity.y + cos(angle)*.5));
        println(velocity);
      } else if (keyCode == RIGHT) {
        angle = angle + .2;
      } else if (keyCode == LEFT) {
        angle = angle - .2;
      }
    }
    if (angle == 2*PI) {
      angle = 0;
    } else if (angle == -2*PI) {
      angle = 0;
    }
    println(velocity);
    println(angle);
  }

  void shoot () {
    if (keyPressed) {
      if (keyCode == DOWN) {
        Breaker bullet = new Breaker(center.copy(), angle);
        breakers.add(bullet);
      }
    }
  }

  void UpdateBreakArray () {
    for (Breaker b : breakers) {
      b.render();
    }
  }
  void slowDown () {
    velocity.set(velocity.x*.9, velocity.y*.9);
  }
  void ifoff () {
    if (center.x <0) {
      center.x = width;
    }
    if (center.x > width) {
      center.x = 0;
    }
    if (center.y >height) {
      center.y = 0;
    }
    if (center.y < 0) {
      center.y = height;
    }
  }
}