import '../../job_entries/entry.dart';
import '../entity/job.dart';

abstract class DatabaseService {
  Future<void> deleteJob(Job job) async {}

  Stream<Job> jobStream({String jobId});

  Stream<List<Job>> jobsStream();

  Future<void> setJob(Job job);

  Future<void> setEntry(Entry entry);

  Future<void> deleteEntry(Entry entry);

  Stream<List<Entry>> entriesStream({Job job});
}
