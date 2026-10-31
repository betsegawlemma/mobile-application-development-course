import 'package:campus_companion/exercises/settings_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// These tests check the requirement, not your design: they open Settings
// with a button whose tooltip is 'Settings', or, if there is none, with a
// drawer entry whose text is 'Settings'.
void main() {
  Future<void> openSettings(WidgetTester tester) async {
    final button = find.byTooltip('Settings');
    if (button.evaluate().isNotEmpty) {
      await tester.tap(button.first);
    } else {
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Settings').last);
    }
    await tester.pumpAndSettle();
  }

  for (final tab in ['Home', 'Timetable', 'Map']) {
    testWidgets('from the $tab tab, Settings opens without the bottom bar '
        'and back returns to $tab', (tester) async {
      await tester.pumpWidget(SettingsDesignApp());
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(tab),
        ),
      );
      await tester.pumpAndSettle();

      await openSettings(tester);
      expect(find.byType(SettingsPage), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.byType(SettingsPage), findsNothing);
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.text('The $tab tab'), findsOneWidget);
    });
  }

  testWidgets('the address /settings opens Settings without the bottom bar', (
    tester,
  ) async {
    await tester.pumpWidget(
      SettingsDesignApp(
        router: createDesignRouter(initialLocation: DesignRoutes.settings),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(SettingsPage), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });
}
