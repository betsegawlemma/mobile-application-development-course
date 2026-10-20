import 'package:flutter/material.dart';

/// A widget that prints every lifecycle callback so you can watch the
/// StatefulWidget lifecycle in the console.
// TODO(lab): Task 3 — convert this to a StatefulWidget whose State:
//  - keeps an int _buildCount
//  - overrides initState, didChangeDependencies, didUpdateWidget, build
//    and dispose, each calling debugPrint('[LifecycleLogger] <name>')
//  - build() increments _buildCount and returns a Card containing
//    Text('${widget.label} — built $_buildCount time(s)')
// Remember: super.initState() first, super.dispose() last.
class LifecycleLogger extends StatelessWidget {
  const LifecycleLogger({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(label),
      ),
    );
  }
}
