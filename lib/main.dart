import 'dart:async';

import 'package:deneme/screens/startWork/startWorkMainScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Test",
      home: StartWorkMainScreen(),
    );
  }
}