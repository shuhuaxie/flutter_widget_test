

import 'package:flutter/material.dart';

class ColumnDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ColumnDemo')),
        body: Column(
          children: <Widget>[
            Text("1"),
            Text("2"),
            Text("3"),
            Text("4"),
          ],
        )
    );

  }
}

class RowDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('RowDemo')),
        body: Row(
          children: <Widget>[
            Expanded(
                child: Text("1")),
            Text("2"),
            Text("3"),
            Text("4"),
          ],
        )
    );

  }
}

class ListViewDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ListViewDemo')),
        body: ListView(
          children: <Widget>[
            Text("1"),
            Text("2"),
            Text("3"),
            Text("4"),
          ],
        )
    );

  }
}