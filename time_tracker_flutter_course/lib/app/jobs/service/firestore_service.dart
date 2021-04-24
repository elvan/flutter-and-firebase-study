import 'package:flutter/foundation.dart';

import '../../job_entries/entry.dart';
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
  Stream<Job> jobStream({@required String jobId}) => _repository.documentStream(
        path: APIPath.job(uid, jobId),
        builder: (data, documentId) => Job.fromMap(data, documentId),
      );

  @override
  Stream<List<Job>> jobsStream() {
    return _repository.collectionStream<Job>(
      path: APIPath.jobs(uid),
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

  @override
  Future<void> setEntry(Entry entry) => _repository.setData(
        path: APIPath.entry(uid, entry.id),
        data: entry.toMap(),
      );

  @override
  Future<void> deleteEntry(Entry entry) => _repository.deleteData(
        path: APIPath.entry(uid, entry.id),
      );

  @override
  Stream<List<Entry>> entriesStream({Job job}) =>
      _repository.collectionStream<Entry>(
        path: APIPath.entries(uid),
        queryBuilder: job != null
            ? (query) => query.where('jobId', isEqualTo: job.id)
            : null,
        builder: (data, documentID) => Entry.fromMap(data, documentID),
        sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );
}
