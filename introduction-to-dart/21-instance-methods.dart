void main() {
  final person = Person(name: 'Elvan', age: 37, height: 1.70);
  print(person.describe());
}

class Person {
  Person({this.name, this.age, this.height});

  final String name;
  final int age;
  final double height;

  String describe() =>
      "Hello, I'm $name. I'm $age years old, I'm $height meters tall.";

  void sayName() => print("Hello, I'm $name");
}
