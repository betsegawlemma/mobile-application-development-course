// Lab 3, Task 6 — "Your own design": a preview card for one note.
//
// The design is described in lab/README.md, Task 6. The constructor and
// editedLabel are given; you choose the widgets in build().
//
// See it running, and resize the browser window to 360 and 900 px:
//   flutter run -d chrome -t lib/exercises/note_card.dart
// test/exercises/note_card_test.dart checks the parts of the design that a
// test can check.

import 'package:flutter/material.dart';

void main() => runApp(const NoteCardPreview());

/// A preview card for one note: title, the start of the body, tags and the
/// date it was last edited.
class NoteCard extends StatelessWidget {
  const NoteCard({
    required this.title,
    required this.body,
    required this.edited,
    this.tags = const [],
    this.pinned = false,
    super.key,
  });

  final String title;
  final String body;
  final DateTime edited;
  final List<String> tags;
  final bool pinned;

  /// The widest the card may be, on any screen.
  static const maxCardWidth = 560.0;

  @override
  Widget build(BuildContext context) {
    // TODO(lab): Task 6 — build the card described in lab/README.md,
    // Task 6, at 360 px and at 900 px wide. Choose the widgets yourself.
    // At Checkpoint B you draw your widget tree and say which widget stops
    // the title overflowing.
    return Text(title);
  }
}

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

/// The date line of the card: 'Edited 14 Oct' for 14 October.
String editedLabel(DateTime date) =>
    'Edited ${date.day} ${_months[date.month - 1]}';

/// A small app that shows two sample cards in a list.
class NoteCardPreview extends StatelessWidget {
  const NoteCardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteCard preview',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF00695C),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('NoteCard preview')),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            NoteCard(
              title: 'Shopping list for the field trip to Debre Libanos',
              body:
                  'Bread, water, two notebooks, the printed map and a '
                  'torch. Ask Abebe whether the bus leaves at seven or at '
                  'half past seven, and whether we need to bring our '
                  'student cards.',
              edited: DateTime(2026, 10, 14),
              tags: const ['trip', 'shopping', 'week 3', 'remember'],
              pinned: true,
            ),
            NoteCard(
              title: 'Layout',
              body: 'Constraints go down, sizes go up.',
              edited: DateTime(2026, 10, 2),
            ),
          ],
        ),
      ),
    );
  }
}
