---
marp: true
theme: course
title: "Week 2 — Dart II and the widget lifecycle"
paginate: true
footer: "Mobile Applications Development · Week 2 · Betsegaw Lemma · AAU"
---

<!-- _class: lead -->
<!-- _paginate: false -->

# Dart II and the widget lifecycle

Week 2 · Mobile Applications Development
B.Sc. Computer Science · Addis Ababa University

---

## Lecture topics

1. Classes in Dart
2. Sealed classes, mixins, generics, extensions
3. Async: Futures
4. The StatefulWidget lifecycle
5. Lab preview

---

<!-- _class: lead -->

# 1 · Classes in Dart

---

## A typical Dart class

```dart
// lab/solution/lib/exercises/lecture_examples.dart
class Course {
  Course({required this.code, required this.title, required this.credits});

  Course.seminar(this.code)       // named constructor
      : title = 'Seminar',        // initialiser list
        credits = 1;

  final String code;
  final String title;
  final int credits;

  String get label => '$code $title';

  @override
  String toString() => 'Course($code, $credits credits)';
}
```

The lab asks for a similar class, `Student` — not this one.

---

## Things to notice

- `this.code` in the parameter list **assigns the field** — no `this.x = x` body
- `required` named parameters: how every widget takes its arguments
- No `public` / `private`: a leading `_` is private **to the file**
- Getters look like fields: `course.label`, not `getLabel()`
- `@override` is expected; the analyser warns without it

---

## Immutable models

```dart
// lab/solution/lib/exercises/lecture_examples.dart
@immutable
class Assignment {
  const Assignment({required this.id, required this.title,
                    required this.due, this.done = false});

  final String id;  final String title;  final DateTime due;  final bool done;

  Assignment copyWith({String? id, String? title, DateTime? due, bool? done}) {
    return Assignment(id: id ?? this.id, title: title ?? this.title,
                      due: due ?? this.due, done: done ?? this.done);
  }
  // ==, hashCode (Object.hash) and toString: see the file
}
```

All `final` · `const` constructor · `copyWith` for changes · value `==`

---

## Pass the current time as a parameter

```dart
// lab/solution/lib/exercises/lecture_examples.dart
bool isOverdue({DateTime? now}) =>
    !done && (now ?? DateTime.now()).isAfter(due);
```

```dart
// lab/solution/test/exercises/lecture_examples_test.dart
expect(a.isOverdue(now: DateTime(2026, 10, 10)), isTrue);
expect(a.isOverdue(now: DateTime(2026, 10, 8)), isFalse);
```

A test that depends on the real time will fail one day.

---

## Enhanced enums

```dart
// lab/solution/lib/models/event.dart
enum Venue {
  mainCampus('Main campus', 'Sidist Kilo'),
  scienceFaculty('Science faculty', 'Arat Kilo'),
  technology('Technology faculty', 'Amist Kilo'),
  online('Online', 'Zoom / Teams');

  const Venue(this.label, this.location);
  final String label;
  final String location;
}
// Venue.online.label → 'Online'
```

---

<!-- _class: pause -->

## What prints?

```dart
final a = Assignment(id: '1', title: 'A', due: DateTime(2026));
final b = a.copyWith(title: 'B');
print(a.title);
print(a == b);
print(a == a.copyWith());
```

---

<!-- _class: lead -->

# 2 · Sealed classes, mixins, generics, extensions

---

## Inheritance — the familiar

```dart
// lab/starter/lib/exercises/dart_classes.dart
class Rectangle extends Shape {
  const Rectangle(this.width, this.height);
  final double width;
  final double height;
}

class Square extends Rectangle {
  const Square(double side) : super(side, side);
}
```

Single inheritance · `super(...)` · `abstract class` cannot be instantiated

---

## Sealed classes: the compiler knows every subtype

```dart
// lab/solution/lib/exercises/lecture_examples.dart
sealed class Payment { const Payment(); }
class CashPayment extends Payment { … }
class CardPayment extends Payment { … }

double totalCharged(Payment payment) => switch (payment) {
      CashPayment(:final amount) => amount,
      CardPayment(:final amount, :final feePercent) =>
        amount + amount * feePercent / 100,
    };
```

Add a `MobileMoneyPayment` and leave it out of the switch → **compile error**, not a runtime error.

---

## Mixins: reuse without inheritance

```dart
// lab/solution/lib/exercises/lecture_examples.dart
mixin Describable {
  String get label;                      // the class must provide this
  String describe() => 'This is $label';
}

class Lamp with Describable {
  Lamp(this.label);

  @override
  final String label;
}
```

A class can use several: `class Robot with Logger, Greeter`.
Flutter: `SingleTickerProviderStateMixin`, `WidgetsBindingObserver`

