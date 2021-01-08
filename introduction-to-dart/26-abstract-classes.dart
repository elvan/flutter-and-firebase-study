void main() {
  final square = Square(side: 10.0);
  print(square.area());
}

abstract class Shape {
  double area();
}

class Square implements Shape {
  Square({this.side});
  final double side;

  @override
  double area() => side * side;
}
