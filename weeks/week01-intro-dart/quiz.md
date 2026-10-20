# Week 1 quiz — self-check

Answer on paper, without running code and before you open the answers or
any tool. Then open each answer to check. Item 5 is marked as an exam-style
question: it has the form of Part B of the mid exam (`syllabus/exams.md`).

**1.** Name one advantage and one disadvantage of cross-platform frameworks
such as Flutter compared with native development.

<details><summary>Answer</summary>
Advantage: one code base and team for Android and iOS (or consistent UI,
faster iteration). Disadvantage: an extra layer between you and the platform —
new OS features arrive when the framework supports them, and very
platform-specific UI needs extra work.
</details>

**2.** What does a widget's `build()` method return, and why is a widget
called a *description* of the user interface?

<details><summary>Answer</summary>
It returns the widget subtree that this widget stands for. A widget only
says what the screen should look like (for example "a centred text"); it
does not draw anything itself. Flutter reads the description and draws it.
</details>

**3.** You edit the body of `main()` and press `r`. What happens?

<details><summary>Answer</summary>
Nothing visible. Hot reload re-runs `build()` methods but does not re-run
`main()`. You need hot restart (`R`).
</details>

**4.** What is the difference between `final` and `const`?

<details><summary>Answer</summary>
Both can be set only once. A `const` value must be known when the program
is compiled, and Dart creates only one object for identical `const` values
and reuses it. A `final` value is set once while the program runs. In
Flutter, `const` widgets are not rebuilt.
</details>

**5.** *(Exam-style question.)* Predict the output:
```dart
String? s;
print(s?.length);
print(s ?? 'empty');
print(s!.length);
```

<details><summary>Answer</summary>
`null`, then `empty`, then a runtime error (null check operator used on a
null value). The third line should never be written in real code.
</details>

**6.** Find the error:
```dart
int half(int n) => n / 2;
```

<details><summary>Answer</summary>
`n / 2` is a `double`; returning it as `int` is a compile error. Use `n ~/ 2`
for integer division, or change the return type to `double`.
</details>

**7.** Rewrite with a switch expression:
```dart
String size(int n) {
  if (n < 10) return 'small';
  if (n < 100) return 'medium';
  return 'large';
}
```

<details><summary>Answer</summary>
```dart
String size(int n) => switch (n) {
  < 10 => 'small',
  < 100 => 'medium',
  _ => 'large',
};
```
</details>

**8.** Why does the following print `(2, 4)` and not `[2, 4]`?
```dart
print([1, 2, 3, 4].where((n) => n.isEven));
```

<details><summary>Answer</summary>
`where` returns a lazy `Iterable`, whose `toString` uses parentheses. Call
`.toList()` to get a `List` (`[2, 4]`).
</details>

**9.** Trace this function by hand. Write the value of `total` after each
pass of the loop, then the value returned for `[3, -1, 4]`.

```dart
int sumOfPositives(List<int> numbers) {
  var total = 0;
  for (final n in numbers) {
    if (n > 0) total += n;
  }
  return total;
}
```

<details><summary>Answer</summary>
After `3`: 3. After `-1`: 3 (not added). After `4`: 7. It returns `7`.
</details>

**10.** An assistant tells you: "For a single word you can call
`'hello'.capitalize()`, which Dart provides on every `String`." Name two
ways to check this claim without asking the assistant again.

<details><summary>Answer</summary>
Any two of: write the line in a file and run `flutter analyze` (it reports
that the method is not defined); run it in DartPad; look for `capitalize`
in the `String` class documentation at https://api.dart.dev. Dart's
`String` has no `capitalize` method: the assistant invented it.
</details>

## Questions from your earlier programming courses

**11.** In a data-structures course you used a hash map to count things.
Which Dart type plays that role, and what does `counts.update('a', (n) =>
n + 1, ifAbsent: () => 1)` do when `'a'` is not yet a key?

<details><summary>Answer</summary>
`Map<String, int>`. When `'a'` is not a key, `update` calls `ifAbsent`
and stores `1` for `'a'`; when it is a key, it replaces the value `n` with
`n + 1`.
</details>

**12.** Which is faster for checking whether a value is present: a `List`
or a `Set`? Why?

<details><summary>Answer</summary>
A `Set`. `List.contains` checks the items one by one (linear time); a
`Set` uses hashing, so a lookup takes about the same time however many
items it holds.
</details>
