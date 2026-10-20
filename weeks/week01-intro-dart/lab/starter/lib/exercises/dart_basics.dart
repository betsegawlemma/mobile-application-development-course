// Week 1 Dart exercises — variables, operators, control flow, functions,
// collections. Replace each `throw UnimplementedError()` with a working
// implementation. Run the tests with:
//
//   flutter test test/exercises
//
// The worked examples from the lecture are in lecture_examples.dart. Each
// exercise below is similar to one of them, but not the same: read the
// example, close the file, then write the exercise yourself.
//
// You can also paste a function into https://dartpad.dev to experiment.

/// Returns 'Fizz' if [n] is divisible by 3, 'Buzz' if divisible by 5,
/// 'FizzBuzz' if divisible by both, otherwise [n] as a string.
String fizzBuzz(int n) {
  // TODO(lab): Exercise 1
  throw UnimplementedError();
}

/// Returns the average of the numbers in [numbers] that are greater than
/// zero. If there are none, returns 0.
/// [1.0, -2.0, 3.0] → 2.0
double averageOfPositives(List<double> numbers) {
  // TODO(lab): Exercise 2 — similar example: sumOfEvens.
  throw UnimplementedError();
}

/// Returns the body-mass-index category: below 18.5 'Underweight',
/// below 25 'Normal', below 30 'Overweight', otherwise 'Obese'.
/// Throws [ArgumentError] if [bmi] is zero or negative.
String bmiCategory(double bmi) {
  // TODO(lab): Exercise 3 — similar example: gradeLetter. A `switch`
  // expression with relational patterns (`< 18.5 => ...`) reads well; see
  // the notes, section "Control flow". Write your own boundary test first
  // (see the TODO in test/exercises/dart_basics_test.dart).
  throw UnimplementedError();
}

/// Returns true when [text] reads the same forwards and backwards,
/// ignoring case and any character that is not a letter or digit.
/// 'A man, a plan, a canal: Panama' → true.
bool isPalindrome(String text) {
  // TODO(lab): Exercise 4 — to keep only letters and digits, use
  // text.toLowerCase().replaceAll(RegExp('[^a-z0-9]'), '').
  // `[^a-z0-9]` means "any character that is not a lower-case letter or a
  // digit". Then compare the string with its reverse:
  // split('').reversed.join().
  throw UnimplementedError();
}

/// Counts how many times each letter a–z occurs in [text], ignoring case.
/// Spaces, digits and punctuation are not counted.
/// 'Hello, World!' → {'h': 1, 'e': 1, 'l': 3, 'o': 2, 'w': 1, 'r': 1, 'd': 1}
Map<String, int> letterCount(String text) {
  // TODO(lab): Exercise 5 — similar example: wordCount.
  throw UnimplementedError();
}

/// Converts a distance. [value] is in kilometres by default and the result
/// is in miles; pass `toKilometres: true` to convert miles to kilometres
/// instead. 1 km = 0.621371 miles. Round the result to one decimal place.
double convertDistance(double value, {bool toKilometres = false}) {
  // TODO(lab): Exercise 6 — similar example: convertTemperature.
  throw UnimplementedError();
}

/// Returns the first [count] Fibonacci numbers starting 0, 1, 1, 2, ...
/// count ≤ 0 → empty list.
List<int> fibonacci(int count) {
  // TODO(lab): Exercise 7
  throw UnimplementedError();
}

/// Summarises a value that may be null or of any type:
/// null → 'no value', true → 'yes', false → 'no',
/// a double → 'a decimal number', a String → '"hi" has 2 characters',
/// a Map → 'a map with 3 entries', anything else → 'unknown'.
String summarise(Object? value) {
  // TODO(lab): Exercise 8 — similar example: describe. Use a `switch`
  // with type patterns.
  throw UnimplementedError();
}
