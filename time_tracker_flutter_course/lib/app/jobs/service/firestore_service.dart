import 'package:flutter/foundation.dart';

import '../entity/job.dart';
import '../repository/firestore_repository.dart';
import 'api_path.dart';
import 'database_service.dart';

class FirestoreService implements DatabaseService {
  final String uid;
  final _repository = FirestoreRepository.instance;

  FirestoreService({@required this.uid}) : assert(uid != null);

  @override
  Future<void> createJob(Job job) async {
    _repository.setData(
      path: APIPath.job(uid, '2ksbtPLB7aHh7mn0M5k1'),
      data: job.toMap(),
    );
  }

  @override
  Stream<List<Job>> jobsStream() {
    return _repository.collectionStream<Job>(
      path: APIPath.jobList(uid),
      builder: (data) => Job.fromMap(data),
    );
  }
}
