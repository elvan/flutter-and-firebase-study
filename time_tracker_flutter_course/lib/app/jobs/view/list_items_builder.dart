import 'package:flutter/material.dart';

import 'empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  final ItemWidgetBuilder<T> itemBuilder;
  final AsyncSnapshot<List<T>> snapshot;

  const ListItemsBuilder({
    Key key,
    @required this.itemBuilder,
    @required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return EmptyContent();
      }
    } else if (snapshot.hasError) {
      return EmptyContent(
        message: "Can't load items right now",
        title: 'Something went wrong',
      );
    }

    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(List<T> items) {
    return ListView.builder(
      itemBuilder: (context, index) => itemBuilder(
        context,
        items[index],
      ),
      itemCount: items.length,
    );
  }
}
