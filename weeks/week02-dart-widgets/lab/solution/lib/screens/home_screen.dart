import 'package:flutter/material.dart';

import '../widgets/lifecycle_logger.dart';

/// Home screen. A StatefulWidget because it owns two pieces of mutable
/// state: the check-in counter and whether the lifecycle demo is shown.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _checkIns = 0;
  bool _showLogger = false;

  void _checkIn() {
    // setState tells Flutter "my state changed, call build() again".
    // Mutating _checkIns without setState would change the value but not
    // the screen.
    setState(() => _checkIns++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campus Companion')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Welcome to Campus Companion'),
            const SizedBox(height: 16),
            Text(
              'Check-ins today: $_checkIns',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('Show lifecycle logger'),
              value: _showLogger,
              onChanged: (value) => setState(() => _showLogger = value),
            ),
            // Collection-if: the logger is mounted only while the switch is
            // on. Turning it off disposes it; turning it on creates a new
            // State. Changing the label while on triggers didUpdateWidget.
            if (_showLogger) LifecycleLogger(label: 'Check-ins: $_checkIns'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _checkIn,
        tooltip: 'Check in',
        child: const Icon(Icons.add),
      ),
    );
  }
}
