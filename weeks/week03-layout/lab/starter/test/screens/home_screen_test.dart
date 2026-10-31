import 'package:campus_companion/screens/events_screen.dart';
import 'package:campus_companion/screens/home_screen.dart';
import 'package:campus_companion/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the events feed first and switches to profile',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    expect(find.byType(EventsScreen), findsOneWidget);
    expect(find.byType(ProfileScreen), findsNothing);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(find.byType(EventsScreen), findsNothing);
  });
}
