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
      path: APIPath.job(uid, '2ksbtPLB7aHh7mn0M5k1'),
      data: job.toMap(),
    );
  }

  Stream<List<Job>> readJobs() {
    final path = APIPath.jobList(uid);
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((querySnapshot) {
      return querySnapshot.docs.map((documentSnapshot) {
        final data = documentSnapshot.data();
        return data != null
            ? Job(
                name: data['name'],
                ratePerHour: data['ratePerHour'],
              )
            : null;
      });
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
