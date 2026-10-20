// Tests for the lecture examples. They pass from the start: read them to
// see what each example returns.
import 'package:campus_companion/exercises/lecture_examples.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Course: constructors, getters and toString', () {
    final course = Course(code: 'CS301', title: 'Mobile Apps', credits: 5);
    expect(course.label, 'CS301 Mobile Apps');
    expect(course.isHeavy, isTrue);
    expect(Course.seminar('CS399').toString(), 'Course(CS399, 1 credits)');
  });

  test('Assignment: copyWith, equality and isOverdue', () {
    final a = Assignment(id: '1', title: 'Lab 2', due: DateTime(2026, 10, 9));
    final b = a.copyWith(done: true);
    expect(a.done, isFalse); // the original is unchanged
    expect(b.done, isTrue);
    expect(a == a.copyWith(), isTrue); // value equality
    expect(a.hashCode, a.copyWith().hashCode);
    expect(a.isOverdue(now: DateTime(2026, 10, 10)), isTrue);
    expect(a.isOverdue(now: DateTime(2026, 10, 8)), isFalse);
    expect(b.isOverdue(now: DateTime(2026, 10, 10)), isFalse);
  });

  test('totalCharged handles every Payment subtype', () {
    expect(totalCharged(const CashPayment(100)), 100);
    expect(totalCharged(const CardPayment(100, 2)), 102);
  });

  test('a mixin adds describe() to Lamp', () {
    expect(Lamp('desk lamp').describe(), 'This is desk lamp');
  });

  test('generics keep the types', () {
    const pair = Pair<String, int>('age', 21);
    final swapped = pair.swap();
    expect(swapped.first, 21);
    expect(swapped, isA<Pair<int, String>>());
    expect(firstOr(<int>[], 0), 0);
    expect(firstOr(['a', 'b'], 'none'), 'a');
  });

  test('shorten is an extension method on String', () {
    expect('Mobile Applications'.shorten(6), 'Mobile...');
    expect('Dart'.shorten(6), 'Dart');
  });

  test('BookShelf throws a custom exception; tryBorrow catches it', () {
    final shelf = BookShelf(2);
    expect(() => shelf.borrow(3), throwsA(isA<NotEnoughCopiesException>()));
    expect(shelf.tryBorrow(3), isFalse);
    expect(shelf.tryBorrow(2), isTrue);
    expect(shelf.copies, 0);
  });

  test('forecasts: one after another and two at the same time', () async {
    expect(await fetchForecast('Adama'), 'Adama: sunny');
    expect(
      await fetchForecastsInOrder(['Adama', 'Bahir Dar']),
      ['Adama: sunny', 'Bahir Dar: sunny'],
    );
    expect(
      await fetchTwoForecasts('Hawassa', 'Gondar'),
      ['Hawassa: sunny', 'Gondar: sunny'],
    );
  });
}
