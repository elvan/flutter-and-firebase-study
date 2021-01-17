import '../entity/job.dart';

abstract class DatabaseService {
  Future<void> createJob(Job job);

  Stream<List<Job>> jobsStream();
}
