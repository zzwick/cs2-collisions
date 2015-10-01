class Breaker {
  final PVector center;

  Breaker(PVector c) {
    center = c;
  }

  // Create a Breaker with a random position, uniformly distributed
  // over the area of the window.
  Breaker() {
    center = new PVector(random(width), random(height));
  }
  
  float radius() {
    return 5;
  }
  
  void render() {
    fill(255);
    stroke(0);
    ellipse(center.x, center.y, 5, 5);
  }
}