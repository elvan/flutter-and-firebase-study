import '../entity/job.dart';

abstract class DatabaseService {
  Future<void> setJob(Job job);

  Stream<List<Job>> jobsStream();
}
