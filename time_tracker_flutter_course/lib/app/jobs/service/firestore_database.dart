import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../entity/job.dart';
import 'api_path.dart';
import 'database.dart';

class FirestoreDatabase implements Database {
  final String uid;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  @override
  void createJob(Job job) {
    _setData(
      documentPath: APIPath.job(uid, '2ksbtPLB7aHh7mn0M5k1'),
      data: job.toMap(),
    );
  }

  Future<void> _setData({
    String documentPath,
    Map<String, dynamic> data,
  }) async {
    final documentReference = FirebaseFirestore.instance.doc(documentPath);
    await documentReference.set(data);
  }
}
