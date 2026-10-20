// Week 2 Dart exercises — classes, inheritance, sealed types, mixins,
// generics, extensions and async. Reference solution.
// Run the tests with: flutter test test/exercises

import 'dart:async';

// ---------------------------------------------------------------------------
// Exercise 1 — a class with constructors, a getter and toString
// ---------------------------------------------------------------------------

class Student {
  Student({required this.firstName, required this.lastName, required this.id});

  /// Named constructor for an anonymous visitor.
  Student.guest()
      : firstName = 'Guest',
        lastName = '',
        id = 'GUEST';

  final String firstName;
  final String lastName;
  final String id;

  String get fullName =>
      lastName.isEmpty ? firstName : '$firstName $lastName';

  @override
  String toString() => 'Student($id, $fullName)';
}

// ---------------------------------------------------------------------------
// Exercise 2 — sealed class hierarchy with exhaustive pattern matching
// ---------------------------------------------------------------------------

sealed class Shape {
  const Shape();
}

class Circle extends Shape {
  const Circle(this.radius);
  final double radius;
}

class Rectangle extends Shape {
  const Rectangle(this.width, this.height);
  final double width;
  final double height;
}

class Square extends Rectangle {
  const Square(double side) : super(side, side);
}

/// Area of any shape. Because [Shape] is sealed, the switch must handle
/// every subtype or the compiler complains.
double area(Shape shape) => switch (shape) {
      Circle(:final radius) => 3.141592653589793 * radius * radius,
      Rectangle(:final width, :final height) => width * height,
    };

// ---------------------------------------------------------------------------
// Exercise 3 (Extra task) — mixins
// ---------------------------------------------------------------------------

mixin Logger {
  final List<String> logs = [];

  void log(String message) => logs.add('[$runtimeType] $message');
}

mixin Greeter {
  String get name;

  String greet() => 'Hello, I am $name';
}

class Robot with Logger, Greeter {
  Robot(this.name);

  @override
  final String name;

  String introduce() {
    final line = greet();
    log(line);
    return line;
  }
}

// ---------------------------------------------------------------------------
// Exercise 4 — a generic class
// ---------------------------------------------------------------------------

class Stack<T> {
  final List<T> _items = [];

  bool get isEmpty => _items.isEmpty;
  int get length => _items.length;

  void push(T item) => _items.add(item);

  /// Removes and returns the top item. Throws [StateError] when empty.
  T pop() {
    if (_items.isEmpty) throw StateError('pop on empty stack');
    return _items.removeLast();
  }

  T? peek() => _items.isEmpty ? null : _items.last;
}

// ---------------------------------------------------------------------------
// Exercise 5 (Extra task) — extension methods
// ---------------------------------------------------------------------------

extension StringX on String {
  /// 'flutter' → 'Flutter'; '' → ''
  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// 'hello world' → 'Hello World'
  String titleCase() => split(' ').map((w) => w.capitalize()).join(' ');
}

// ---------------------------------------------------------------------------
// Exercise 6 — custom exceptions and error handling
// ---------------------------------------------------------------------------

class InsufficientFundsException implements Exception {
  InsufficientFundsException(this.requested, this.available);
  final int requested;
  final int available;

  @override
  String toString() =>
      'InsufficientFundsException: requested $requested, have $available';
}

class Wallet {
  Wallet([this._balance = 0]);
  int _balance;

  int get balance => _balance;

  void deposit(int amount) {
    if (amount <= 0) throw ArgumentError.value(amount, 'amount', 'must be > 0');
    _balance += amount;
  }

  void withdraw(int amount) {
    if (amount > _balance) {
      throw InsufficientFundsException(amount, _balance);
    }
    _balance -= amount;
  }

  /// Tries to withdraw; returns true on success, false when funds are
  /// insufficient. Any other error is rethrown.
  bool tryWithdraw(int amount) {
    try {
      withdraw(amount);
      return true;
    } on InsufficientFundsException {
      return false;
    }
  }
}

// ---------------------------------------------------------------------------
// Exercise 7 — Futures and async/await
// ---------------------------------------------------------------------------

/// Simulates a network call: resolves with a greeting after [delay].
Future<String> fetchGreeting(String name,
    {Duration delay = const Duration(milliseconds: 10)}) async {
  await Future<void>.delayed(delay);
  return 'Hello, $name';
}

/// Fetches greetings for everyone *concurrently* and returns them in the
/// same order as [names].
Future<List<String>> fetchAllGreetings(List<String> names) {
  return Future.wait(names.map(fetchGreeting));
}

/// Like [fetchGreeting] but fails for an empty name. Callers await it in a
/// try/catch.
Future<String> fetchGreetingOrThrow(String name) async {
  if (name.isEmpty) throw ArgumentError('name must not be empty');
  return fetchGreeting(name);
}
