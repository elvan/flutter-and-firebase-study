void main() {
  var primeNumbers = List<int>(); // equivalent to []
  primeNumbers.addAll([2, 3, 5, 7]);
  primeNumbers.add(11);

  var person = <String, dynamic>{'name': 'Elvan', 'age': 37, 'height': 1.70};

  person['weight'] = 65;
  print(person['weight']);

  print(primeNumbers);
  print(getFourPrimeNumbers());
}

List<int> getFourPrimeNumbers() => [2, 3, 5, 7];
