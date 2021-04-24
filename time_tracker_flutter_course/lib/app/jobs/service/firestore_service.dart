import 'package:flutter/foundation.dart';

import '../entity/job.dart';
import '../repository/firestore_repository.dart';
import 'api_path.dart';
import 'database_service.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreService implements DatabaseService {
  final String uid;
  final _repository = FirestoreRepository.instance;

  FirestoreService({@required this.uid}) : assert(uid != null);

  @override
  Future<void> deleteJob(Job job) async =>
      _repository.deleteData(path: APIPath.job(uid, job.id));

  @override
  Stream<List<Job>> jobsStream() {
    return _repository.collectionStream<Job>(
      path: APIPath.jobList(uid),
      builder: (data, documentId) => Job.fromMap(data, documentId),
    );
  }

  @override
  Future<void> setJob(Job job) async {
    await _repository.setData(
      path: APIPath.job(uid, job.id),
      data: job.toMap(),
    );
  }
}
