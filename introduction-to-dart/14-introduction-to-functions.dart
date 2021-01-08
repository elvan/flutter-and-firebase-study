void main() {
  var name = 'Elvan';
  var age = 37;
  var height = 1.70;

  describe(name, age, height);
  describe('Andrea', 36, 1.84);
}

void describe(String name, int age, double height) {
  print("Hello, I'm $name");
  print("I'm $age years old");
  print("I'm $height meters tall");
}
