import 'package:campus_companion/app.dart';
import 'package:campus_companion/screens/events_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app renders the home screen with the events feed',
      (tester) async {
    await tester.pumpWidget(const CampusCompanionApp());

    expect(find.text('Campus Companion'), findsOneWidget);
    expect(find.byType(EventsScreen), findsOneWidget);
  });
}
