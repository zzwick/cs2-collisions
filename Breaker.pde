class Breaker {
  final PVector center;
  float angle;  //added float angle to the breakers so they go from the direction of the spaceship

  Breaker(PVector c, float a) {
    center = c;
    angle = a;  //breaker now takes float angle
  }
  

//make the breaker at it's center, where it should be
//update the breaker's position to be where it would be with velocity of it continued at the correct angle
  void render() {
    fill(100,100,255);
    stroke(0);
    PVector c = center;
    ellipse(c.x, c.y, 5, 5);
    c.x = c.x + cos(angle)*(height/50);
    c.y = c.y + sin(angle)*(height/50);
  }
  //returns a radius of 5 for the breakers
  float radius() {
    return 5;
  }
  
}