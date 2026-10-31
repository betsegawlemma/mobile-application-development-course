import 'package:flutter/material.dart';

import '../models/event.dart';

/// One event in the feed.
// TODO(lab): Task 2 — replace the ListTile with the card pictured in
// lab/README.md, Task 2. test/widgets/event_card_test.dart is the
// contract; the widget list is in the task's "Step-by-step help".
class EventCard extends StatelessWidget {
  const EventCard({required this.event, super.key});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(event.title));
  }
}
