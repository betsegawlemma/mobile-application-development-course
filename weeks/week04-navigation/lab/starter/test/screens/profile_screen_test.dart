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

  // Lab 3, Task 4: the test written before the screen.
  testWidgets('fits a 320-pixel-wide phone without overflow', (tester) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(size: Size(320, 640)),
        child: MaterialApp(
          home: Scaffold(
            body: SizedBox(width: 320, child: ProfileScreen()),
          ),
        ),
      ),
    );

    // A RenderFlex overflow is reported as an exception in a test.
    expect(tester.takeException(), isNull);
    // The last stat label is there and ends inside the 320-pixel box.
    expect(find.text('Posts'), findsOneWidget);
    expect(tester.getRect(find.text('Posts')).right, lessThanOrEqualTo(320));
  });
}
