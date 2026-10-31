import 'package:campus_companion/exercises/lecture_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpLibrary(WidgetTester tester, {String? initial}) async {
    final router = initial == null
        ? createLibraryRouter()
        : createLibraryRouter(initialLocation: initial);
    await tester.pumpWidget(LibraryApp(router: router));
    await tester.pumpAndSettle();
  }

  testWidgets('the bottom bar switches between the branches', (
    tester,
  ) async {
    await pumpLibrary(tester);
    expect(find.byType(BooksPage), findsOneWidget);

    await tester.tap(find.text('Loans'));
    await tester.pumpAndSettle();
    expect(find.text('Pick-up desk: Main desk'), findsOneWidget);
  });

  testWidgets('a book opens on the root navigator and covers the bar', (
    tester,
  ) async {
    await pumpLibrary(tester);

    await tester.tap(find.text('Oromay'));
    await tester.pumpAndSettle();
    expect(find.byType(BookPage), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.byType(BottomAppBar), findsOneWidget);

    await tester.tap(find.byTooltip('Reserve'));
    await tester.pump();
    expect(find.text('Reserved Oromay'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
  });

  testWidgets('an unknown ISBN shows "Book not found"', (tester) async {
    await pumpLibrary(tester, initial: '/books/999');
    expect(find.text('Book not found'), findsOneWidget);
  });

  testWidgets('an unknown location shows the error page', (tester) async {
    await pumpLibrary(tester, initial: '/shelves');
    expect(find.text('Nothing at /shelves'), findsOneWidget);
  });

  testWidgets('the drawer closes before Opening hours opens', (tester) async {
    await pumpLibrary(tester);

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Opening hours'));
    await tester.pumpAndSettle();
    expect(find.byType(OpeningHoursPage), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(Drawer), findsNothing);
  });

  testWidgets('the chosen desk comes back as a result', (tester) async {
    await pumpLibrary(tester, initial: LibraryRoutes.loans);

    await tester.tap(find.text('Change desk'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Law library'));
    await tester.pumpAndSettle();
    expect(find.text('Pick-up desk: Law library'), findsOneWidget);

    await tester.tap(find.text('Change desk'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Pick-up desk: Law library'), findsOneWidget);
  });

  testWidgets('the tabs split the books', (tester) async {
    await pumpLibrary(tester);
    expect(find.text('Oromay'), findsOneWidget);
    expect(find.text('Clean Code'), findsNothing);

    await tester.tap(find.text('On loan'));
    await tester.pumpAndSettle();
    expect(find.text('Clean Code'), findsOneWidget);
  });
}
