class Spaceship {
  PVector center;  // position of center, in screen coordinates
  final PVector v;  // velocity, per second, in screen coordinates
  float angle;
  float velocity;

  Spaceship(PVector c, PVector v_, float a) {
    center = c;
    v = v_;
    angle = a;
  }

  Spaceship () {
    center = new PVector ((width/2), (height/2));
    v = new PVector(0, 0);
  }

  void spaceRender () {
    beginShape ();
    vertex((center.x+(2*(cos(angle+60)))), (center.y-(2*(sin(angle+60)))));
    vertex((center.x-(2*(cos(angle+60)))), (center.y+(2*(sin(angle+60)))));
    vertex((center.x+(2*(cos(angle)))), (center.y-(2*(sin(angle)))));
  }

  void move () {
    center.x = center.x + cos(angle)*velocity;
    center.y = center.y + cos(angle)*velocity;
  }

  void arrows () {
    if (keyPressed) {
      if (key == UP) {
        velocity = velocity + width/100;
      } else if (key == RIGHT) {
        angle = angle + 5;
      } else if (key == LEFT) {
        angle = angle - 5;
      }
    }
  }
  
  void shoot () {
    if (keypressed) {
     if (key == DOWN) {
       Breaker bullet = new Breaker(bcent,angle);
       breakers.add(bullet);
     }
    }
}