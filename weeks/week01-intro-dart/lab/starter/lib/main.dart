import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// TODO(lab): Task 3 — rename this to CampusCompanionApp, move it into
// lib/app.dart, give it a title and a Material 3 theme, and show a
// HomeScreen with an AppBar. See lab/README.md.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
