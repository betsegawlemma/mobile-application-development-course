import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

/// Root widget of Campus Companion.
///
/// Week 2 state: a stateful home screen with a check-in counter and a
/// lifecycle demo. See README.md for the roadmap.
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
