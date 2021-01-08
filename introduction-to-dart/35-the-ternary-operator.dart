void main() {
  printOddEven(5);
  printOddEven(6);
}

void printOddEven(int value) {
  final type = (value % 2 == 0) ? 'even' : 'odd';
  print('$value is $type');
}
