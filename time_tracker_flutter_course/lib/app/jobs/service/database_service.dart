import '../entity/job.dart';

abstract class DatabaseService {
  Future<void> deleteJob(Job job) async {}

  Stream<List<Job>> jobsStream();

  Future<void> setJob(Job job);
}
