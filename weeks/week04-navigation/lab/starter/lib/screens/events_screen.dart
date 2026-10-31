import 'package:flutter/material.dart';

import '../data/sample_events.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';

/// The events feed.
///
/// [now] is injectable so tests (and the sample data) do not depend on the
/// real clock.
// TODO(lab): Task 2 — tapping an EventCard opens EventDetailScreen for
// that event: first with Navigator.push, then (Task 4) with go_router.
// TODO(lab): Task 7 — split the feed into 'Upcoming' and 'Past' tabs with a
// DefaultTabController, a TabBar and a TabBarView. Use event.isUpcoming(now:
// clock). Show 'No upcoming events' / 'No past events' when a tab is empty.
class EventsScreen extends StatelessWidget {
  const EventsScreen({this.now, super.key});

  final DateTime? now;

  static const wideBreakpoint = 600.0;

  @override
  Widget build(BuildContext context) {
    final clock = now ?? DateTime.now();
    final upcoming = sampleEvents
        .where((e) => e.isUpcoming(now: clock))
        .toList();

    return _EventList(events: upcoming, emptyText: 'No upcoming events');
  }
}

class _EventList extends StatelessWidget {
  const _EventList({required this.events, required this.emptyText});

  final List<Event> events;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Center(child: Text(emptyText));
    }

    Widget item(BuildContext context, int index) {
      final event = events[index];
      return EventCard(event: event);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= EventsScreen.wideBreakpoint) {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 480,
              mainAxisExtent: 200,
            ),
            itemCount: events.length,
            itemBuilder: item,
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: events.length,
          itemBuilder: item,
        );
      },
    );
  }
}
