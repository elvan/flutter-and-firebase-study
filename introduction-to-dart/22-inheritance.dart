void main() {
  final person = Person(name: 'Elvan', age: 37, height: 1.70);
  print(person.describe());

  final employee = Employee(
      name: 'Elvan', age: 37, height: 1.70, taxCode: 'ABC123', salary: 5000);
  employee.sayName();
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

class Employee extends Person {
  Employee({String name, int age, double height, this.taxCode, this.salary})
      : super(name: name, age: age, height: height);

  final String taxCode;
  final int salary;
}
