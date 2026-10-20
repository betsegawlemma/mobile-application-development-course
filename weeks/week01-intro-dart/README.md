# Week 1 — Mobile landscape, Flutter, Dart I

**Outline chapters:** 1 (Introducing Flutter), 2 (Creating a Hello World app),
3 (Learning Dart basics — first half).
**Slides:** https://betsegawlemma.github.io/mobile-application-development-course/week01/
**Lab:** [lab/README.md](lab/README.md) · **Quiz:** [quiz.md](quiz.md)

## Learning outcomes

By the end of this week you can:

1. **Compare** native, web and cross-platform approaches to mobile
   development and **explain** where Flutter sits and why.
2. **Describe** a Flutter UI as a tree of widgets, **build** a small app
   shell from `MaterialApp`, `Scaffold` and `Text`, and **explain** what hot
   reload does and does not do.
3. **Install** Flutter 3.47.7, verify it with `flutter doctor`, and run an
   app on Chrome or an emulator.
4. **Write** Dart functions using variables, operators, control flow,
   collections and null safety, **write** a unit test before the code, and
   **run** unit tests against your functions.
5. **Check** an assistant's answer by predicting, running and testing it,
   and **decide** when using an assistant would replace the practice a
   task is meant to give you.

## Before the lecture

- Read *Introduction to Dart* up to "Classes":
  https://dart.dev/language
- Skim *Flutter architectural overview*, sections "Architectural layers" and
  "Reactive user interfaces":
  https://docs.flutter.dev/resources/architectural-overview
- Start the Flutter installation (week 1 lab, Task 1). The download is
  large; the lab goes more smoothly if it is already installed.

---

## 1. Why mobile, and why Flutter

### Why this matters
There are more smartphones than desktop computers, and for a large part of
the world — including most of Ethiopia — the phone is the only computer people own.
Any service you build for people will be used mostly on a phone. Mobile
development is therefore the normal case, not a special case.

### Three ways to build a mobile app

| Approach | Examples | Pros | Cons |
|---|---|---|---|
| **Native** | Kotlin/Jetpack Compose (Android), Swift/SwiftUI (iOS) | Full platform access, best performance, platform look and feel | Two code bases, two teams, two release cycles |
| **Web / hybrid** | PWA, Ionic/Capacitor | One web code base | WebView performance, limited device access, non-native feel |
| **Cross-platform compiled** | **Flutter**, React Native, .NET MAUI, Kotlin Multiplatform | One code base, near-native performance, shared UI | Extra abstraction layer, depends on the framework's release cadence |

Flutter is Google's open-source UI toolkit. It compiles Dart to native ARM
code (and to JavaScript/WebAssembly for the web), draws every pixel itself
with its own rendering engine (Impeller), and targets Android, iOS, web,
Windows, macOS and Linux from one code base.

**Why Flutter for this course:**
- One language (Dart) and one code base cover Android and iOS — what you
  learn applies to both.
- It draws its own widgets, so your app looks identical on every device,
  independent of the manufacturer's user-interface changes.
- Hot reload shows a code change in the running app in about one second.
- Large industry adoption: Google Pay, BMW, Toyota, Alibaba, eBay Motors;
  in Ethiopia, Flutter is common in fintech and e-commerce apps.

> **Industry note.** Job advertisements rarely ask for "Flutter" alone.
> They ask for Flutter *plus* state management (Riverpod or BLoC), testing,
> REST/Firebase integration and CI/CD. This course covers all of those,
> not just widgets.

### Try it
Open the Play Store or App Store on your phone and find three apps you use
daily. For each, guess: native or cross-platform? (Apps whose user
interface is identical on Android and iOS are often Flutter or React Native.)

---

## 2. How Flutter draws pixels

### Why this matters
In Flutter you never draw a button or move a label yourself. You
**describe** the screen, and Flutter draws it. Understanding what that
description is makes every later week easier.

### Everything is a widget
A Flutter UI is a **tree of widgets**. A widget is an immutable *description*
of part of the UI: "a column containing a text and a button". `Text`,
`Padding`, `Center`, `Scaffold`, even your whole app, are widgets.

