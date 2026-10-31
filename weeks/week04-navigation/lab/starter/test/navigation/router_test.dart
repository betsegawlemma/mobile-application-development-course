import 'package:campus_companion/app.dart';
import 'package:campus_companion/data/sample_events.dart';
import 'package:campus_companion/navigation/router.dart';
import 'package:campus_companion/screens/about_screen.dart';
import 'package:campus_companion/screens/check_in_screen.dart';
import 'package:campus_companion/screens/edit_profile_screen.dart';
import 'package:campus_companion/screens/event_detail_screen.dart';
import 'package:campus_companion/screens/events_screen.dart';
import 'package:campus_companion/screens/notes_screen.dart';
import 'package:campus_companion/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester, {String? initial}) async {
    final router = initial == null ? createRouter() : createRouter(initialLocation: initial);
    await tester.pumpWidget(CampusCompanionApp(router: router));
    await tester.pumpAndSettle();
  }

  group('bottom navigation', () {
    testWidgets('switches sections', (tester) async {
      await pumpApp(tester);
      expect(find.byType(EventsScreen), findsOneWidget);

      await tester.tap(find.byIcon(Icons.note_outlined));
      await tester.pumpAndSettle();
      expect(find.byType(NotesScreen), findsOneWidget);

      await tester.tap(find.byIcon(Icons.person_outline));
      await tester.pumpAndSettle();
      expect(find.byType(ProfileScreen), findsOneWidget);
    });
  });

  group('event detail', () {
    testWidgets('tapping a card pushes the detail and back returns',
        (tester) async {
      await pumpApp(tester);
      final first = sampleEvents.first;
      // The app uses the real clock, so the sample event may already be
      // in the past; open the tab that lists it.
      if (!first.isUpcoming()) {
        await tester.tap(find.text('Past'));
        await tester.pumpAndSettle();
      }

      await tester.tap(find.text(first.title));
      await tester.pumpAndSettle();

      expect(find.byType(EventDetailScreen), findsOneWidget);
      expect(find.text(first.description), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing,
          reason: 'detail covers the shell');

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.byType(EventsScreen), findsOneWidget);
    });

    // TODO(lab): Task 4 — write two tests here before you change
    // router.dart, and watch them fail:
    // 1. start at '/events/nope' and expect the text 'Event not found';
    // 2. start at a location that matches no route and expect the text of
    //    your error page ('No route for ...').
    // Use pumpApp(tester, initial: ...).
  });

  group('drawer', () {
    testWidgets('opens and navigates to About and Check-in', (tester) async {
      await pumpApp(tester);

      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('About'));
      await tester.pumpAndSettle();
      expect(find.byType(AboutScreen), findsOneWidget);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Check-in'));
      await tester.pumpAndSettle();
      expect(find.byType(CheckInScreen), findsOneWidget);
    });
  });

  group('tabs', () {
    testWidgets('Upcoming and Past split the feed by the injected clock',
        (tester) async {
      // Standalone screen: no router needed for the tab behaviour.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: EventsScreen(now: DateTime(2026, 10, 20))),
        ),
      );
      await tester.pumpAndSettle();

      // Events on/after 20 Oct are upcoming.
      expect(find.text('Guest lecture: mobile money at scale'), findsOneWidget);
      expect(find.text('Flutter study group'), findsNothing);

      await tester.tap(find.text('Past'));
      await tester.pumpAndSettle();
      expect(find.text('Flutter study group'), findsOneWidget);
    });
  });

  group('edit profile returns a result', () {
    testWidgets('new name appears on the profile', (tester) async {
      await pumpApp(tester, initial: Routes.profile);
      expect(find.text('Sara Bekele'), findsOneWidget);

      await tester.tap(find.text('Edit profile'));
      await tester.pumpAndSettle();
      expect(find.byType(EditProfileScreen), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Hana Tadesse');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.text('Hana Tadesse'), findsOneWidget);
    });

    testWidgets('cancel keeps the old name', (tester) async {
      await pumpApp(tester, initial: Routes.profile);
      await tester.tap(find.text('Edit profile'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text('Sara Bekele'), findsOneWidget);
    });
  });
}
