void main() {
  var name = 'Elvan';
  var age = 37;
  var height = 1.70;

  print(describe(name, age, height));
  print(describe('Andrea', 36, 1.84));
}

String describe(String name, int age, double height) {
  return "Hello, I'm $name. I'm $age years old, I'm $height meters tall.";
}