```dart
// weeks/week01-intro-dart/lab/starter/lib/exercises/lecture_widget_example.dart
class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bus Timetable')),
      body: const Center(
        child: Text('Next bus to Sidist Kilo: 08:15'),
      ),
    );
  }
}
```

`build()` returns the widget subtree that *this* widget represents. Flutter
calls it whenever this part of the UI needs describing again.

Flutter turns this description into pixels on the screen. Week 2
explains how it does that (the widget, element and render trees), when the
lifecycle of a `StatefulWidget` makes it necessary to know.

### StatelessWidget and StatefulWidget — first look
- `StatelessWidget`: its output depends only on its constructor arguments.
  `TimetableScreen` above is stateless.
- `StatefulWidget`: has a companion `State` object that survives rebuilds
  and can call `setState()` to request a rebuild. Week 2 covers the
  lifecycle in detail.

### Hot reload vs hot restart
- **Hot reload** (`r`) injects your changed code into the running Dart VM
  and rebuilds the widget tree. State is preserved. It cannot apply changes
  to `main()`, global initialisers, or enum/class *shape* changes.
- **Hot restart** (`R`) restarts the app from `main()` in ~2 s. State is lost.
- A full rebuild is needed only for native code and dependency changes.

### Try it
In the lab, change the welcome text while the app is running and press `r`.
Then change something in `main()` and press `r` again — notice it has no
effect until `R`.

---

## 3. Dart, part I

### Why Dart?
Flutter needs a language that can (a) compile ahead-of-time to fast native
code for release, (b) run in a VM with hot reload during development, and
(c) express UI trees readably. Dart does all three. It is a typed,
object-oriented language that is similar to Java, C#,
Kotlin, TypeScript or Swift.

### Comments and `main`
```dart
// Single-line comment.
/* Block comment. */
/// Documentation comment — shows up in IDE tooltips. Use these on public APIs.
void main() {
  print('Hello, Dart!'); // in Flutter apps prefer debugPrint or a logger
}
```

### Variables and types
Dart is **statically typed** with **type inference**.

```dart
var city = 'Addis Ababa';   // inferred String; cannot later hold an int
final year = 2026;          // set once at runtime
const pi = 3.14159;         // compile-time constant
String name = 'Betsegaw';   // explicit type
int? maybeAge;              // nullable: may hold null
```

Prefer `final` for anything you do not reassign. Use `const` for values known
at compile time — in Flutter, `const` widgets are never rebuilt, which is a
performance improvement at no cost (the lint `prefer_const_constructors`
reminds you).

Built-in types you need now: `int`, `double` (both are `num`), `String`,
`bool`, `List`, `Set` and `Map`. Everything is an object; there are no
primitives.

> **Optional / Advanced.** You will not need these in the first weeks:
> - `late String token;` — a variable that you promise to set before its
>   first use; reading it earlier throws an error.
> - Records, such as `(int, String)`, group a few values without a class.
> - `Runes` (Unicode code points) and `Symbol` (names used by reflection)
>   are rarely used in apps.

### Null safety
A variable cannot hold `null` unless its type ends in `?`. The compiler
tracks this, so a `NullPointerException` cannot happen unless you
force it with `!`.

```dart
String? nickname;                 // null by default
print(nickname?.length);          // null-aware access → null
print(nickname ?? 'no nickname'); // default value
nickname ??= 'Bet';               // assign only if null
// nickname!.length              // "I promise it's not null" — avoid; crashes if wrong
```

### Operators worth knowing
Arithmetic (`+ - * / ~/ %`), comparison, logical (`&& || !`), type test
(`is`, `is!`, `as`), spread (`...` and `...?`) in collection literals, and
the conditional `condition ? a : b`.

```dart
final list = [1, 2, ...[3, 4]];          // [1, 2, 3, 4]
```

> **Optional / Advanced.** The cascade operator (`..`) calls several
> methods on the same object:
> `StringBuffer()..write('Hello')..write(', cascade')`.

### Control flow
`if/else`, `for`, `for-in`, `while`, `do-while`, `break`, `continue` work as
in Java or C. Dart 3 added **switch expressions** and **patterns**:

