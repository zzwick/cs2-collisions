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
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
  int childShape () {
    size = size-1;
    return size;
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
    float r = 10*(1.27^(n-4));
    return r;
  }

  //used https://processing.org/reference/PVector_dist_.html to help
  float distance (PVector acent, PVector bcent) {
    float d = acent.dist(bcent);
    return d;
  }
}

void render () {
  
}