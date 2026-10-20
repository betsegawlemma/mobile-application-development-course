import 'package:flutter/foundation.dart';

/// Where an event takes place. An enhanced enum: it has fields and a
/// constructor like a class, but a fixed set of instances.
enum Venue {
  mainCampus('Main campus', 'Sidist Kilo'),
  scienceFaculty('Science faculty', 'Arat Kilo'),
  technology('Technology faculty', 'Amist Kilo'),
  online('Online', 'Zoom / Teams');

  const Venue(this.label, this.location);

  final String label;
  final String location;
}

/// A campus event. Immutable: every field is `final`, and changes are made
/// with [copyWith], which returns a new instance.
// TODO(lab): Task 1 — implement isUpcoming, copyWith, ==, hashCode and
// toString. The tests in test/models/event_test.dart describe the exact
// behaviour.
@immutable
class Event {
  const Event({
    required this.id,
    required this.title,
    required this.start,
    required this.venue,
    this.description = '',
    this.isFree = true,
  });

  final String id;
  final String title;
  final DateTime start;
  final Venue venue;
  final String description;
  final bool isFree;

  /// True when the event starts in the future relative to [now]
  /// (defaults to the current time — injectable for tests).
  bool isUpcoming({DateTime? now}) => throw UnimplementedError();

  Event copyWith({
    String? id,
    String? title,
    DateTime? start,
    Venue? venue,
    String? description,
    bool? isFree,
  }) {
    throw UnimplementedError();
  }

  // TODO(lab): override == and hashCode so two events with the same field
  // values are equal (use Object.hash), and toString →
  // 'Event($id, $title, ${venue.label}, $start)'.
}
