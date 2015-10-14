class Breaker {
  final PVector center;
  float angle;

  Breaker(PVector c, float a) {
    center = c;
    angle = a;
  }
  

//make the breaker at center of where the spaceship is
//circle with radius 5, takes pvector center
  void render() {
    fill(255,0,0);
    stroke(0);
    PVector c = center;
    ellipse(c.x, c.y, 5, 5);
    c.x = c.x + cos(angle)*(height/100);
    c.y = c.y + sin(angle)*(height/100);
  }
  float radius() {
    return 5;
  }
  
}