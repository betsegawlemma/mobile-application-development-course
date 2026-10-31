import 'package:campus_companion/widgets/lifecycle_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('state survives a rebuild with a new label', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: LifecycleLogger(label: 'first')),
    );
    expect(find.text('first — built 1 time(s)'), findsOneWidget);

    // Same widget type at the same position → didUpdateWidget, not a new
    // State, so the build counter keeps counting.
    await tester.pumpWidget(
      const MaterialApp(home: LifecycleLogger(label: 'second')),
    );
    expect(find.text('second — built 2 time(s)'), findsOneWidget);
  });
}
