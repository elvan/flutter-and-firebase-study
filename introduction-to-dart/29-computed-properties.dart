import 'dart:math';

void main() {
  final square = Square(side: 10.0);
  printArea(square);

  final circle = Circle(radius: 5.0);
  printArea(circle);
}

void printArea(Shape shape) {
  print(shape.area);
}

abstract class Shape {
  double get area;
}

class Square implements Shape {
  final double side;

  Square({this.side});

  @override
  double get area => side * side;
}

class Circle implements Shape {
  final double radius;

  Circle({this.radius});

  @override
  double get area => radius * radius * pi;
}
