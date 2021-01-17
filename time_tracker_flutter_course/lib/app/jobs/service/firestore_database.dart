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
    _setData(
      path: APIPath.job(uid, '2ksbtPLB7aHh7mn0M5k1'),
      data: job.toMap(),
    );
  }

  @override
  Stream<List<Job>> getJobs() {
    final path = APIPath.jobList(uid);
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((querySnapshot) {
      return querySnapshot.docs.map((documentSnapshot) {
        return Job.fromMap(documentSnapshot.data());
      }).toList();
    });
  }

  Future<void> _setData({
    String path,
    Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }
}
