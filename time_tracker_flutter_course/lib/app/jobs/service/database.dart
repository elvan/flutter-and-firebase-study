import '../entity/job.dart';

abstract class Database {
  void createJob(Job job);

  void readJobs();
}
