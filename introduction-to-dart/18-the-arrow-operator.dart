void main() {
  var name = 'Elvan';
  var age = 37;
  var height = 1.70;

  print(describe(name: name, age: age, height: height));
  print(describe(name: 'Andrea', age: 36, height: 1.84));

  sayName('Elvan');
}

String describe({String name, int age, double height = 0.0}) {
  return "Hello, I'm $name. I'm $age years old, I'm $height meters tall.";
}

String describe2({String name, int age, double height = 0.0}) =>
    "Hello, I'm $name. I'm $age years old, I'm $height meters tall.";

void sayName(String name) => print("Hello, I'm $name");
