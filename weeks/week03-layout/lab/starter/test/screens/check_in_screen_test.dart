import 'package:campus_companion/screens/check_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('tapping the button increments the check-in counter',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: CheckInScreen())),
    );

    expect(find.text('Check-ins today: 0'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    expect(find.text('Check-ins today: 1'), findsOneWidget);
  });

  testWidgets('the lifecycle logger is mounted only while the switch is on',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: CheckInScreen())),
    );

    expect(find.byType(Card), findsNothing);

    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(find.byType(Card), findsOneWidget);

    await tester.tap(find.byType(Switch));
    await tester.pump();
    expect(find.byType(Card), findsNothing);
  });
}
