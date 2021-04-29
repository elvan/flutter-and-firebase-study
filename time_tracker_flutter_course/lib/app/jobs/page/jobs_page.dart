import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/show_exception_alert_dialog.dart';
import '../../entries/page/entry_page.dart';
import '../entity/job.dart';
import '../service/database_service.dart';
import '../widget/job_list_tile.dart';
import '../widget/list_items_builder.dart';
import 'edit_job_page.dart';

class JobsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildContents(context),
    );
  }

  PreferredSizeWidget _buildAppBar(context) {
    return AppBar(
      title: Text('Jobs'),
      actions: [
        IconButton(
          color: Colors.white,
          icon: Icon(Icons.add),
          onPressed: () => EditJobPage.show(
            context,
            database: Provider.of<DatabaseService>(context, listen: false),
          ),
        ),
      ],
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<DatabaseService>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Job>(
          itemBuilder: (context, job) => Dismissible(
            background: Container(
              color: Colors.red,
            ),
            child: JobListTile(
              job: job,
              onTap: () => EntryPage.show(
                context: context,
                database: database,
                job: job,
              ),
            ),
            direction: DismissDirection.endToStart,
            key: Key('job-${job.id}'),
            onDismissed: (direction) => _delete(context, job),
          ),
          snapshot: snapshot,
        );
      },
    );
  }

  Future<void> _delete(BuildContext context, Job job) async {
    try {
      final database = Provider.of<DatabaseService>(context, listen: false);
      await database.deleteJob(job);
    } on FirebaseException catch (exception) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: exception,
      );
    }
  }
}
