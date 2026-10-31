import 'package:flutter/material.dart';

import '../data/sample_events.dart';

/// The events feed.
// TODO(lab): Task 3 —
//   a. use ListView.builder with an EventCard per event (padding 8);
//   b. wrap it in a LayoutBuilder: when constraints.maxWidth >= 600 use a
//      GridView.builder with SliverGridDelegateWithMaxCrossAxisExtent
//      (maxCrossAxisExtent 480, mainAxisExtent 200) instead.
// test/screens/events_screen_test.dart is the contract.
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  static const wideBreakpoint = 600.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final event in sampleEvents) ListTile(title: Text(event.title)),
      ],
    );
  }
}
