import 'package:flutter/material.dart';
import 'widgets/streamlist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream ListView Demo',
      home: StreamListViewPage(),
    );
  }
}
