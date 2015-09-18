In this project, you will write a simulation of asteroids.  This is a
variation on the classic asteroids game, but for now, there's no
player input.  There are two types of object on the screen -
*Asteroids*, and *Breakers*.  When an *Asteroid* hits a *Breaker*, it
splits into 2 Asteroids, or if it's too small to split further, it
disappears.  More specifically, each Asteroid is drawn as a polygon,
and each time it breaks, the number of sides is reduced by one.

I've written part of the two classes *Asteroid* and *Breaker* - the
variable declarations, and the constructors.  I've also provided the
setup() and draw() functions.

You will write several functions & class methods to complete the
program.  These functions detect collisions and make the new Asteroids
after collisions.  You will also write functions to draw the Asteroids
and Breakers.

1. *childShape* is a method of the Asteroid class which returns the
   number of sides of the Asteroids that are created when this
   Asteroid is split.

2. *canSplit* is a method of the Asteroid class which returns `true`
   if the Asteroid has more than 4 sides, and `false` otherwise.  This
   ensures that square Asteroids which hit a Breaker are removed,
   without children.


3. *radius* is a method of the Asteroid class which returns the radius
   of the Asteroid.  The radius is related to the number of sides by
   the following table.  You can use these exact values, or an
   equation which approximates them.

    | number of sides | radius |
    | --------------- | ------ |
    | 4| 10 |
    | 5|12.7|
    | 6|16|
    | 7|20.2|
    | 8| 25.4|

4. *distance* is a function (not part of any class) which returns the
distance between two `PVector`s.

5. *colliding* takes an Asteroid and a Breaker, returns `true` if they
   are close enough to touch, and `false` otherwise.  More precisely,
   it returns `true` if the circle circumscribing the Asteroid (a
   circle through all the vertices of the Asteroid) touches the
   Breaker.  *colliding* is not a method of any class.

6. *render* is a method of the Asteroid class that draws the Asteroid.

7. *childVelocities* is a method of the Asteroid class that returns
   the velocities of the 2 new Asteroids created when one hits a
   Breaker.  Each velocity should have magnitude 1.1 times that of the
   parent Asteroid.  One should point 30° clockwise of the parent
   velocity, and one should point 30° counterclockwise.  You may find
   the Pair class helpful.

8. *children* is a method of the Asteroid class that returns the two
   Asteroids created when one hits a Breaker.  The velocities & number
   of sides of the children are defined by *childShape* and
   *childVelocities*, above.  The position of the children is the same
   as that of the parent.  Use the *Pair* class to return two Asteroids.
