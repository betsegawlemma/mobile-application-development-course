import 'package:campus_companion/exercises/lecture_widget_example.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('the timetable example shows a title and the next bus', (
    tester,
  ) async {
    await tester.pumpWidget(const TimetableApp());
    expect(find.text('Bus Timetable'), findsOneWidget);
    expect(find.text('Next bus to Sidist Kilo: 08:15'), findsOneWidget);
  });
}
