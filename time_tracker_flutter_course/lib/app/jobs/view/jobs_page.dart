import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/jobs/view/empty_content.dart';

import '../../../common/show_alert_dialog.dart';
import '../../auth/service/auth_base.dart';
import '../entity/job.dart';
import '../service/database_service.dart';
import 'edit_job_page.dart';
import 'job_list_tile.dart';

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
        FlatButton(
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

  Future<void> _signOut(context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);

    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
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

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<DatabaseService>(context, listen: false);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final jobs = snapshot.data;

          if (jobs.isNotEmpty) {
            final children = jobs
                .map((job) => JobListTile(
                      job: job,
                      onTap: () => EditJobPage.show(context, job: job),
                    ))
                .toList();
            return ListView(
              children: children,
            );
          }

          return EmptyContent();
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Some error occurred'),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
