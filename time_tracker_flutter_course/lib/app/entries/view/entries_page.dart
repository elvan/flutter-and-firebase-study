import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../common/show_exception_alert_dialog.dart';
import '../../jobs/entity/job.dart';
import '../../jobs/page/edit_job_page.dart';
import '../../jobs/service/database_service.dart';
import '../../jobs/widget/list_items_builder.dart';
import '../entity/entry.dart';
import '../widget/entry_list_item.dart';
import 'entry_page.dart';

class EntriesPage extends StatelessWidget {
  const EntriesPage({@required this.database, @required this.job});
  final DatabaseService database;
  final Job job;

  static Future<void> show(BuildContext context, Job job) async {
    final database = Provider.of<DatabaseService>(context, listen: false);
    await Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: false,
        builder: (context) => EntriesPage(database: database, job: job),
      ),
    );
  }

  Future<void> _deleteEntry(BuildContext context, Entry entry) async {
    try {
      await database.deleteEntry(entry);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Operation failed',
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Job>(
      stream: database.jobStream(jobId: job.id),
      builder: (context, snapshot) {
        final job = snapshot.data;
        final jobName = job?.name ?? '';

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            elevation: 2.0,
            title: Text(jobName),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () => EditJobPage.show(
                  context,
                  database: database,
                  job: job,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () => EntryPage.show(
                  context: context,
                  database: database,
                  job: job,
                ),
              )
            ],
          ),
          body: _buildContent(context, job),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, Job job) {
    return StreamBuilder<List<Entry>>(
      stream: database.entriesStream(job: job),
      builder: (context, snapshot) {
        return ListItemsBuilder<Entry>(
          snapshot: snapshot,
          itemBuilder: (context, entry) {
            return DismissibleEntryListItem(
              key: Key('entry-${entry.id}'),
              entry: entry,
              job: job,
              onDismissed: () => _deleteEntry(context, entry),
              onTap: () => EntryPage.show(
                context: context,
                database: database,
                job: job,
                entry: entry,
              ),
            );
          },
        );
      },
    );
  }
}
