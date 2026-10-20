# Week 2 quiz — self-check

Answer on paper, without running code and before you open the answers or
any tool. Then open each answer to check. Item 12 is marked as an
exam-style question: it has the form of Part B of the mid exam
(`syllabus/exams.md`).

**1.** What is the difference between a `StatefulWidget` and its `State`?
Which one is immutable?

<details><summary>Answer</summary>
The widget is an immutable configuration (constructor arguments). The
`State` object holds mutable memory and persists across rebuilds while the
element stays in the tree. Both `StatelessWidget` and `StatefulWidget`
classes are immutable; only `State` is mutable.
</details>

**2.** In which callback should you create a `TextEditingController`, and
where should you release it?

<details><summary>Answer</summary>
Create in `initState` (after `super.initState()`), release in `dispose`
(before `super.dispose()`).
</details>

**3.** A parent rebuilds and passes a `TickCounter` (from the lecture)
with a new `interval`. Which callbacks run on the child, and does
`initState` run again?

<details><summary>Answer</summary>
`didUpdateWidget` then `build`. `initState` does not run — same type and
key at the same position means the existing `State` is reused.
</details>

**4.** Find the error:
```dart
Future<void> _load() async {
  final data = await repository.fetch();
  setState(() => _data = data);
}
```

<details><summary>Answer</summary>
If the user leaves the screen during `await`, `setState` runs after
`dispose` and throws. Add `if (!mounted) return;` before `setState`.
</details>

**5.** Predict the output:
```dart
Future<void> main() async {
  print('a');
  final f = Future.delayed(const Duration(milliseconds: 1), () => 'b');
  print('c');
  print(await f);
}
```

<details><summary>Answer</summary>
`a`, `c`, `b`. Creating the future starts it; `main` continues until the
`await`.
</details>

**6.** What does making a class `sealed` give you that `abstract` does not?

<details><summary>Answer</summary>
Subtypes must be declared in the same library, so the compiler knows all of
them and can check that a `switch` is exhaustive. Add a subtype and every
non-exhaustive switch becomes a compile error.
</details>

**7.** Rewrite so the three calls run concurrently:
```dart
final a = await fetch('a');
final b = await fetch('b');
final c = await fetch('c');
```

<details><summary>Answer</summary>
```dart
final [a, b, c] = await Future.wait([fetch('a'), fetch('b'), fetch('c')]);
```
(`Future.wait` preserves order; the list pattern destructures the result.)
</details>

**8.** Why is `copyWith` needed if all fields of `Event` are `final`?

<details><summary>Answer</summary>
Because you cannot mutate the object, the only way to get a changed version
is to build a new one. `copyWith` builds it, copying every field you do not
override, so callers do not repeat all constructor arguments.
</details>

**9.** Find the error:
```dart
class Counter extends StatefulWidget {
  int count = 0;
  ...
}
```

<details><summary>Answer</summary>
Mutable field on a widget. Widgets are immutable (`@immutable` warns:
"This class inherits from a class marked as @immutable"); the count belongs
in the `State`.
</details>

**10.** `fetchForecast` (from the lecture) returns `Future<String>`. What
is the type of `cities.map(fetchForecast)`, and has any forecast been
requested after this line alone?

```dart
final cities = ['Adama', 'Gondar'];
final futures = cities.map(fetchForecast);
```

<details><summary>Answer</summary>
`Iterable<Future<String>>`. No forecast has been requested yet: `map` is
lazy, so `fetchForecast` is called only when something goes through the
iterable (for example `toList()`, a `for` loop, or `Future.wait`).
</details>

**11.** For each widget, choose `StatelessWidget` or `StatefulWidget` and
give one reason: (a) a card that shows an event's title; (b) a search box
that creates a `TextEditingController`; (c) a label that shows a count
which only its parent changes.

<details><summary>Answer</summary>
(a) Stateless: it shows only what the constructor gives it. (b) Stateful:
it creates a controller in `initState` and must dispose it in `dispose`,
and only a `State` has those callbacks. (c) Stateless: the value comes
from the parent; when the parent rebuilds with a new count, the label is
rebuilt with it. The state lives in the parent.
</details>

**12.** *(Exam-style question.)* Trace this code. `Assignment` is the
class from the lecture: `copyWith` returns a new object, `==` compares the
fields, and `isOverdue` is true when the assignment is not done and `now`
is after `due`. Write the three lines it prints.

```dart
final a = Assignment(id: '1', title: 'Lab', due: DateTime(2026, 10, 9));
final b = a.copyWith(done: true);
final c = b.copyWith(done: false);
print(a == c);
print(identical(a, c));
print(b.isOverdue(now: DateTime(2026, 10, 10)));
```

<details><summary>Answer</summary>
`true` (same field values), `false` (`c` is a different object from `a`;
`identical` checks whether two references are the same object), `false`
(`b` is done, so it is never overdue).
</details>

**13.** Find the error, then answer the second question.

```dart
mixin Describable {
  String get label;
  String describe() => 'This is $label';
}

class Fan with Describable {
  Fan(this.speed);
  final int speed;
}
```

What does `'Addis Ababa'.shorten(4)` return, with the `shorten` extension
from the lecture (`length <= max ? this : '${substring(0, max)}...'`)?

<details><summary>Answer</summary>
`Fan` uses `Describable` but does not provide `label`, which the mixin
requires: compile error ("Missing concrete implementation of 'getter
Describable.label'"). Add for example `@override String get label =>
'fan at speed $speed';`. The extension call returns `'Addi...'`.
</details>

**14.** Put these lines in order to make a correct `dispose` for a `State`
that started a timer in `initState`. One line is not needed.

```text
A   super.dispose();
B   }
C   _timer?.cancel();
D   @override
E   void dispose() {
F   super.initState();
```

<details><summary>Answer</summary>
D, E, C, A, B. Line F is not needed. Release your own objects first and
call `super.dispose()` last.
</details>

## Questions from earlier weeks

**15.** (From week 1) Predict the output:

```dart
final names = ['a', 'b'];
final upper = names.map((n) => n.toUpperCase());
print(upper);
```

<details><summary>Answer</summary>
`(A, B)`. `map` returns a lazy `Iterable`, whose `toString` uses round
brackets. Call `.toList()` to get the `List` `[A, B]`.
</details>

**16.** (From week 1) Find the error:

```dart
final total = 0;
total += 5;
```

<details><summary>Answer</summary>
`total` is `final`, so it can be set only once; `total += 5` is a compile
error. Use `var total = 0;` when the value must change.
</details>
