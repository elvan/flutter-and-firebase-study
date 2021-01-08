void main() {
  final values = [1, 2, 3, 4];
  print(sum(values));
}

int sum(List<int> values) {
  int result = 0;

  // for (int i = 0; i < values.length; i++) {
  //   result += values[i];
  // }

  for (int value in values) {
    result += value;
  }

  return result;
}
