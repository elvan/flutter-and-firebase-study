mixin BMI {
  double calculateBMI(double weight, double height) {
    return weight / (height * height);
  }
}

class Person with BMI {
  final String name;
  final int age;
  final double height;
  final double weight;

  Person({this.name, this.age, this.height, this.weight});

  double get bmi => calculateBMI(weight, height);
}

void main() {
  final person = Person(name: 'Elvan', age: 37, height: 1.70, weight: 65);
  print(person.bmi);
}
