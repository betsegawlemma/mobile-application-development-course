import 'package:flutter/material.dart';

/// Root widget of Campus Companion.
///
/// Week 1 state: a single screen. Each week's lab adds a feature; see
/// README.md for the roadmap.
class CampusCompanionApp extends StatelessWidget {
  const CampusCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Companion',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF00695C),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campus Companion')),
      body: const Center(child: Text('Welcome to Campus Companion')),
    );
  }
}
