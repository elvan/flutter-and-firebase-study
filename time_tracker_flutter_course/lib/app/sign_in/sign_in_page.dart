import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.yellow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.orange,
            child: SizedBox(
              height: 100.0,
            ),
          ),
          Container(
            color: Colors.red,
            child: SizedBox(
              height: 100.0,
            ),
          ),
          Container(
            color: Colors.purple,
            child: SizedBox(
              height: 100.0,
            ),
          ),
        ],
      ),
    );
  }
}
