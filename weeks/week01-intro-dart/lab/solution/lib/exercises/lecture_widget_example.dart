// Week 1 lecture example — a one-screen app, built in the live coding.
// The lab builds a different app (Campus Companion) in the same way.
//
// To run it instead of the lab app, temporarily change lib/main.dart to
// call runApp(const TimetableApp()).
import 'package:flutter/material.dart';

class TimetableApp extends StatelessWidget {
  const TimetableApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Bus Timetable', home: TimetableScreen());
  }
}

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bus Timetable')),
      body: const Center(child: Text('Next bus to Sidist Kilo: 08:15')),
    );
  }
}
