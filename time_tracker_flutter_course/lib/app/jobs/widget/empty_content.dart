import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  final String message;
  final String title;

  const EmptyContent(
      {Key key,
      this.message = 'Add a new item to get started',
      this.title = 'Nothing here'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 32.0,
            ),
          ),
          Text(
            message,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16.0,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
