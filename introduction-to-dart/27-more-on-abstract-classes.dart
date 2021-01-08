import 'dart:math';

void main() {
  final square = Square(side: 10.0);
  print(square.area());

  final circle = Circle(radius: 5.0);
  print(circle.area());
}

abstract class Shape {
  double area();
}

class Square implements Shape {
  final double side;

  Square({this.side});

  @override
  double area() => side * side;
}

class Circle implements Shape {
  final double radius;

  Circle({this.radius});

  @override
  double area() => radius * radius * pi;
}
