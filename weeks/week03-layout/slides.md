---
marp: true
theme: course
title: "Week 3 — Layout and common widgets"
paginate: true
footer: "Mobile Applications Development · Week 3 · Betsegaw Lemma · AAU"
---

<!-- _class: lead -->
<!-- _paginate: false -->

# Layout and common widgets

Week 3 · Mobile Applications Development
B.Sc. Computer Science · Addis Ababa University

---

## Lecture topics

1. The one layout rule
2. Building blocks: boxes, Row/Column, lists
3. Text, theme and buttons
4. Assets
5. Responsive and adaptive layout
6. Testing a layout; checking an assistant's layout code
7. Lab preview

---

<!-- _class: lead -->

# 1 · The one layout rule

---

## Constraints go down. Sizes go up. Parent sets position.

1. Parent → child: **constraints** (min/max width and height)
2. Child → parent: **its size**, within those constraints
3. Parent: **positions** the child

Every layout error in Flutter is a violation of this rule.

---

## What follows

- A widget **cannot** be any size it likes — only a size the constraints allow
  `Container(width: 1000)` in a 360-wide parent ⇒ 360
- `Column` gives children **unbounded height**
  `ListView` inside ⇒ "how tall?" ⇒ "∞" ⇒ **error**
- `Row` gives children **unbounded width**
  long `Text` inside ⇒ **overflow stripes**

Fix for both: **`Expanded`**

---

## The fix, in the capstone

```dart
// lab/solution/lib/screens/home_screen.dart
body: Column(
  children: [
    Padding(child: SegmentedButton(…)),
    // Expanded gives the section the rest of the column's height;
    // without it a ListView inside a Column has unbounded height and throws.
    Expanded(
      child: switch (_section) {
        _Section.events  => const EventsScreen(),
        _Section.profile => const ProfileScreen(),
        _Section.checkIn => const CheckInScreen(),
      },
    ),
  ],
),
```

---

## Vocabulary

| Constraint | Meaning | Example |
|---|---|---|
| **tight** | min == max | `SizedBox(width: 56)` → child |
| **loose** | min 0, max N | `Center` → child |
| **bounded** | max is finite | Scaffold body |
| **unbounded** | max is ∞ | inside `ListView`; `Row` main axis |

---

<!-- _class: pause -->

## What happens?

```dart
Scaffold(
  body: Column(
    children: [
      Text('Events'),
      ListView(children: [Text('a'), Text('b')]),
    ],
  ),
)
```

---

<!-- _class: lead -->

# 2 · Building blocks

---

## Single-child boxes

| Widget | Purpose |
|---|---|
| `Container` | decoration + padding + margin + size + alignment |
| `Padding` | only padding — lighter |
| `SizedBox` | fixed size, or a spacer |
| `Center` / `Align` | position inside loose constraints |
| `SafeArea` | avoid notch, status bar, home indicator |

---

## Container

```dart
// lab/solution/lib/exercises/lecture_layouts.dart (ContactTile)
Container(
  width: 48,
  height: 48,
  alignment: Alignment.center,
  decoration: BoxDecoration(
    color: colors.secondaryContainer,
    shape: BoxShape.circle,
  ),
  child: Text(/* initials */),
)
```

`color:` **or** `decoration:` — never both (colour goes inside the decoration).

---

## Row and Column

- **main axis**: horizontal for Row, vertical for Column
- `mainAxisAlignment` — spacing along the main axis
- `crossAxisAlignment` — alignment across it (`stretch` is often the right choice)
- `mainAxisSize: min` — only as large as the content
- `Expanded` / `Flexible` — share the *remaining* space; `flex: 2` for double
- `Spacer()` — empty `Expanded`

---

## Expanded in practice

```dart
// lab/solution/lib/exercises/lecture_layouts.dart (CoursePage)
final figures = Row(
  children: [
    Expanded(
      child: _Figure(value: '$credits', label: 'Credits'),
    ),
    const Expanded(
      child: _Figure(value: '14', label: 'Weeks'),
    ),
    const Expanded(
      child: _Figure(value: '13', label: 'Labs'),
    ),
  ],
);
```

