import 'package:campus_companion/models/event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final base = Event(
    id: 'e1',
    title: 'Flutter meetup',
    start: DateTime(2026, 10, 12, 14),
    venue: Venue.technology,
  );

  group('Event', () {
    test('copyWith changes only the given fields', () {
      final moved = base.copyWith(venue: Venue.online);

      expect(moved.venue, Venue.online);
      expect(moved.title, base.title);
      expect(moved.id, base.id);
      expect(base.venue, Venue.technology, reason: 'original is unchanged');
    });

    test('value equality', () {
      final same = base.copyWith();
      expect(same, equals(base));
      expect(same.hashCode, base.hashCode);
      expect(base.copyWith(title: 'Other'), isNot(equals(base)));
    });

    test('isUpcoming compares against an injected clock', () {
      expect(base.isUpcoming(now: DateTime(2026, 10, 1)), isTrue);
      expect(base.isUpcoming(now: DateTime(2026, 10, 13)), isFalse);
    });

    test('enhanced enum carries data', () {
      expect(Venue.mainCampus.location, 'Sidist Kilo');
      expect(Venue.values.length, 4);
    });
  });
}
