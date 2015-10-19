class Spaceship {
  PVector center;  // position of center, in screen coordinates
  float angle; //angle of spaceship
  PVector velocity; //velocity of the spaceship, float v.x float v.y

  Spaceship(PVector c, PVector v_, float a) {
    center = c;
    velocity = v_;
    angle = a;
  }

  Spaceship () {
    center = new PVector ((width/2), (height/2)); //diffault center to start in the middle of the screen
    velocity = new PVector(0, 0); //velocity starts at 0
    angle = 0; //angle starts at 0, spaceship is facing right
  }

  ArrayList<Breaker> breakers = new ArrayList();  //makes a breakers array list

//make the spaceship, triangle, takes the float angle of the spaceship and the pvector center
//no imput, uses the pvector center and float angle
  void spaceRender () {
    fill(0, 150, 100);
    stroke(255);
    beginShape ();
    vertex(center.x+(8*cos(angle-(2*PI/3))), center.y+(8*sin(angle-(2*PI/3))));
    vertex(center.x+(8*cos(angle+(2*PI/3))), center.y+(8*sin(angle+(2*PI/3))));
    vertex(center.x+(16*cos(angle)), center.y+(16*sin(angle)));
    endShape(CLOSE);
  }

// makes the center the center plus the velocity so the spaceship will move
  void move () {
    center = center.add(velocity);
  }

//takes imput of if the arrow keys are pressed
//changes velocity and angle each time the program runs if the arrow keys are pressed
  void arrows () {
    if (keyPressed) {
      if (keyCode == UP) {
        velocity.set((velocity.x + cos(angle)*.3), (velocity.y + sin(angle)*.3));
      } else if (keyCode == RIGHT) {
        angle = angle + .2;
      } else if (keyCode == LEFT) {
        angle = angle - .2;
      }
    }
  }

//if the down arrow is pressed it adds a new breaker to the breaker array
//starting at the center of the spaceship and with the same angle as the spaceship
//so the breaker shoots out the tip of the spaceship
//creates a new breaker with those values of center and angle
  void shoot () {
    if (keyPressed) {
      if (keyCode == DOWN) {
        Breaker bullet = new Breaker(center.copy(), angle);
        breakers.add(bullet);
      }
    }
  }

//renders the breakers that are in the array
  void UpdateBreakArray () {
    for (Breaker b : breakers) {
      b.render();
    }
  }

//slows down the velocity of the spaceship each time the program runs so that it
//will eventually come to a stop and makes the game managable
  void slowDown () {
    velocity.set(velocity.x*.9, velocity.y*.9);
  }

//if the spaceship is off the screen it moves it to the opposite side
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