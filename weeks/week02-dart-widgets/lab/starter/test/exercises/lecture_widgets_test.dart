// Tests for the lecture widgets. They pass from the start: read them to
// see how each widget behaves.
import 'package:campus_companion/exercises/lecture_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('VoteCounter counts votes and shows details on request',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: VoteCounter(question: 'Lab on Friday?')),
      ),
    );
    expect(find.text('Votes: 0'), findsOneWidget);

    await tester.tap(find.text('Vote'));
    await tester.pump(); // one frame: build() runs after setState
    expect(find.text('Votes: 1'), findsOneWidget);

    expect(find.text('Last change: vote number 1'), findsNothing);
    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(find.text('Last change: vote number 1'), findsOneWidget);
  });

  testWidgets('TickCounter keeps its State when the interval changes',
      (tester) async {
    const second = Duration(seconds: 1);
    await tester.pumpWidget(
      const MaterialApp(home: TickCounter(interval: second)),
    );
    await tester.pump(second);
    await tester.pump(second);
    expect(find.text('Ticks: 2'), findsOneWidget);

    // Same type at the same place: didUpdateWidget runs, the count stays.
    await tester.pumpWidget(
      const MaterialApp(home: TickCounter(interval: Duration(seconds: 2))),
    );
    expect(find.text('Ticks: 2'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    expect(find.text('Ticks: 3'), findsOneWidget);

    // Removing the widget calls dispose, which cancels the timer. Without
    // the cancel, the test fails: "A Timer is still pending".
    await tester.pumpWidget(const MaterialApp(home: Text('gone')));
  });
}
