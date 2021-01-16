import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../entity/job.dart';
import 'api_path.dart';
import 'database.dart';

class FirestoreDatabase implements Database {
  final String uid;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  @override
  Future<void> createJob(Job job) async {
    final documentPath = APIPath.job(uid, '2ksbtPLB7aHh7mn0M5k1');
    final documentReference = FirebaseFirestore.instance.doc(documentPath);
    await documentReference.set(job.toMap());
  }
}
