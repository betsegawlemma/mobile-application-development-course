// Tests for the lecture layouts. They pass from the start: read them to
// see how each example behaves.
import 'package:campus_companion/exercises/lecture_layouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  testWidgets('ContactTile shows initials, name and the role line', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        const ContactTile(
          name: 'Yonas Alemu',
          role: 'Lab assistant',
          office: 'Lab 3',
        ),
      ),
    );

    expect(find.text('YA'), findsOneWidget);
    expect(find.text('Yonas Alemu'), findsOneWidget);
    expect(find.text('Lab assistant · Lab 3'), findsOneWidget);
    expect(find.byIcon(Icons.circle), findsNothing);
  });

  testWidgets('ContactTile with a very long name does not overflow at 320 px', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrap(
        SizedBox(
          width: 320,
          child: ContactTile(
            name: 'A very long name ' * 10,
            role: 'Lecturer',
            office: 'Room 214',
            online: true,
          ),
        ),
      ),
    );

    // A RenderFlex overflow is reported as an exception in a test.
    expect(tester.takeException(), isNull);
    expect(find.byIcon(Icons.circle), findsOneWidget);
  });

  testWidgets('RoomsPage is a list when narrow and a grid when wide', (
    tester,
  ) async {
    Widget page(double width) => wrap(
      Center(
        child: SizedBox(
          width: width,
          height: 600,
          child: const RoomsPage(rooms: sampleRooms),
        ),
      ),
    );

    await tester.pumpWidget(page(360));
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(GridView), findsNothing);

    await tester.pumpWidget(page(700));
    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
  });

  testWidgets('CoursePage puts the header beside the figures in landscape', (
    tester,
  ) async {
    Widget page(Size size) => MediaQuery(
      data: MediaQueryData(size: size),
      child: wrap(
        const CoursePage(code: 'CS 341', title: 'Mobile', credits: 5),
      ),
    );

    await tester.pumpWidget(page(const Size(400, 800)));
    final avatarPortrait = tester.getCenter(find.byType(CircleAvatar));
    final creditsPortrait = tester.getCenter(find.text('Credits'));
    // Portrait: the figures are below the header.
    expect(creditsPortrait.dy, greaterThan(avatarPortrait.dy));

    await tester.pumpWidget(page(const Size(800, 400)));
    final avatarLandscape = tester.getCenter(find.byType(CircleAvatar));
    final creditsLandscape = tester.getCenter(find.text('Credits'));
    // Landscape: the figures are to the right of the header.
    expect(creditsLandscape.dx, greaterThan(avatarLandscape.dx));
  });
}
