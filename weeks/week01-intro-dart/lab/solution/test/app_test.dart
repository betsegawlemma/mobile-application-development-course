import 'package:campus_companion/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app renders the home screen', (tester) async {
    await tester.pumpWidget(const CampusCompanionApp());

    expect(find.text('Campus Companion'), findsOneWidget);
    expect(find.text('Welcome to Campus Companion'), findsOneWidget);
  });
}