```dart
// weeks/week01-intro-dart/lab/starter/lib/exercises/lecture_examples.dart
String gradeLetter(double score) {
  if (score < 0 || score > 100) {
    throw ArgumentError.value(score, 'score', 'must be between 0 and 100');
  }
  return switch (score) {
    >= 90 => 'A',
    >= 80 => 'B',
    >= 70 => 'C',
    >= 60 => 'D',
    _ => 'F',
  };
}
```

Collection `if` and `for` are useful in widget lists:

```dart
final items = [
  'Home',
  if (isLoggedIn) 'Profile',
  for (final e in extras) e.toUpperCase(),
];
```

### Functions
```dart
// weeks/week01-intro-dart/lab/starter/lib/exercises/lecture_examples.dart
// (add and greet are short examples without a file)
int add(int a, int b) => a + b;                     // arrow body

double convertTemperature(double value, {bool toCelsius = false}) {
  final result = toCelsius ? (value - 32) * 5 / 9 : value * 9 / 5 + 32;
  return (result * 10).roundToDouble() / 10;
}
// call: convertTemperature(37)  or  convertTemperature(98.6, toCelsius: true)

String greet(String name, [String greeting = 'Hello']) => '$greeting, $name';
```

- `{named}` parameters are how Flutter widgets take their arguments —
  `Text('hi', style: ...)`. Mark them `required` when there is no default.
- `[optional positional]` parameters are rarer.
- Functions are values: you can pass `(n) => n.isEven` to `where`.

### Collections
```dart
// weeks/week01-intro-dart/lab/starter/lib/exercises/lecture_examples.dart
int sumOfEvens(List<int> numbers) {
  return numbers.where((n) => n.isEven).fold(0, (sum, n) => sum + n);
}

Map<String, int> wordCount(String sentence) {
  final counts = <String, int>{};
  for (final word in sentence.toLowerCase().split(RegExp(r'\s+'))) {
    if (word.isEmpty) continue;
    counts.update(word, (n) => n + 1, ifAbsent: () => 1);
  }
  return counts;
}
```

`List` is ordered, `Set` is unique-unordered, `Map` is key → value. The
iterable methods `map`, `where`, `fold`, `any`, `every`, `firstWhere`,
`toList` cover most needs. Remember `where`/`map` are *lazy*; call
`.toList()` to compute the result into a `List`.

### Type checks with patterns
```dart
// weeks/week01-intro-dart/lab/starter/lib/exercises/lecture_examples.dart
String describe(Object? value) {
  return switch (value) {
    null => 'nothing',
    final int n => 'the integer $n',
    final String s => 'the text "$s"',
    final List<Object?> items => 'a list of ${items.length} items',
    _ => 'something else',
  };
}
```

### Worked examples and lab exercises
The functions in this section are **worked examples**. They are in
`lab/starter/lib/exercises/lecture_examples.dart`, with tests that show
what they return. The lab exercises are similar but not the same: the
notes show `gradeLetter`, the lab asks for `bmiCategory`; the notes show
`wordCount`, the lab asks for `letterCount`. Read an example until you can
explain each line, close it, and then write the exercise yourself.

### Try it
Open https://dartpad.dev and write `fizzBuzz` before the lab. Then, in the
lab, complete all eight exercises so that the provided tests pass.

---

## 4. Anatomy of a Flutter project

```
campus_companion/
├── lib/main.dart          entry point — runApp()
├── lib/app.dart           root widget (this course's convention)
├── test/                  tests; run with `flutter test`
├── pubspec.yaml           name, SDK constraint, dependencies, assets
├── analysis_options.yaml  lint rules (the course uses strict ones)
├── android/  ios/  web/   platform hosts — rarely touched early on
└── build/                 generated output — never commit
```

`pubspec.yaml` is the one file you will edit often: adding a package is
`flutter pub add <name>` (which also resolves a real version — do not type
versions from memory).

---

## 5. Using an assistant while you are learning

