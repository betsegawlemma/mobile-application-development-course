import 'package:flutter/material.dart';

/// Home screen.
// TODO(lab): Task 2 — decide whether HomeScreen must be stateless or
// stateful (write the reason in lifecycle.md), then make it:
//  - show 'Check-ins today: N' (titleLarge text style)
//  - have a FloatingActionButton (Icons.add) that adds one to N
//  - have a SwitchListTile 'Show lifecycle logger'
//  - show LifecycleLogger(label: 'Check-ins: N') only while the switch
//    is on
// The tests in test/screens/home_screen_test.dart describe the behaviour.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campus Companion')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Welcome to Campus Companion'),
          ],
        ),
      ),
    );
  }
}
