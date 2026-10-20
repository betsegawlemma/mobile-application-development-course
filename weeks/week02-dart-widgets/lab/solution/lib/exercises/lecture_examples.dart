// Week 2 lecture examples — the worked examples shown in the notes and
// slides. Read them; do not copy them into the exercises. Each lab exercise
// in dart_classes.dart (and the Event model) is similar to one example
// here, but not the same.
//
// The tests in test/exercises/lecture_examples_test.dart show what each
// example returns.

import 'package:flutter/foundation.dart';

// ---------------------------------------------------------------------------
// Classes: constructors, an initialiser list, getters, toString
// ---------------------------------------------------------------------------

class Course {
  Course({required this.code, required this.title, required this.credits});

  /// Named constructor for a one-credit seminar. The part after the colon
  /// is the initialiser list: it sets final fields before the body runs.
  Course.seminar(this.code)
      : title = 'Seminar',
        credits = 1;

  final String code;
  final String title;
  final int credits;

  /// A getter: callers write `course.label`, without brackets.
  String get label => '$code $title';

  bool get isHeavy => credits >= 5;

  @override
  String toString() => 'Course($code, $credits credits)';
}

// ---------------------------------------------------------------------------
// An immutable model class: final fields, const constructor, copyWith,
// value equality, and the current time passed in as a parameter
// ---------------------------------------------------------------------------

@immutable
class Assignment {
  const Assignment({
    required this.id,
    required this.title,
    required this.due,
    this.done = false,
  });

  final String id;
  final String title;
  final DateTime due;
  final bool done;

  /// True when the assignment is not done and [now] is after the due date.
  /// [now] defaults to the real time; a test passes a fixed time instead.
  bool isOverdue({DateTime? now}) =>
      !done && (now ?? DateTime.now()).isAfter(due);

  Assignment copyWith({String? id, String? title, DateTime? due, bool? done}) {
    return Assignment(
      id: id ?? this.id,
      title: title ?? this.title,
      due: due ?? this.due,
      done: done ?? this.done,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is Assignment &&
      other.id == id &&
      other.title == title &&
      other.due == due &&
      other.done == done;

  @override
  int get hashCode => Object.hash(id, title, due, done);

  @override
  String toString() => 'Assignment($id, $title, done: $done)';
}

// ---------------------------------------------------------------------------
// A sealed class and an exhaustive switch with object patterns
// ---------------------------------------------------------------------------

sealed class Payment {
  const Payment();
}

class CashPayment extends Payment {
  const CashPayment(this.amount);
  final double amount;
}

class CardPayment extends Payment {
  const CardPayment(this.amount, this.feePercent);
  final double amount;
  final double feePercent;
}

/// What the customer pays in total. Because [Payment] is sealed, the
/// compiler checks that every subtype has a case.
double totalCharged(Payment payment) => switch (payment) {
      CashPayment(:final amount) => amount,
      CardPayment(:final amount, :final feePercent) =>
        amount + amount * feePercent / 100,
    };

// ---------------------------------------------------------------------------
// A mixin
// ---------------------------------------------------------------------------

mixin Describable {
  /// The class that uses this mixin must provide [label].
  String get label;

  String describe() => 'This is $label';
}

class Lamp with Describable {
  Lamp(this.label);

  @override
  final String label;
}

// ---------------------------------------------------------------------------
// Generics: a generic class and a generic function
// ---------------------------------------------------------------------------

class Pair<A, B> {
  const Pair(this.first, this.second);
  final A first;
  final B second;

  Pair<B, A> swap() => Pair(second, first);
}

/// The first item of [items], or [fallback] when the list is empty.
T firstOr<T>(List<T> items, T fallback) =>
    items.isEmpty ? fallback : items.first;

// ---------------------------------------------------------------------------
// An extension method
// ---------------------------------------------------------------------------

extension Shorten on String {
  /// 'Mobile Applications' with max 6 → 'Mobile...'; short text unchanged.
  String shorten(int max) => length <= max ? this : '${substring(0, max)}...';
}

// ---------------------------------------------------------------------------
// A custom exception, thrown and caught
// ---------------------------------------------------------------------------

class NotEnoughCopiesException implements Exception {
  NotEnoughCopiesException(this.requested, this.available);
  final int requested;
  final int available;

  @override
  String toString() =>
      'NotEnoughCopiesException: requested $requested, have $available';
}

class BookShelf {
  BookShelf(this._copies);
  int _copies;

  int get copies => _copies;

  void borrow(int count) {
    if (count > _copies) throw NotEnoughCopiesException(count, _copies);
    _copies -= count;
  }

  /// Returns false instead of throwing when there are not enough copies.
  /// Any other error still reaches the caller.
  bool tryBorrow(int count) {
    try {
      borrow(count);
      return true;
    } on NotEnoughCopiesException {
      return false;
    }
  }
}

// ---------------------------------------------------------------------------
// Futures: async/await, one after another, and two at the same time
// ---------------------------------------------------------------------------

/// Simulates a slow network call for a weather forecast.
Future<String> fetchForecast(String city,
    {Duration delay = const Duration(milliseconds: 10)}) async {
  await Future<void>.delayed(delay);
  return '$city: sunny';
}

/// Fetches the forecasts one after another: the total time is the sum of
/// the delays.
Future<List<String>> fetchForecastsInOrder(List<String> cities) async {
  final results = <String>[];
  for (final city in cities) {
    results.add(await fetchForecast(city)); // one after another
  }
  return results;
}

/// Fetches two forecasts at the same time with Future.wait: the total time
/// is the longest single delay. The results keep the order of the list.
Future<List<String>> fetchTwoForecasts(String first, String second) {
  // both at the same time; the results keep the order of the list
  return Future.wait([fetchForecast(first), fetchForecast(second)]);
}