### Why this matters
AI assistants are allowed in this course, and you will use them as a
professional. But a lab task exists to make **you** practise a skill. If
an assistant does the task, the code works and the tests pass, but you
have not practised — and you may not notice. Reading correct code that you
did not write feels like understanding. Studies of students who practised
with an assistant found that they scored better during practice and
**worse** in a later test without one.

### How to use one without losing the practice
- **Look at the AI-use level** under the task heading. Level 0 means the
  task trains a skill the exam checks without an assistant.
- **Try first.** Work on the task until you are stuck on one specific
  thing.
- **Ask about that one thing**, and ask for an explanation, not the
  solution: "Explain why `where` returns an `Iterable` and not a `List`",
  not "Write `averageOfPositives`".
- **Check yourself afterwards.** Close the assistant and write the same
  function again from memory. If you cannot, you do not understand it
  yet.

### Checking an answer
An assistant writes fluent, confident text even when it is wrong. Treat
every answer as a draft. Before you keep any of it:

1. **Predict** what the code does for a normal input and for an unusual
   one (empty, zero, null, two spaces), before you run it.
2. **Run it** and compare with your prediction.
3. **Analyse it**: `flutter analyze` finds methods and classes that do
   not exist. Assistants sometimes invent them.
4. **Test it**: write a test for the unusual input.
5. **Check every claim** in the explanation against the documentation
   (https://api.dart.dev, https://docs.flutter.dev). An explanation can
   be wrong even when the code is right.

Lab 1, Task 5 practises this list on a saved assistant answer, so you can
do it without network access. Labs 3, 6 and 9 each contain one more saved
answer with errors to find, and week 13 goes further.

---

## Common mistakes

1. **`flutter doctor` shows ✗ for Android toolchain and you ignore it.**
   You can run on Chrome for the first weeks, but fix it before week 4:
   install Android Studio → SDK Manager → accept licences with
   `flutter doctor --android-licenses`.
2. **Editing `main()` and expecting hot reload to show it.** Hot reload
   re-runs `build()`, not `main()`. Press `R`.
3. **Using `var` everywhere.** Prefer `final`; the analyser's
   `prefer_final_locals` will warn you. Reassignment should be rare and
   visible.
4. **Using `!` to remove null errors.** `!` means "throw an error here if
   the value is null".
   Use `?.`, `??`, or an `if (x != null)` check that the compiler can
   promote.
5. **Forgetting `const` on widgets that never change.** Not a bug, but it
   costs rebuilds. The lint tells you; fix with `dart fix --apply`.
6. **Mixing `int` and `double` in arithmetic and getting an unexpected type.**
   `10 / 4` is `2.5` (double); `10 ~/ 4` is `2` (int).
7. **`where` without `toList()`**: the type is `Iterable`, not `List`, and
   the filter re-runs each time you iterate.

## Further reading

- Dart language tour: https://dart.dev/language
- Null safety: https://dart.dev/null-safety/understanding-null-safety
- Flutter architectural overview: https://docs.flutter.dev/resources/architectural-overview
- Hot reload: https://docs.flutter.dev/tools/hot-reload
- Effective Dart (the official style guide): https://dart.dev/effective-dart

## Key terms

All key terms of the course, in one list: [`guides/glossary.md`](../../guides/glossary.md).

- **widget** — an immutable description of part of the user interface.
- **widget tree** — the widgets of a screen, nested inside each other.
- **`StatelessWidget`** — a widget whose output depends only on its
  constructor arguments.
- **`StatefulWidget`** — a widget with a `State` object that keeps values
  between rebuilds.
- **hot reload** — puts changed code into the running app and rebuilds the
  widgets; state is kept.
- **hot restart** — restarts the app from `main()`; state is lost.
- **null safety** — a variable can hold `null` only if its type ends in `?`.
- **type inference** — Dart works out a variable's type from its value.
- **`final` / `const`** — set once at run time / fixed when the program is
  compiled.
- **switch expression** — a `switch` that produces a value, one case per
  pattern.
- **iterable** — a sequence you can loop over; `where` and `map` return a
  lazy one.
- **unit test** — a small program that calls a function and checks its
  result with `expect`.
- **AI-use level** — how much help from an assistant a lab task allows
  (0 to 3).
