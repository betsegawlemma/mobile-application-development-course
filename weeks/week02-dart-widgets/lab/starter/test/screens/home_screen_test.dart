import 'package:campus_companion/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('tapping the FAB increments the check-in counter',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.text('Check-ins today: 0'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // rebuild after setState

    expect(find.text('Check-ins today: 1'), findsOneWidget);
  });

  // TODO(lab): Task 2 — write this test first, before the FAB works, and
  // run it to see it fail. Pump HomeScreen, tap the FloatingActionButton
  // three times, and expect the text 'Check-ins today: 3'.

  testWidgets('the lifecycle logger is mounted only while the switch is on',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.byType(Card), findsNothing);

    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(find.byType(Card), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(find.byType(Card), findsNothing);
  });
}
