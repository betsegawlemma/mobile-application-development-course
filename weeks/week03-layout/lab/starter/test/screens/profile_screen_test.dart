import 'package:campus_companion/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget app(Size size) => MediaQuery(
        data: MediaQueryData(size: size),
        child: const MaterialApp(home: Scaffold(body: ProfileScreen())),
      );

  testWidgets('shows name, stats and actions', (tester) async {
    await tester.pumpWidget(app(const Size(400, 800)));

    expect(find.text('Sara Bekele'), findsOneWidget);
    expect(find.text('Events'), findsOneWidget);
    expect(find.text('Edit profile'), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
  });

  testWidgets('reports portrait or landscape from MediaQuery',
      (tester) async {
    await tester.pumpWidget(app(const Size(400, 800)));
    expect(find.text('Orientation: portrait'), findsOneWidget);

    await tester.pumpWidget(app(const Size(800, 400)));
    expect(find.text('Orientation: landscape'), findsOneWidget);
  });

  // TODO(lab): Task 4, step 1 — write this test BEFORE you build the
  // screen, run it and watch it fail. Pump ProfileScreen inside
  // SizedBox(width: 320), with a MediaQuery that reports a 320 x 640
  // portrait phone. Expect no exception (an overflow is an exception in a
  // test), and expect the stat label 'Posts' to end inside the 320 px.
}
