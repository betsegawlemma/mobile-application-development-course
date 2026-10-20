import 'package:campus_companion/exercises/dart_classes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Student', () {
    test('fullName and toString', () {
      final s = Student(firstName: 'Abel', lastName: 'Tesfaye', id: 'UGR/1');
      expect(s.fullName, 'Abel Tesfaye');
      expect(s.toString(), 'Student(UGR/1, Abel Tesfaye)');
    });
    test('guest named constructor', () {
      final g = Student.guest();
      expect(g.fullName, 'Guest');
      expect(g.id, 'GUEST');
    });
  });

  group('Shape', () {
    test('area for each subtype', () {
      expect(area(const Circle(1)), closeTo(3.14159, 0.001));
      expect(area(const Rectangle(2, 3)), 6);
      expect(area(const Square(4)), 16);
    });
  });

  // Exercise 3 is an Extra task.
  group('Robot with mixins', () {
    test('greets and logs', () {
      final r = Robot('R2');
      expect(r.introduce(), 'Hello, I am R2');
      expect(r.logs, ['[Robot] Hello, I am R2']);
    });
  });

  group('Stack<T>', () {
    test('push, pop, peek', () {
      final s = Stack<int>();
      expect(s.isEmpty, isTrue);
      expect(s.peek(), isNull);
      s
        ..push(1)
        ..push(2);
      expect(s.length, 2);
      expect(s.peek(), 2);
      expect(s.pop(), 2);
      expect(s.pop(), 1);
      expect(() => s.pop(), throwsStateError);
    });
    test('is typed', () {
      final s = Stack<String>()..push('a');
      expect(s.pop(), 'a');
    });
  });

  // Exercise 5 is an Extra task.
  group('StringX', () {
    test('capitalize and titleCase', () {
      expect('flutter'.capitalize(), 'Flutter');
      expect(''.capitalize(), '');
      expect('hello big world'.titleCase(), 'Hello Big World');
    });
  });

  group('Wallet', () {
    test('deposit and withdraw', () {
      final w = Wallet(10)..deposit(5);
      w.withdraw(12);
      expect(w.balance, 3);
    });
    test('throws a custom exception when funds are insufficient', () {
      final w = Wallet(1);
      expect(
        () => w.withdraw(5),
        throwsA(isA<InsufficientFundsException>()),
      );
      expect(w.tryWithdraw(5), isFalse);
      expect(w.balance, 1);
    });
    test('rejects non-positive deposits', () {
      expect(() => Wallet().deposit(0), throwsArgumentError);
    });
  });

  group('Futures', () {
    test('fetchGreeting resolves', () async {
      expect(await fetchGreeting('Sara'), 'Hello, Sara');
    });
    test('fetchAllGreetings keeps order', () async {
      final all = await fetchAllGreetings(['A', 'B', 'C']);
      expect(all, ['Hello, A', 'Hello, B', 'Hello, C']);
    });
    test('fetchGreetingOrThrow throws for an empty name', () async {
      await expectLater(fetchGreetingOrThrow(''), throwsArgumentError);
    });
  });
}
