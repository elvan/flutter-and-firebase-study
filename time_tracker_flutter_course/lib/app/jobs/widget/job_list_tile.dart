import 'package:flutter/material.dart';

import '../entity/job.dart';

class JobListTile extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;

  const JobListTile({Key key, this.job, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(job.name),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
