import '../entity/job.dart';

abstract class Database {
  Future<void> createJob(Job job);
}
