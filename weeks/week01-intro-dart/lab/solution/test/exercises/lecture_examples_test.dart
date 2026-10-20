// Tests for the lecture examples. They pass from the start: read them to
// see what each example returns.
import 'package:campus_companion/exercises/lecture_examples.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('gradeLetter maps scores to letters and rejects bad scores', () {
    expect(gradeLetter(90), 'A');
    expect(gradeLetter(89.9), 'B');
    expect(gradeLetter(12), 'F');
    expect(() => gradeLetter(101), throwsArgumentError);
  });

  test('sumOfEvens adds only the even numbers', () {
    expect(sumOfEvens([1, 2, 3, 4, 5, 6]), 12);
    expect(sumOfEvens([]), 0);
  });

  test('wordCount counts words case-insensitively', () {
    expect(wordCount('the cat The dog'), {'the': 2, 'cat': 1, 'dog': 1});
    expect(wordCount('  a   b  a '), {'a': 2, 'b': 1});
  });

  test('convertTemperature converts both ways', () {
    expect(convertTemperature(100), 212);
    expect(convertTemperature(98.6, toCelsius: true), 37);
  });

  test('describe names each kind of value', () {
    expect(describe(null), 'nothing');
    expect(describe(42), 'the integer 42');
    expect(describe([1, 2, 3]), 'a list of 3 items');
  });
}
