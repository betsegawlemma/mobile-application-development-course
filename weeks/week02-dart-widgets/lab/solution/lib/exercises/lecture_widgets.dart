// Week 2 lecture widgets — the stateful widgets shown in the notes and
// slides, and built in the live coding. They are similar to the lab's
// HomeScreen and LifecycleLogger, but not the same.
//
// The tests in test/exercises/lecture_widgets_test.dart show how they
// behave.

import 'dart:async';

import 'package:flutter/material.dart';

/// Counts votes. The live coding starts from a StatelessWidget and turns
/// it into this StatefulWidget.
class VoteCounter extends StatefulWidget {
  const VoteCounter({required this.question, super.key});

  final String question;

  @override
  State<VoteCounter> createState() => _VoteCounterState();
}

class _VoteCounterState extends State<VoteCounter> {
  int _votes = 0;
  bool _showDetails = false;

  void _vote() {
    // Change the field inside setState, so Flutter calls build() again.
    setState(() => _votes++);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.question),
        Text('Votes: $_votes'),
        ElevatedButton(onPressed: _vote, child: const Text('Vote')),
        SwitchListTile(
          title: const Text('Show details'),
          value: _showDetails,
          onChanged: (value) => setState(() => _showDetails = value),
        ),
        // Collection-if: the widget exists only while the switch is on.
        if (_showDetails) Text('Last change: vote number $_votes'),
      ],
    );
  }
}

/// Shows how many ticks have passed. It starts a [Timer] in initState,
/// restarts it in didUpdateWidget when the interval changes, and cancels
/// it in dispose.
class TickCounter extends StatefulWidget {
  const TickCounter({required this.interval, super.key});

  final Duration interval;

  @override
  State<TickCounter> createState() => _TickCounterState();
}

class _TickCounterState extends State<TickCounter> {
  Timer? _timer;
  int _ticks = 0;

  @override
  void initState() {
    super.initState(); // first
    _startTimer();
  }

  @override
  void didUpdateWidget(TickCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The parent rebuilt with a new TickCounter. The State is kept, so
    // compare the old and the new configuration.
    if (oldWidget.interval != widget.interval) {
      _timer?.cancel();
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(widget.interval, (_) {
      setState(() => _ticks++);
    });
  }

  @override
  Widget build(BuildContext context) => Text('Ticks: $_ticks');

  @override
  void dispose() {
    _timer?.cancel(); // undo what initState started
    super.dispose(); // last
  }
}
