class Breaker {
  final PVector center;
  float angle;

  Breaker(PVector c, float a) {
    center = c;
    angle = a;
  }

  // Create a Breaker with a random position, uniformly distributed
  // over the area of the window.
  Breaker() {
    center = new PVector(center.x,center.y);
  }
  
  float radius() {
    return 5;
  }
  
  void render() {
    fill(255);
    stroke(0);
    ellipse(center.x, center.y, 5, 5);
    center.x = center.x + cos(angle)*(height/100);
    center.y = center.y + sin(angle)*(height/100);
  }
}