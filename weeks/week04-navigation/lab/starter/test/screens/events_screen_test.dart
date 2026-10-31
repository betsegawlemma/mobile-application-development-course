import 'package:campus_companion/data/sample_events.dart';
import 'package:campus_companion/screens/events_screen.dart';
import 'package:campus_companion/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // A clock before every sample event: everything is "upcoming".
  final clock = DateTime(2026, 1, 1);

  Widget app(double width) => MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: width,
              height: 800,
              child: EventsScreen(now: clock),
            ),
          ),
        ),
      );

  testWidgets('narrow width uses a ListView and shows the first events',
      (tester) async {
    await tester.pumpWidget(app(360));

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(GridView), findsNothing);
    expect(find.text(sampleEvents.first.title), findsOneWidget);
  });

  testWidgets('wide width uses a GridView', (tester) async {
    await tester.pumpWidget(app(700));

    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
    expect(find.byType(EventCard), findsWidgets);
  });
}
