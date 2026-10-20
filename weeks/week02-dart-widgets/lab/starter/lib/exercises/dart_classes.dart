// Week 2 Dart exercises — classes, inheritance, sealed types, mixins,
// generics, extensions and async.
//
// Each section has a description of what the tests expect. Implement the
// missing pieces; run: flutter test test/exercises/dart_classes_test.dart
// The worked examples from the lecture are in lecture_examples.dart.
//
// ignore_for_file: unused_import
import 'dart:async';

// ---------------------------------------------------------------------------
// Exercise 1 — Student: named-parameter constructor (firstName, lastName,
// id), a named constructor Student.guest() ('Guest', '', 'GUEST'), a
// `fullName` getter ('First Last', or just first name when last is empty)
// and toString() → 'Student(<id>, <fullName>)'.
// ---------------------------------------------------------------------------

class Student {
  Student({required this.firstName, required this.lastName, required this.id});

  /// Named constructor for an anonymous visitor.
  // TODO(lab): use an initialiser list (`: firstName = 'Guest', ...`)
  Student.guest() : this(firstName: '?', lastName: '?', id: '?');

  final String firstName;
  final String lastName;
  final String id;

  String get fullName => throw UnimplementedError(); // TODO(lab)

  // TODO(lab): override toString
}

// ---------------------------------------------------------------------------
// Exercise 2 — Shapes: make Shape a *sealed* class; Circle(radius),
// Rectangle(width, height), Square(side) extends Rectangle. Implement
// area() with an exhaustive switch expression using object patterns.
// ---------------------------------------------------------------------------

abstract class Shape {
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

double area(Shape shape) {
  // TODO(lab)
  throw UnimplementedError();
}

// ---------------------------------------------------------------------------
// Exercise 3 (Extra task) — Mixins: `Logger` keeps a List<String> logs
// and has log(String) that adds '[$runtimeType] $message'. `Greeter`
// requires a `String get name` and provides greet() → 'Hello, I am $name'.
// Robot uses both; introduce() greets, logs the line and returns it.
// ---------------------------------------------------------------------------

// TODO(lab): mixin Logger { ... }
// TODO(lab): mixin Greeter { ... }

class Robot {
  Robot(this.name);
  final String name;

  List<String> get logs => throw UnimplementedError();
  String introduce() => throw UnimplementedError();
}

// ---------------------------------------------------------------------------
// Exercise 4 — Stack<T>: isEmpty, length, push(T), pop() (throws StateError
// when empty), peek() → T? (null when empty).
// ---------------------------------------------------------------------------

class Stack<T> {
  // TODO(lab)
  bool get isEmpty => throw UnimplementedError();
  int get length => throw UnimplementedError();
  void push(T item) => throw UnimplementedError();
  T pop() => throw UnimplementedError();
  T? peek() => throw UnimplementedError();
}

// ---------------------------------------------------------------------------
// Exercise 5 (Extra task) — Extension StringX on String: capitalize()
// ('flutter' → 'Flutter', '' → '') and titleCase() ('hello world' →
// 'Hello World').
// ---------------------------------------------------------------------------

extension StringX on String {
  String capitalize() => throw UnimplementedError(); // TODO(lab)
  String titleCase() => throw UnimplementedError(); // TODO(lab)
}

// ---------------------------------------------------------------------------
// Exercise 6 — Wallet with a custom exception. deposit(amount) throws
// ArgumentError for amount <= 0. withdraw(amount) throws
// InsufficientFundsException(requested, available) when amount > balance.
// tryWithdraw(amount) returns false instead of throwing that exception.
// ---------------------------------------------------------------------------

class InsufficientFundsException implements Exception {
  InsufficientFundsException(this.requested, this.available);
  final int requested;
  final int available;
}

class Wallet {
  Wallet([this._balance = 0]);
  int _balance;

  int get balance => _balance;

  void deposit(int amount) {
    // TODO(lab)
    _balance += amount;
  }

  void withdraw(int amount) {
    // TODO(lab)
    _balance -= amount;
  }

  bool tryWithdraw(int amount) => throw UnimplementedError(); // TODO(lab)
}

// ---------------------------------------------------------------------------
// Exercise 7 — Futures. fetchGreeting waits `delay` then returns
// 'Hello, $name'. fetchAllGreetings fetches all names concurrently
// (Future.wait) preserving order. fetchGreetingOrThrow throws ArgumentError
// for an empty name, otherwise behaves like fetchGreeting.
// ---------------------------------------------------------------------------

Future<String> fetchGreeting(String name,
    {Duration delay = const Duration(milliseconds: 10)}) async {
  // TODO(lab)
  throw UnimplementedError();
}

Future<List<String>> fetchAllGreetings(List<String> names) {
  // TODO(lab)
  throw UnimplementedError();
}

Future<String> fetchGreetingOrThrow(String name) async {
  // TODO(lab)
  throw UnimplementedError();
}
