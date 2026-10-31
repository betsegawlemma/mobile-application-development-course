import 'package:campus_companion/app.dart';
import 'package:campus_companion/screens/events_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app starts on the events feed', (tester) async {
    await tester.pumpWidget(CampusCompanionApp());
    await tester.pumpAndSettle();

    expect(find.text('Events'), findsWidgets); // AppBar title + nav label
    expect(find.byType(EventsScreen), findsOneWidget);
  });
}