---

## Generics

```dart
// lab/solution/lib/exercises/lecture_examples.dart
class Pair<A, B> {
  const Pair(this.first, this.second);
  final A first;
  final B second;

  Pair<B, A> swap() => Pair(second, first);
}

T firstOr<T>(List<T> items, T fallback) =>
    items.isEmpty ? fallback : items.first;
```

`Pair<String, int>('age', '21')` → compile error. You will write few generic classes but read many:
`List<Event>`, `Future<String>`, `State<HomeScreen>`.

---

## Extension methods

```dart
// lab/solution/lib/exercises/lecture_examples.dart
extension Shorten on String {
  String shorten(int max) => length <= max ? this : '${substring(0, max)}...';
}

'Mobile Applications'.shorten(6);   // 'Mobile...'
```

Add methods to types you do not own, for example a `context.theme` shortcut.

---

## Exceptions

```dart
// lab/solution/lib/exercises/lecture_examples.dart
class NotEnoughCopiesException implements Exception {
  NotEnoughCopiesException(this.requested, this.available);
  final int requested;
  final int available;
}

bool tryBorrow(int count) {
  try {
    borrow(count);
    return true;
  } on NotEnoughCopiesException {   // catch a specific type
    return false;
  }                                 // anything else reaches the caller
}
```

`throw` any object · `on Type catch (e, stack)` · `finally` · `rethrow`

---

<!-- _class: lead -->

# 3 · Async: Futures

---

## One UI thread

- Your app paints 60–120 frames per second on **one** thread
- Anything slow on it → frozen screen → "App isn't responding"
- Network, disk, database: all slow
- Dart's answer: `Future` with `async` / `await`
- A sequence of values over time is a `Stream`: week 10 starts with streams

---

## Futures

```dart
// lab/solution/lib/exercises/lecture_examples.dart
Future<String> fetchForecast(String city,
    {Duration delay = const Duration(milliseconds: 10)}) async {
  await Future<void>.delayed(delay);
  return '$city: sunny';
}
```

- `async` function ⇒ returns a `Future`, always
- `await` pauses the function, **not the thread**
- an exception inside ⇒ a failed future ⇒ `await` throws it again ⇒ `try`/`catch` works

---

## One after another, or at the same time

```dart
// lab/solution/lib/exercises/lecture_examples.dart
Future<List<String>> fetchForecastsInOrder(List<String> cities) async {
  final results = <String>[];
  for (final city in cities) {
    results.add(await fetchForecast(city)); // one after another
  }
  return results;
}

Future<List<String>> fetchTwoForecasts(String first, String second) {
  // both at the same time; the results keep the order of the list
  return Future.wait([fetchForecast(first), fetchForecast(second)]);
}
```

---

<!-- _class: pause -->

## Order of output?

```dart
Future<void> main() async {
  print('1');
  final f = fetchForecast('Adama');   // 10 ms
  print('2');
  print(await f);
  print('3');
}
```

---

## Isolates (optional / advanced)

- `async`/`await` does **not** move work to another core — it only avoids blocking while *waiting*
- CPU-heavy work (parse a 10 MB JSON, resize an image) still freezes the UI
- `await Isolate.run(() => heavyWork())` runs it on another core

You will rarely need this in the course, but you should know that it exists.

---

<!-- _class: lead -->

# 4 · The StatefulWidget lifecycle

---

## Stateless vs stateful

| | StatelessWidget | StatefulWidget |
|---|---|---|
| `build` depends on | constructor args only | args **and** a `State` object |
| Mutable memory | none | in `State` |
| Rebuild trigger | parent rebuilds | parent rebuilds **or** `setState()` |
| Use | by default | counters, forms, toggles, animations |

Both widget classes are immutable. The **State** is the memory.

To choose: does the widget own a value that changes while it is on screen, or a controller or timer? → stateful.

---

## Three trees

| Tree | Lives | Job |
|---|---|---|
| **Widget** | microseconds | immutable configuration |
| **Element** | as long as it is on screen | identity, **holds the `State`**, compares old and new widgets |
| **Render** | as long as it is on screen | layout and paint |

Rebuilding widgets is cheap **because** elements and render objects persist.

---

## The lifecycle

```
createState ──► initState ──► didChangeDependencies ──► build ◄──┐
                                                          │       │ setState()
                       parent rebuilds, same type & key   │       │
                     ┌────────────────────────────────────┘       │
                     ▼                                            │
              didUpdateWidget ────────────────────────────────────┘
                     │
        removed from tree
                     ▼
                  dispose
```

---

## Each callback, one line

