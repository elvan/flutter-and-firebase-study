import 'package:flutter/foundation.dart';

import '../entity/job.dart';
import 'api_path.dart';
import 'database.dart';
import 'firestore_service.dart';

class FirestoreDatabase implements Database {
  final String uid;
  final _service = FirestoreService.instance;

  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  @override
  Future<void> createJob(Job job) async {
    _service.setData(
      path: APIPath.job(uid, '2ksbtPLB7aHh7mn0M5k1'),
      data: job.toMap(),
    );
  }

  @override
  Stream<List<Job>> jobsStream() {
    return _service.collectionStream<Job>(
      path: APIPath.jobList(uid),
      builder: (data) => Job.fromMap(data),
    );
  }
}
