import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/show_alert_dialog.dart';
import '../../../common/show_exception_alert_dialog.dart';
import '../../auth/service/auth_base.dart';
import '../../job_entries/job_entries_page.dart';
import '../entity/job.dart';
import '../service/database_service.dart';
import 'edit_job_page.dart';
import 'job_list_tile.dart';
import 'list_items_builder.dart';

class JobsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => EditJobPage.show(context),
        child: Icon(Icons.add),
      ),
      body: _buildContents(context),
    );
  }

  PreferredSizeWidget _buildAppBar(context) {
    return AppBar(
      title: Text('Jobs'),
      actions: [
        TextButton(
          onPressed: () => _confirmSignOut(context),
          child: Text(
            'Logout',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
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
              onTap: () => JobEntriesPage.show(context, job),
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

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    );

    if (didRequestSignOut == true) {
      _signOut(context);
    }
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

  Future<void> _signOut(context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);

    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
