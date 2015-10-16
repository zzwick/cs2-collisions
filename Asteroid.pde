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
    center.x = (center.x + width) % width;
    center.y = (center.y + width) % height;
  }

  // Draw a polygon with the current style.  `polygon(x, y, r, n)`
  // draws a n-sided polygon with its circumcenter at (x,y), with a
  // distance r from the center to each vertex.
  private void polygon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    fill(255);
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
  int childShape () {
    int s = size-1;
    return s;
  }
  boolean canSplit () {
    if (size > 4) {
      return true;
    } else {
      return false;
    }
  }
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
  float radius () {
    float r = 10*(pow(1.27,(size-4)));
    return r;
  }

  //used https://processing.org/reference/PVector_dist_.html to help
  float distance (PVector acent, PVector bcent) {
    float d = acent.dist(bcent);
    return d;
  }

  void render () {
    float r = radius();
    float x = center.x;
    float y = center.y;
    polygon(x, y, r, size);
  }
  
  Pair childVelocities () {
      PVector v1 = new PVector (v.x * 1.1,v.y * 1.1);
      PVector v2 = new PVector (v.x * 1.1, v.y * 1.1);
      v1.rotate(30);
      v2.rotate(-30);
      Pair A = new Pair(v1, v2);
      return A;
  }
  
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
