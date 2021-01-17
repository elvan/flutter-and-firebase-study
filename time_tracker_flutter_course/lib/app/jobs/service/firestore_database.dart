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
  Stream<List<Job>> jobsStream() {
    return _collectionStream<Job>(
      path: APIPath.jobList(uid),
      builder: (data) => Job.fromMap(data),
    );
  }

  Future<void> _setData({
    String path,
    Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }

  Stream<List<T>> _collectionStream<T>({
    @required String path,
    @required T Function(Map<String, dynamic> data) builder,
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((querySnapshot) {
      return querySnapshot.docs.map((documentSnapshot) {
        return builder(documentSnapshot.data());
      }).toList();
    });
  }
}
