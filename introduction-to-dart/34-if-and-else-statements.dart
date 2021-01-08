void main() {
  printOddEven(4);
  printOddEven(5);
}

void printOddEven(int value) {
  if (value % 2 == 0) {
    print('$value is even');
  } else {
    print('$value is odd');
  }
}
