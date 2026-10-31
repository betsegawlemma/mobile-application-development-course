import 'package:campus_companion/exercises/named_routes_demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('pushNamed from the list opens the event', (tester) async {
    await tester.pumpWidget(const NamedRoutesDemoApp());

    await tester.tap(find.text('All events'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Career fair'));
    await tester.pumpAndSettle();

    expect(find.text('Event 42'), findsOneWidget);
  });

  testWidgets('starting at /events/42 builds three routes', (tester) async {
    await tester.pumpWidget(
      const NamedRoutesDemoApp(initialRoute: '/events/42'),
    );
    await tester.pumpAndSettle();
    expect(find.text('Event 42'), findsOneWidget);

    // The initial name is split: '/', '/events', '/events/42'.
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Events'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Named routes demo'), findsOneWidget);
  });

  testWidgets('starting at /events/abc reports an error and shows /', (
    tester,
  ) async {
    await tester.pumpWidget(
      const NamedRoutesDemoApp(initialRoute: '/events/abc'),
    );
    await tester.pumpAndSettle();

    // 'Could not navigate to initial route.' The initial route is ignored.
    expect(tester.takeException(), contains('Could not navigate'));
    expect(find.text('Named routes demo'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);
  });

  testWidgets('pushNamed with an unknown id uses onUnknownRoute', (
    tester,
  ) async {
    await tester.pumpWidget(const NamedRoutesDemoApp());
    final context = tester.element(find.byType(DemoHomePage));

    Navigator.pushNamed(context, '/events/abc');
    await tester.pumpAndSettle();

    expect(find.text('No screen for /events/abc'), findsOneWidget);
  });

  test('generateDemoRoute parses the id or returns null', () {
    expect(
      generateDemoRoute(const RouteSettings(name: '/events/7')),
      isNotNull,
    );
    expect(generateDemoRoute(const RouteSettings(name: '/events/abc')), isNull);
    expect(generateDemoRoute(const RouteSettings(name: '/events/5')), isNull);
    expect(
      generateDemoRoute(const RouteSettings(name: '/events/7/photos')),
      isNull,
    );
  });

  testWidgets('the campus page returns a result', (tester) async {
    await tester.pumpWidget(const NamedRoutesDemoApp());

    await tester.tap(find.text('Choose a campus'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Arat Kilo'));
    await tester.pumpAndSettle();
    expect(find.text('Campus: Arat Kilo'), findsOneWidget);

    await tester.tap(find.text('Choose a campus'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(
      find.text('Campus: Arat Kilo'),
      findsOneWidget,
      reason: 'back returns null, so the campus does not change',
    );
  });
}
