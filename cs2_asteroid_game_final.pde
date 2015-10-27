import java.util.HashSet;

// Detect collisions between Breakers and Asteroids.  Remove the
// Asteroids involved in collisioAstns, and replace them with smalller
// Asteroids.  Remove Breakers involved in collisions.
void handleCollisions() {
  // Asteroids which collided this timestep
  HashSet<Asteroid> collisions = new HashSet();

  // Breakers which collided this timestep.
  HashSet<Breaker> usedBreakers = new HashSet();

  // Keep track of which objects collided.  Don't delete them inside
  // the loop, because that messes up the Iterator.
  for (Breaker b : spaceship.breakers) {
    for (Asteroid a : asteroids) {
      if (colliding(a, b)) {
        collisions.add(a);
        usedBreakers.add(b);
      }
    }
  }

  // Split or remove the Asteroids which collided
  for (Asteroid a : collisions) {
    asteroids.remove(a);
    if (a.canSplit()) {
      children = a.children();
      asteroids.add(children.a);
      asteroids.add(children.b);
    }
  }


  // Remove the Breakers which collided
  for (Breaker b : usedBreakers) {
    spaceship.breakers.remove(b);
  }
}

// The number of (random) elements to create.
int initialAsteroids = 2;

ArrayList<Asteroid> asteroids = new ArrayList();
//ArrayList<Breaker> breakers = new ArrayList();
Spaceship spaceship;
// Store time (ms) of last update.
float t, last_t, dt;
Pair<Asteroid, Asteroid> children;
boolean won;

//draw the program, reset it to initial
void reDraw () {
  int i = 0;
  asteroids = new ArrayList();
  while (i < initialAsteroids) {
    asteroids.add(new Asteroid());
    i++;
    spaceship = new Spaceship();
    if (Won == true) {
      initialAsteroids = initialAsteroids+1;
      Won = false;
    }
  }
}
//sets up boolean for whether the game has just been won
boolean Won = false;
//if all the asteroids are gone. set boolean won to true then run reDraw
void ifWon () {
  if (asteroids.size() == 0) {
    Won = true;
    reDraw();
  }
}

void setup() {

  // Make random Asteroids
  reDraw();
  size(500, 500);
}



void draw() {
  clear();

  // Render all the Asteroids
  for (Asteroid a : asteroids) {
    a.render();
    a.outside();
  }

  ifWon();
  spaceship.spaceRender();
  spaceship.move();
  spaceship.arrows();
  spaceship.shoot();
  spaceship.move();
  spaceship.UpdateBreakArray();
  spaceship.slowDown();
  spaceship.ifoff();
  handleCrash();
  // Update the positions of the Asteroids
  t = millis();
  dt = last_t - t;
  last_t = t;
  for (Asteroid a : asteroids) {
    a.update(dt);
  }

  handleCollisions();
  //handleCrash();
}

//boolean, check if a given asteroid is coliding with a given breaker if it is return true
//if it's within a radius of the asteroid
boolean colliding (Asteroid Ast, Breaker Break) {
  float r = Ast.radius();
  PVector v1 = new PVector(Ast.center.x, Ast.center.y);
  PVector v2 = new PVector(Break.center.x, Break.center.y);
  float d = v1.dist(v2);
  if (d <= r) {
    return true;
  } else {
    return false;
  }
}

//boolean for it a given asteroid is colliding with the spaceship
//if the spaceship's center is within one asteroid radius of the asteroid's center
boolean crash (Asteroid Ast, Spaceship spaceship) {
  float r = Ast.radius();
  PVector v1 = new PVector(Ast.center.x, Ast.center.y);
  PVector v2 = new PVector(spaceship.center.x, spaceship.center.y);
  float d = v1.dist(v2);
  if (d <= r) {
    return true;
  } else {
    return false;
  }
}

//resets the variable crashed to false, sets the boolean crash to false so it won't loop
//goes through all the asteroids and if it's crashing with the spaceship it returns true
//resets in initial asteroids to the initial value, restarting the game level
//if crashing, then it redraws the game
void handleCrash() {
  boolean crashed = false;

  for (Asteroid a : asteroids) {
    if (crash(a, spaceship)) {
      crashed=true;
      initialAsteroids = 2;
    }
  }
  if (crashed==true) {
    reDraw();
  }
}


//reduce the amount of initial asteroids to a reasonable number, 5?
//get rid of breakers
//have a spaceship triangle, final float size, number of sides 3
//have the spaceship have a velocity and be able to move around, PVector Vecloity x,y, PVetor Position x and y
//method to adjust velocity of the spaceship
//have spaceship slow down slightly so it will eventually stop
//have space ship fire breakers
//check for collisons between asteroid and spaceship
//have a number of lives, if at 0 lives, restart, otherwise just put ship in middle of screen
//was unable to have the game win, if you win you will just be sitting there with an empty screen
//the breakers start from center of the spaceship so sometimes asteroids that should hit it will just hit breaker at center and will not crash