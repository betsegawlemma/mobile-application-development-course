// Lab 3, Task 6. These tests check the parts of the NoteCard design that a
// test can check. They do not check which widgets you chose: the TA asks
// you about that at Checkpoint B.
import 'package:campus_companion/exercises/note_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final edited = DateTime(2026, 10, 14);

  // The card in a list, as in the preview app, at a given screen width.
  Widget atWidth(double width, NoteCard card) => MaterialApp(
    home: Scaffold(
      body: Center(
        child: SizedBox(
          width: width,
          height: 600,
          child: ListView(children: [card]),
        ),
      ),
    ),
  );

  testWidgets('shows the title, the body, the tags and the date', (
    tester,
  ) async {
    await tester.pumpWidget(
      atWidth(
        360,
        NoteCard(
          title: 'Field trip',
          body: 'Bread and water.',
          edited: edited,
          tags: const ['trip', 'shopping'],
        ),
      ),
    );

    expect(find.text('Field trip'), findsOneWidget);
    expect(find.text('Bread and water.'), findsOneWidget);
    expect(find.text('trip'), findsOneWidget);
    expect(find.text('shopping'), findsOneWidget);
    expect(find.text('Edited 14 Oct'), findsOneWidget);
  });

  testWidgets('shows the pin icon only for a pinned note', (tester) async {
    NoteCard card({required bool pinned}) => NoteCard(
      title: 'Field trip',
      body: 'Bread and water.',
      edited: edited,
      pinned: pinned,
    );

    await tester.pumpWidget(atWidth(360, card(pinned: true)));
    expect(find.byIcon(Icons.push_pin), findsOneWidget);

    await tester.pumpWidget(atWidth(360, card(pinned: false)));
    expect(find.byIcon(Icons.push_pin), findsNothing);
  });

  for (final width in [320.0, 360.0, 900.0]) {
    testWidgets('long text and many tags do not overflow at $width px', (
      tester,
    ) async {
      await tester.pumpWidget(
        atWidth(
          width,
          NoteCard(
            title: 'A very long title ' * 10,
            body: 'A very long body. ' * 40,
            edited: edited,
            tags: [for (var i = 1; i <= 8; i++) 'tag number $i'],
            pinned: true,
          ),
        ),
      );

      // A RenderFlex overflow is reported as an exception in a test.
      expect(tester.takeException(), isNull);
      expect(find.text('Edited 14 Oct'), findsOneWidget);
    });
  }

  testWidgets('at 900 px the card is at most 560 px wide', (tester) async {
    final title = 'A very long title ' * 10;
    await tester.pumpWidget(
      atWidth(900, NoteCard(title: title, body: 'Short.', edited: edited)),
    );

    // The title takes the width the card gives it, so it can only be as
    // wide as the card.
    expect(
      tester.getSize(find.text(title)).width,
      lessThanOrEqualTo(NoteCard.maxCardWidth),
    );
  });
}
