import '../../jobs/entity/job.dart';
import '../entity/entry.dart';

class EntryJob {
  EntryJob(this.entry, this.job);

  final Entry entry;
  final Job job;
}
