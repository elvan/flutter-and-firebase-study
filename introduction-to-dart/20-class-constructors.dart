void main() {
  final person = Person(name: 'Elvan', age: 37, height: 1.70);
  print(person.name);
}

class Person {
  Person({this.name, this.age, this.height});

  final String name;
  final int age;
  final double height;
}

String describe({String name, int age, double height = 0.0}) {
  return "Hello, I'm $name. I'm $age years old, I'm $height meters tall.";
}

String describe2({String name, int age, double height = 0.0}) =>
    "Hello, I'm $name. I'm $age years old, I'm $height meters tall.";

void sayName(String name) => print("Hello, I'm $name");
