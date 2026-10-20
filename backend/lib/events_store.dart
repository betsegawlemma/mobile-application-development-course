import 'dart:math';

/// An event as the API represents it. Plain maps keep the server free of
/// the app's model classes; the contract is the JSON shape documented in
/// openapi.yaml.
typedef EventJson = Map<String, Object?>;

/// In-memory storage with the same seed data as the app's sample list.
/// Restarting the server resets it — good for a teaching backend.
class EventsStore {
  EventsStore({List<EventJson>? seed}) {
    for (final e in seed ?? defaultSeed()) {
      _events[e['id'] as String] = Map.of(e);
    }
  }

  final Map<String, EventJson> _events = {};
  final _random = Random();

  static const validVenues = {
    'mainCampus',
    'scienceFaculty',
    'technology',
    'online',
  };

  List<EventJson> list({int page = 1, int limit = 20}) {
    final all = _events.values.toList()
      ..sort((a, b) => (a['start'] as String).compareTo(b['start'] as String));
    final start = (page - 1) * limit;
    if (start >= all.length) return const [];
    return all.sublist(start, min(start + limit, all.length));
  }

  int get count => _events.length;

  EventJson? find(String id) => _events[id];

  /// Validates and stores a new event; returns it with its generated id.
  EventJson create(EventJson input) {
    final validated = validate(input);
    final id = 'e${_random.nextInt(1 << 30).toRadixString(36)}';
    final event = {...validated, 'id': id};
    _events[id] = event;
    return event;
  }

  EventJson? update(String id, EventJson input) {
    if (!_events.containsKey(id)) return null;
    final event = {...validate(input), 'id': id};
    _events[id] = event;
    return event;
  }

  bool delete(String id) => _events.remove(id) != null;

  /// Returns a cleaned copy of [input] or throws [ValidationError].
  static EventJson validate(EventJson input) {
    final title = input['title'];
    if (title is! String || title.trim().isEmpty) {
      throw ValidationError('title is required');
    }
    final start = input['start'];
    if (start is! String || DateTime.tryParse(start) == null) {
      throw ValidationError('start must be an ISO-8601 date-time');
    }
    final venue = input['venue'];
    if (venue is! String || !validVenues.contains(venue)) {
      throw ValidationError('venue must be one of ${validVenues.join(', ')}');
    }
    final description = input['description'] ?? '';
    if (description is! String) {
      throw ValidationError('description must be a string');
    }
    final isFree = input['isFree'] ?? true;
    if (isFree is! bool) throw ValidationError('isFree must be a boolean');
    return {
      'title': title.trim(),
      'start': start,
      'venue': venue,
      'description': description,
      'isFree': isFree,
    };
  }

  static List<EventJson> defaultSeed() => [
    {
      'id': 'e1',
      'title': 'Flutter study group',
      'start': '2026-10-14T16:00:00.000',
      'venue': 'technology',
      'description': 'Weekly session: this week, layouts and constraints.',
      'isFree': true,
    },
    {
      'id': 'e2',
      'title': 'Career fair: software and telecom',
      'start': '2026-10-16T09:00:00.000',
      'venue': 'mainCampus',
      'description': 'Ethio Telecom, Safaricom, Kifiya, Gebeya and others.',
      'isFree': true,
    },
    {
      'id': 'e3',
      'title': 'Hackathon kickoff',
      'start': '2026-10-18T08:30:00.000',
      'venue': 'scienceFaculty',
      'description': '48 hours. Teams of four. Theme announced on the day.',
      'isFree': false,
    },
    {
      'id': 'e4',
      'title': 'Guest lecture: mobile money at scale',
      'start': '2026-10-21T14:00:00.000',
      'venue': 'online',
      'description': 'How Telebirr handles millions of transactions a day.',
      'isFree': true,
    },
    {
      'id': 'e5',
      'title': 'Library orientation',
      'start': '2026-10-22T10:00:00.000',
      'venue': 'mainCampus',
      'description': '',
      'isFree': true,
    },
    {
      'id': 'e6',
      'title': 'Football: CS vs EE',
      'start': '2026-10-24T17:00:00.000',
      'venue': 'technology',
      'description': 'Bring your department colours.',
      'isFree': true,
    },
  ];
}

class ValidationError implements Exception {
  ValidationError(this.message);
  final String message;

  @override
  String toString() => 'ValidationError: $message';
}