| Callback | Use it for |
|---|---|
| `initState` | subscriptions, controllers; `super.initState()` **first** |
| `didChangeDependencies` | work that needs `context` (Theme, MediaQuery) |
| `build` | describe UI — pure, fast, may run 60×/s |
| `didUpdateWidget` | react to new configuration from the parent |
| `setState` | mutate **inside** the callback → rebuild next frame |
| `dispose` | undo `initState`; `super.dispose()` **last** |

---

## A timer: initState, didUpdateWidget, dispose

```dart
// lab/solution/lib/exercises/lecture_widgets.dart
class _TickCounterState extends State<TickCounter> {
  Timer? _timer;
  int _ticks = 0;

  @override
  void initState() { super.initState(); _startTimer(); }

  @override
  void didUpdateWidget(TickCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.interval != widget.interval) { _timer?.cancel(); _startTimer(); }
  }

  @override
  Widget build(BuildContext context) => Text('Ticks: $_ticks');

  @override
  void dispose() { _timer?.cancel(); super.dispose(); }
}
```

---

## setState

```dart
// lab/solution/lib/exercises/lecture_widgets.dart
class _VoteCounterState extends State<VoteCounter> {
  int _votes = 0;
  bool _showDetails = false;

  void _vote() {
    // Change the field inside setState, so Flutter calls build() again.
    setState(() => _votes++);
  }
  …
  ElevatedButton(onPressed: _vote, child: const Text('Vote')),
```

`_votes++` **without** `setState`: value changes, screen does not.

---

## Add and remove with collection-if

```dart
// lab/solution/lib/exercises/lecture_widgets.dart
SwitchListTile(
  title: const Text('Show details'),
  value: _showDetails,
  onChanged: (value) => setState(() => _showDetails = value),
),
// Collection-if: the widget exists only while the switch is on.
if (_showDetails) Text('Last change: vote number $_votes'),
```

- a **stateful** widget that appears → `createState`, `initState`, `didChangeDependencies`, `build`
- its parent rebuilds → `didUpdateWidget`, `build` (State kept)
- it disappears → `dispose`

---

<!-- _class: pause -->

## Predict the callbacks

A parent shows `TickCounter(interval: Duration(seconds: 1))`.
It rebuilds with `Duration(seconds: 2)`, then removes the `TickCounter`.

Which methods of `_TickCounterState` run, in order? What happens to `_ticks`?

---

## Same type at the same place ⇒ same State

```dart
// lab/solution/test/exercises/lecture_widgets_test.dart
await tester.pump(second);
await tester.pump(second);
expect(find.text('Ticks: 2'), findsOneWidget);

// Same type at the same place: didUpdateWidget runs, the count stays.
await tester.pumpWidget(
  const MaterialApp(home: TickCounter(interval: Duration(seconds: 2))),
);
expect(find.text('Ticks: 2'), findsOneWidget);
```

Different type at that place → old State disposed, new one created.
Lists that reorder need **keys** to keep the right State: week 7.

---

## Two rules that prevent most errors

1. An async result can arrive **after the user left the screen**:
   after `await`, check `if (!mounted) return;` before `setState`.
2. Everything you create in `initState` (a controller, a timer, a
   subscription) you release in `dispose`, before `super.dispose()`.

Test for rule 2: delete `_timer?.cancel()` in `TickCounter` and run its test.

---

## Testing a stateful widget

```dart
// lab/solution/test/exercises/lecture_widgets_test.dart
await tester.pumpWidget(
  const MaterialApp(
    home: Scaffold(body: VoteCounter(question: 'Lab on Friday?')),
  ),
);
expect(find.text('Votes: 0'), findsOneWidget);

await tester.tap(find.text('Vote'));
await tester.pump(); // one frame: build() runs after setState
expect(find.text('Votes: 1'), findsOneWidget);
```

`pump()` = one frame. Write the test **first**, see it fail, then write the code. Week 6 covers the rest.

---

## Lab topics

1. `Event` model — read `Venue`, write `copyWith`, `==`, `isUpcoming` (tests in `test/models`)
2. `HomeScreen` as a stateful check-in counter — **you write one widget test first**
3. `LifecycleLogger` — **predict** the console output in a table, then run
4. Dart II exercises — `test/exercises` (Exercises 3 and 5 are extra tasks)
5. Extra task: simulated loading with `Future.delayed`

AI-use level: 0 for the exercises, 0–1 elsewhere. Two TA checkpoints, then an exit task on paper. Groups of four by the end of the lab.

---

## Before the next lecture

- Read *Layouts in Flutter* and *Understanding constraints*
  (docs.flutter.dev/ui/layout)
- The project proposal is due at the **end of week 3** — start writing it
  (`project/proposal-template.md`)

---

<!-- _class: lead -->
<!-- _paginate: false -->

# Questions?

Notes, lab and quiz: github.com/betsegawlemma/mobile-application-development-course
