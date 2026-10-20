// Week 1 Dart exercises — reference solution.
// Run the tests with: flutter test test/exercises

/// Returns 'Fizz' if [n] is divisible by 3, 'Buzz' if divisible by 5,
/// 'FizzBuzz' if divisible by both, otherwise [n] as a string.
String fizzBuzz(int n) {
  if (n % 15 == 0) return 'FizzBuzz';
  if (n % 3 == 0) return 'Fizz';
  if (n % 5 == 0) return 'Buzz';
  return '$n';
}

/// Returns the average of the numbers in [numbers] that are greater than
/// zero. If there are none, returns 0.
double averageOfPositives(List<double> numbers) {
  final positives = numbers.where((n) => n > 0).toList();
  if (positives.isEmpty) return 0;
  return positives.fold(0.0, (sum, n) => sum + n) / positives.length;
}

/// Returns the body-mass-index category: below 18.5 'Underweight',
/// below 25 'Normal', below 30 'Overweight', otherwise 'Obese'.
/// Throws [ArgumentError] if [bmi] is zero or negative.
String bmiCategory(double bmi) {
  if (bmi <= 0) {
    throw ArgumentError.value(bmi, 'bmi', 'must be greater than zero');
  }
  return switch (bmi) {
    < 18.5 => 'Underweight',
    < 25 => 'Normal',
    < 30 => 'Overweight',
    _ => 'Obese',
  };
}

/// Returns true when [text] reads the same forwards and backwards,
/// ignoring case and any character that is not a letter or digit.
bool isPalindrome(String text) {
  final cleaned = text.toLowerCase().replaceAll(RegExp('[^a-z0-9]'), '');
  return cleaned == cleaned.split('').reversed.join();
}

/// Counts how many times each letter a–z occurs in [text], ignoring case.
Map<String, int> letterCount(String text) {
  final counts = <String, int>{};
  final letter = RegExp('[a-z]');
  for (final char in text.toLowerCase().split('')) {
    if (!letter.hasMatch(char)) continue;
    counts.update(char, (n) => n + 1, ifAbsent: () => 1);
  }
  return counts;
}

/// Converts a distance between kilometres and miles, rounded to one
/// decimal place.
double convertDistance(double value, {bool toKilometres = false}) {
  const milesPerKilometre = 0.621371;
  final result = toKilometres
      ? value / milesPerKilometre
      : value * milesPerKilometre;
  return (result * 10).roundToDouble() / 10;
}

/// Returns the first [count] Fibonacci numbers starting 0, 1, 1, 2, ...
List<int> fibonacci(int count) {
  final result = <int>[];
  var a = 0;
  var b = 1;
  for (var i = 0; i < count; i++) {
    result.add(a);
    final next = a + b;
    a = b;
    b = next;
  }
  return result;
}

/// Summarises a value that may be null or of any type.
String summarise(Object? value) {
  return switch (value) {
    null => 'no value',
    final bool b => b ? 'yes' : 'no',
    double() => 'a decimal number',
    final String s => '"$s" has ${s.length} characters',
    final Map<Object?, Object?> m => 'a map with ${m.length} entries',
    _ => 'unknown',
  };
}
