class Asteroid {
  final int size;  // number of sides
  PVector center;  // position of center, in screen coordinates
  final PVector v;  // velocity, per second, in screen coordinates

  Asteroid(int s, PVector c, PVector v_) {
    size = s;
    center = c;
    v = v_;
  }

  // Create a new Asteroid with a random position & velocity.  The
  // position is uniformly distributed over the window area.  The
  // velocity is in a random direction, always with magnitude 100
  // pixels/second.
  Asteroid() {
    size = 8;
    center = new PVector(random(width), random(height));
    v = new PVector(100, 0);
    v.rotate(random(TWO_PI));
  }

  // Update the position of the Asteroid according to its velocity.
  // The argument dt is the elapsed time in milliseconds since the
  // last update.  Modifies the Asteroid.
  public void update(float dt) {
    PVector dv = v.copy();
    dv.mult(dt/1000);
    center.add(dv);
    center.x = center.x % width;
    center.y = center.y % height;
  }

  // Draw a polygon with the current style.  `polygon(x, y, r, n)`
  // draws a n-sided polygon with its circumcenter at (x,y), with a
  // distance r from the center to each vertex.
  private void polygon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    fill(200,50,50);
    stroke(0);
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
  //makes the size side smaller, called after it collides with a breaker
  int childShape () {
    int s = size-1;
    return s;
  }
  //tells whether the asteroid is large enough size to split
  //if the asteroid has 4 or less sides then it returns false
  boolean canSplit () {
    if (size > 4) {
      return true;
    } else {
      return false;
    }
  }
  //this is just extra code, before I made an equation to estimate the size of the asteroid
  /*  float radius () {
   switch (size) {
   case 4:
   return 10;
   case 5:
   return 12.7;
   case 6:
   return 16;
   case 7:
   return 20.2;
   case 8:
   return 25.4;
   }
   }
   */
  //returns a float for the radius of the asteroid
  float radius () {
    float r = 10*(pow(1.27,(size-4)));
    return r;
  }

  //used https://processing.org/reference/PVector_dist_.html to help
  //returns a float, the distance between the center of the breaker and the center of the asteroid
  float distance (PVector acent, PVector bcent) {
    float d = acent.dist(bcent);
    return d;
  }

//renders the asteroids, calls the polygon fuction using the center for that asteroid
///and calls the radius function for the size of the radius
  void render () {
    float r = radius();
    float x = center.x;
    float y = center.y;
    polygon(x, y, r, size);
  }
  //makes two pvectors, one for each of the new asteroids created after the collision
  //increases the velocities of the resulting asteroids made after collision be 1.1 x the initial velocity
  //rotates one of the asteroid's velocities forward 30 degrees and the other backwards 30 degrees
  //makes those into a new pair, then returns that pair
  Pair childVelocities () {
      PVector v1 = new PVector (v.x * 1.1,v.y * 1.1);
      PVector v2 = new PVector (v.x * 1.1, v.y * 1.1);
      v1.rotate(30);
      v2.rotate(-30);
      Pair A = new Pair(v1, v2);
      return A;
  }
  //calls the childshape function to get the size of the resulting asteroids makes that an int s
  //calls child velocities and takes that resulting pair into pair 1
  //makes each of the pvector components of the pair into pvectors
  //makes the 2 new resulting asteroids from the pvectors for velocity imput, and at the center where the asteroids were when they broke
  //makes those two asteroids into a new pair
  //returns that pair of 2 asteroids
  Pair children () {
    int s = this.childShape();
    Pair<PVector, PVector> Pair1 = this.childVelocities();
    PVector v1 = Pair1.a;
    PVector v2 = Pair1.b;
    Asteroid A = new Asteroid(s, center, v1);
    Asteroid B = new Asteroid(s, center.copy(), v2);
    Pair<Asteroid, Asteroid> BreakPair = new Pair(A,B);
    return BreakPair;
  }
  //if the asteroids are outside the screen then it changes to the other side of the screen
  void outside () {
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