Three equal columns on **every** width. No pixel arithmetic.

---

## A row that cannot overflow

```
┌──────────────────────────────────────┐
│ ┌──┐  Hanna Tesfaye Gebremedhi…    ● │
│ │HT│  Lecturer · Room 214            │
│ └──┘                                 │
└──────────────────────────────────────┘
 Container  Expanded(Column)        Icon
 48 × 48
```

`ContactTile`: Row → [fixed box, **Expanded** column, optional icon].
At 320 px the `Row` gets 288; the `Expanded` gets the 216 that are left.

---

<!-- _class: pause -->

## What happens if I remove this `Expanded`?

```dart
// lab/solution/lib/exercises/lecture_layouts.dart (ContactTile, shortened)
Row(
  children: [
    Container(width: 48, height: 48, /* initials */),
    const SizedBox(width: 12),
    Expanded(                       // <- remove this line (and its bracket)
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
          Text.rich(/* role · office */),
        ],
      ),
    ),
    if (online) Icon(Icons.circle, /* ... */),
  ],
)
```

The name is very long. Write your prediction.

---

## Multi-child, continued

| Widget | Use |
|---|---|
| `Wrap` | Row that wraps — chips, button groups |
| `Stack` + `Positioned` | layers — badges, overlays |
| `ListView.builder` | long lists; builds only visible items |
| `SingleChildScrollView` | one tall child — forms, detail pages |
| `GridView.builder` | two-dimensional lists |

---

## ListView.builder

```dart
// lab/solution/lib/exercises/lecture_layouts.dart (RoomsPage)
return ListView.builder(
  padding: const EdgeInsets.all(8),
  itemCount: rooms.length,
  itemBuilder: (context, index) => _RoomTile(name: rooms[index]),
);
```

`ListView(children: [...])` builds **every** item immediately. Acceptable for 5 items, not for 5 000.

---

<!-- _class: lead -->

# 3 · Text, theme, buttons

---

## Text and Text.rich

```dart
// lab/solution/lib/exercises/lecture_layouts.dart (ContactTile)
Text(
  name,
  style: theme.textTheme.titleMedium,
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
),
Text.rich(
  TextSpan(
    children: [
      TextSpan(
        text: role,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      TextSpan(text: ' · $office'),
    ],
  ),
  style: theme.textTheme.bodyMedium,
),
```

`Text.rich` uses the screen's text style as its base.
`RichText` does **not**: give its root `TextSpan` a `style`.

---

## Use the theme, not numbers

```dart
// lab/solution/lib/exercises/lecture_layouts.dart (ContactTile)
final theme = Theme.of(context);
final colors = theme.colorScheme;

Text(
  initials,
  style: theme.textTheme.titleMedium?.copyWith(
    color: colors.onSecondaryContainer,
  ),
)
```

- `TextTheme`: `displayLarge` … `bodySmall`, `labelSmall`
- `ColorScheme`: `primary`, `primaryContainer`, `onPrimaryContainer`, `surfaceContainerHighest` …
- All derived from **one seed colour** in `app.dart`

---

## Buttons: choose by emphasis

| Widget | Emphasis | Use for |
|---|---|---|
| `FilledButton` | high | the main action |
| `FilledButton.tonal` | medium-high | important secondary |
| `OutlinedButton` | medium | secondary |
| `TextButton` | low | cancel, dialogs, inline |
| `IconButton` | low | toolbars — set `tooltip` |
| `FloatingActionButton` | highest | primary *create* action |
| `SegmentedButton` | — | one of a few options |

`onPressed: null` disables any of them.

---

## Buttons on a course page

