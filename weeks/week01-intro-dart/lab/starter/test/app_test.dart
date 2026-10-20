// This test passes once you finish Task 3 of the lab.
// Run it with: flutter test test/app_test.dart

import 'package:flutter_test/flutter_test.dart';

import 'package:campus_companion/main.dart';

void main() {
  testWidgets('app renders the home screen', (tester) async {
    await tester.pumpWidget(const MainApp());

    // TODO(lab): once you have created CampusCompanionApp in lib/app.dart,
    // import it, pump it instead of MainApp, and expect the AppBar title
    // 'Campus Companion' and the welcome text.
    expect(find.text('Hello World!'), findsOneWidget);
  });
}
