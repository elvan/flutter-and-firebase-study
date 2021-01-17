import 'package:flutter/foundation.dart';

class Job {
  final String name;
  final int ratePerHour;

  Job({@required this.name, @required this.ratePerHour});

  // "Use the factory keyword when implementing a constructor that doesn’t
  // always create a new instance of its class."
  // https://dart.dev/guides/language/language-tour#factory-constructors
  factory Job.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }

    final String name = data['name'];
    final int ratePerHour = data['ratePerHour'];

    return Job(
      name: name,
      ratePerHour: ratePerHour,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }
}
