# Week 3 quiz — self-check

Answer on paper, without running code and before you open the answers or
any tool. Then open each answer to check. Item 11 is marked as an
exam-style question: it has the form of Part B of the mid exam
(`syllabus/exams.md`).

**1.** State Flutter's layout rule in one sentence.

<details><summary>Answer</summary>
Constraints go down, sizes go up, and the parent sets the position.
</details>

**2.** Why does a `ListView` placed directly inside a `Column` throw, and
what is the fix?

<details><summary>Answer</summary>
A `Column` gives its children unbounded height; a `ListView` tries to fill
the available height, which is infinite. Wrap the `ListView` in `Expanded`
(or give it a bounded height).
</details>

**3.** Find the error:
```dart
Container(
  color: Colors.teal,
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
)
```

<details><summary>Answer</summary>
`color` and `decoration` cannot both be set. Move the colour into the
`BoxDecoration`.
</details>

**4.** What is the difference between `Expanded` and `Flexible`?

<details><summary>Answer</summary>
Both take a share of the remaining main-axis space. `Expanded` forces the
child to fill that share; `Flexible` allows the child to be smaller.
</details>

**5.** A `Text` inside a `Row` shows yellow-and-black stripes on the right.
Which change fixes it? A classmate says that setting `maxLines: 1` and
`overflow: TextOverflow.ellipsis` is enough. Is that right?

<details><summary>Answer</summary>
Wrap the `Text` in `Expanded` (or `Flexible`) so it gets a bounded width;
it then wraps onto more lines. The classmate is wrong: on their own,
`maxLines` and the ellipsis do nothing here, because the `Row` gives the
`Text` an unbounded width and the text never runs out of space. Together
with `Expanded`, they make the text one line that ends in "…".
</details>

**6.** The app builds, but at runtime shows *Unable to load asset:
assets/images/logo.png*. What did you forget?

<details><summary>Answer</summary>
Declaring the folder (or file) under `flutter: assets:` in `pubspec.yaml`,
followed by a hot restart.
</details>

**7.** Why prefer `MediaQuery.orientationOf(context)` over
`MediaQuery.of(context).orientation`?

<details><summary>Answer</summary>
`orientationOf` subscribes only to orientation changes, so the widget does
not rebuild when unrelated `MediaQueryData` fields change (for example the
keyboard inset).
</details>

**8.** When should you use `LayoutBuilder` rather than `MediaQuery` to
decide between a list and a grid?

<details><summary>Answer</summary>
When the decision depends on the space available to *this* widget rather
than the whole screen — for example inside a split view or a dialog.
`LayoutBuilder` gives the actual constraints.
</details>

**9.** Predict what renders:
```dart
RichText(text: const TextSpan(text: 'Hello'))
```

<details><summary>Answer</summary>
"Hello" in the default `RichText` fallback style (small, black) — it does
not inherit the ambient `DefaultTextStyle`. Give the root span a style or
use `Text.rich`.
</details>

**10.** Which button would you use for the single most important action on
a screen, and which for the primary "create" action?

<details><summary>Answer</summary>
`FilledButton` for the main action; `FloatingActionButton` for the
primary create/compose action.
</details>

**11.** *(Exam-style question.)* Trace the constraints. The screen is
360 × 640 pixels.

```dart
Scaffold(
  body: Column(
    children: [
      Row(
        children: [
          Text('A very long title that does not fit on one line of a phone'),
          Icon(Icons.star),
        ],
      ),
    ],
  ),
)
```

Write (a) the width constraint that the `Column` gives the `Row`, and
(b) the width constraint that the `Row` gives the `Text`. Then (c)
explain why yellow and black stripes appear, and (d) write the one change
that removes them.

<details><summary>Answer</summary>
(a) 0 to 360: a `Column` gives its children a loose width up to its own
width. (b) 0 to infinity (unbounded): a `Row` lays out a child without
flex with an unbounded width. (c) The `Text` takes the width of the whole
title on one line, which is wider than 360, so the `Row`'s children
overflow on the right and Flutter draws the stripes. (d) Wrap the `Text`
in `Expanded` (or `Flexible`): it then gets a bounded width (360 minus the
icon) and wraps onto more lines, or ends in "…" with `maxLines: 1` and
`overflow: TextOverflow.ellipsis`.
</details>

**12.** Evaluate this test. It is meant to show that `EventCard` does not
overflow on small phones. Does it? Explain, and say what you would change.

```dart
testWidgets('a long title does not overflow', (tester) async {
  final long = event.copyWith(title: 'A very long title ' * 10);
  await tester.pumpWidget(
    MaterialApp(home: Scaffold(body: EventCard(event: long))),
  );
  expect(find.byType(EventCard), findsOneWidget);
});
```

<details><summary>Answer</summary>
No. The card is pumped at the default test width of 800 pixels, not at a
phone width, so a title that overflows at 320 pixels may fit here. The
`expect` also checks nothing about the layout: a card that overflows is
still found by `find.byType`. Put the card in `SizedBox(width: 320, ...)`
and add `expect(tester.takeException(), isNull);`, so the test says
exactly what it checks.
</details>

**13.** An assistant writes: "To stop overflow stripes, always wrap the
widget in a `SingleChildScrollView`." Judge this rule. When is it right,
and when is it wrong?

<details><summary>Answer</summary>
It is right for a tall screen such as a form or a profile: when a
`Column` is taller than the screen, a vertical `SingleChildScrollView`
lets the user scroll to the rest. It is wrong as a general rule: a
vertical scroll view does not fix a `Row` that is too wide (the text still
needs `Expanded`), a sideways scroll view hides content instead of
wrapping it, and a `ListView` or an `Expanded` inside a vertical scroll
view causes an error about unbounded height. First find which constraint is broken, then
choose the fix.
</details>

**14.** Put these lines in order so that the page shows a grid when it
has at least 600 pixels of width and a list otherwise. One line is not
needed.

```text
A   return LayoutBuilder(
B     builder: (context, constraints) {
C       if (constraints.maxWidth >= 600) {
D         return const TwoColumnPage();
E       }
F       return const OneColumnPage();
G     },
H   );
I   final o = MediaQuery.orientationOf(context);
```

<details><summary>Answer</summary>
A, B, C, D, E, F, G, H. Line I is not needed: the decision is made from
the width this widget has, not from the orientation of the screen.
</details>

## Questions from earlier weeks

**15.** (From week 2) `EventCard` takes an `Event`. Why can `EventCard` be
a `StatelessWidget`, even though the events change during the term?

<details><summary>Answer</summary>
`EventCard` only shows the `Event` it receives in its constructor; it
does not change anything itself. When an event changes, the parent
rebuilds with a new `Event` and Flutter builds a new `EventCard` with it.
The changing data lives in the parent (or, from week 5, in a provider),
not in the card.
</details>

**16.** (From week 2) Find the error:

```dart
Future<void> _load() async {
  final events = await fetchEvents();
  setState(() => _events = events);
}
```

<details><summary>Answer</summary>
After the `await`, the user may have left the screen, so the `State` may
no longer be in the tree, and `setState` then throws. Add
`if (!mounted) return;` after the `await` and before `setState`.
</details>