```dart
// lab/solution/lib/exercises/lecture_layouts.dart (CoursePage)
Wrap(
  spacing: 8,
  runSpacing: 8,
  alignment: WrapAlignment.center,
  children: [
    FilledButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.how_to_reg),
      label: const Text('Enrol'),
    ),
    OutlinedButton(onPressed: () {}, child: const Text('Syllabus')),
    TextButton(onPressed: () {}, child: const Text('Not now')),
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.share),
      tooltip: 'Share',
    ),
  ],
)
```

`Wrap`, so the buttons flow onto a second line on narrow phones.

---

<!-- _class: lead -->

# 4 · Assets

---

## Two steps, one common bug

```yaml
# pubspec.yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

Then refer to the file by its path, for example
`Image.asset('assets/images/logo.png')` or `AssetImage(...)`.

Forget the yaml ⇒ builds fine ⇒ **"Unable to load asset"** at runtime.
After editing `pubspec.yaml`: hot **restart**.

---

<!-- _class: lead -->

# 5 · Responsive and adaptive

---

## Orientation

```dart
// lab/solution/lib/exercises/lecture_layouts.dart (CoursePage, shortened)
final isLandscape =
    MediaQuery.orientationOf(context) == Orientation.landscape;

child: isLandscape
    ? Row(children: [Expanded(child: header), …, Expanded(child: rest)])
    : Column(children: [header, …, rest]),
```

`MediaQuery.orientationOf` rebuilds only on orientation change.
`MediaQuery.of(context).orientation` rebuilds on **any** change (keyboard!).

---

## Use width, not orientation

```dart
// lab/solution/lib/exercises/lecture_layouts.dart (RoomsPage)
return LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth >= wideBreakpoint) {
      return GridView.builder(/* three columns */);
    }
    return ListView.builder(/* one column */);
  },
);
```

`LayoutBuilder` = the constraints of **this** widget, not the screen.
Breakpoints: < 600 compact · 600–840 medium · ≥ 840 expanded

---

<!-- _class: pause -->

## Which rebuilds when the keyboard opens?

```dart
// A
final o = MediaQuery.of(context).orientation;
// B
final o = MediaQuery.orientationOf(context);
```

---

<!-- _class: live -->

## Live coding: resize the feed

The script is in the speaker notes.

---

## Testing layout

```dart
// lab/solution/test/exercises/lecture_layouts_test.dart
await tester.pumpWidget(
  wrap(
    SizedBox(
      width: 320,
      child: ContactTile(
        name: 'A very long name ' * 10,
        role: 'Lecturer',
        office: 'Room 214',
        online: true,
      ),
    ),
  ),
);
// A RenderFlex overflow is reported as an exception in a test.
expect(tester.takeException(), isNull);
```

Overflow **is an exception** in tests. Test the narrow case on purpose,
and write the test before the screen.

---

## Checking an assistant's layout code

Layout code from an assistant often looks right and works for its own
short example. Check it three ways:

1. **Analyser** — parameters that do not exist
2. **Test at 320 px** — with the longest text you expect
3. **Documentation** — `Row` → "Layout algorithm": which width does each
   child get?

The lab gives you a saved answer to check.

---

## Lab topics

1. Register the asset folder; produce the asset error first, then fix it
2. `EventCard` from a picture of the card
3. `EventsScreen` — list, then grid above 600 px
4. `ProfileScreen` — write the 320 px test first, then the screen
5. Check an assistant's layout answer: predict, run, mark the errors
6. Your own design: `NoteCard` at 360 and 900 px
7. Extra task: a `Stack` badge on the card for events starting today

Checkpoint A after 3, Checkpoint B after 6, then the exit task.
**Project proposal due at the end of week 3.**

---

## Before the next lecture

- Read *Navigation and routing* overview and the `go_router` README
  (docs.flutter.dev/ui/navigation · pub.dev/packages/go_router)
- Submit your proposal

---

<!-- _class: lead -->
<!-- _paginate: false -->

# Questions?

Notes, lab and quiz: github.com/betsegawlemma/mobile-application-development-course
