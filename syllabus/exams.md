# Exams

The two exams make up 70 % of your course mark. This page tells you what
they cover, what kinds of question they contain, and what you may bring.
It also contains a sample mid-exam paper and a sample final-exam design
question, both with answers. Practise them under exam conditions: on
paper, without notes, without a computer and without an assistant, and
only then read the answers.

## Rules for both exams

- On paper. Closed book. No computer, phone or AI tool.
- You receive the **one-page API reference sheet** printed below, so you
  do not need to memorise exact names and signatures. The exam checks
  whether you can **read, reason about and write** code, not whether you
  remember spelling.
- Answer in English. You may write a single Amharic word in brackets when
  you do not know the English word.
- Short code answers are marked on meaning. A missing semicolon or a small
  spelling slip costs nothing if the intent is clear.

## Mid exam (week 8, 30 %)

**Covers weeks 1–7.** Week 8 (local persistence) is **not** in the mid
exam; it is examined in the final exam.

| Part | Item type | What it checks | Course outcomes | Share |
|---|---|---|---|---|
| A | Explain a concept in two or three sentences | native, web and cross-platform approaches compared; widget, element and render object; lifecycle; ephemeral and app state; `watch` and `read` | 1, 4 | 20 % |
| B | Read the code and predict the output or the screen | Dart async order, null safety, layout constraints, rebuilds | 1, 2, 3 | 25 % |
| C | Find the error and correct it | a layout error, a route, a provider used wrongly, a key | 3, 4 | 20 % |
| D | Complete the code (fill the blanks, or put given lines in order) | a notifier method, a form validator, a widget | 2, 3, 4 | 20 % |
| E | Write two test cases for a given function | unit or widget test with `expect` | 5 | 15 % |

## Final exam (exam period, 40 %)

**Covers weeks 1–14**, including week 8. It uses the same item types as
the mid exam and adds design questions, in which you choose between
options and justify the choice.

| Part | Item type | What it checks | Course outcomes | Share |
|---|---|---|---|---|
| A | Explain a concept | any week | 1–9 | 15 % |
| B | Read the code and predict | async, streams, providers, repositories | 2, 4, 6 | 15 % |
| C | Find the error and correct it | persistence, networking, rules, permissions | 4, 6, 7 | 15 % |
| D | Complete the code | repository method, rule, test | 4, 5, 6 | 15 % |
| E | Write test cases | unit, widget or rules test | 5 | 15 % |
| F | Design and justify | storage choice, permission flow, AI feature, release decision | 3, 6, 7, 8, 9 | 25 % |

The course outcomes are numbered as in [`syllabus.md`](syllabus.md).
[`coverage-matrix.md`](coverage-matrix.md) shows which exam part checks
each outcome.

## How to prepare

- Do each weekly quiz **before** you open its answers. Each quiz has one
  item marked "Exam-style question".
- Redo the exit task of each lab on paper.
- Trace code by hand: write down each value as the program runs.
- For design questions, practise naming **two** options and one reason
  against the option you reject.

---

## API reference sheet

You receive this page in both exams. The final exam adds the second
column.

<table>
<tr><td valign="top">

**Dart**
- `List`: `add`, `where`, `map`, `fold`, `any`, `firstWhere`, `sort`,
  `toList`, `[...a, b]`, `List.unmodifiable`
- `String`: `split`, `trim`, `substring`, `toUpperCase`, `contains`,
  `isEmpty`, `length`
- Null safety: `?`, `!`, `?.`, `??`, `late`, `required`
- Async: `Future`, `async`, `await`, `Future.delayed`, `Stream`,
  `async*`, `yield`
- Classes: constructors, `final`, `const`, `extends`, `with`,
  `sealed`, `switch` patterns

**Widgets**
- `StatelessWidget`, `StatefulWidget`, `State`, `setState`,
  `initState`, `dispose`, `build`
- `Scaffold`, `AppBar`, `Text`, `Column`, `Row`, `Expanded`,
  `Flexible`, `Padding`, `SizedBox`, `Container`, `Center`, `Stack`
- `ListView`, `ListView.builder`, `GridView`, `LayoutBuilder`,
  `MediaQuery`
- `Form`, `TextFormField(validator:)`, `GlobalKey<FormState>`,
  `ElevatedButton`, `IconButton`, `FloatingActionButton`
- `GestureDetector`, `InkWell`, `Dismissible`,
  `ReorderableListView`, `ValueKey`, `AnimatedContainer`,
  `AnimatedOpacity`

**Navigation**
- `Navigator.push`, `Navigator.pop`, `MaterialPageRoute`
- `GoRouter`, `GoRoute`, `context.go`, `context.push`, `context.pop`

**Riverpod**
- `@riverpod`, `Notifier`, `state`, `build()`
- `ref.watch`, `ref.read`, `ref.listen`, `ConsumerWidget`,
  `WidgetRef`, `ProviderScope(overrides:)`, `AsyncValue.when`

**Tests**
- `test`, `group`, `setUp`, `expect`
- matchers: `equals`, `isTrue`, `isFalse`, `isNull`, `hasLength`,
  `contains`, `throwsA(isA<T>())`
- `testWidgets`, `tester.pumpWidget`, `tester.tap`,
  `tester.enterText`, `tester.pump`, `tester.pumpAndSettle`
- `find.text`, `find.byType`, `find.byKey`, `findsOneWidget`,
  `findsNothing`

</td><td valign="top">

**Final exam only**

**Persistence**
- `jsonEncode`, `jsonDecode`, `fromJson`, `toJson`
- `SharedPreferences.getInstance()`, `getString`, `setString`,
  `getBool`, `setBool`
- drift: `select(...).get()`, `watch()`, `into(...).insert`,
  `insertOnConflictUpdate`, `delete(...).go()`, `schemaVersion`,
  `MigrationStrategy`
- `FutureBuilder`, `snapshot.hasData`, `snapshot.hasError`

**Networking**
- dio: `get`, `post`, `put`, `delete`, `queryParameters`,
  `response.data`, `response.statusCode`, `DioException`,
  `connectTimeout`, `receiveTimeout`

**Firebase**
- `FirebaseAuth.instance`: `signInWithEmailAndPassword`,
  `createUserWithEmailAndPassword`, `signOut`, `authStateChanges()`
- `FirebaseFirestore.instance.collection(...)`: `doc`, `add`, `set`,
  `update`, `delete`, `snapshots()`, `where`, `orderBy`
- Rules: `request.auth.uid`, `resource.data`,
  `request.resource.data`, `allow read, create, update, delete: if`

**Device**
- `Permission.camera`, `Permission.location`: `status`, `request()`;
  `PermissionStatus.isGranted`, `isDenied`, `isPermanentlyDenied`;
  `openAppSettings()`
- `Geolocator.checkPermission`, `Geolocator.requestPermission`,
  `LocationPermission.denied`, `deniedForever`,
  `Geolocator.getCurrentPosition`, `ImagePicker().pickImage`,
  `accelerometerEventStream()`

**Release and accessibility**
- `Semantics(label:)`, `MergeSemantics`, `ExcludeSemantics`
- `AppLocalizations.of(context)`, `Locale`
- `flutter build apk --release --flavor`

</td></tr>
</table>

---

## Sample mid-exam paper

The real paper has the same parts, in the same order, with different
code.

### Part A — Explain (20 %)

**A1.** What is the difference between a `StatelessWidget` and a
`StatefulWidget`? Name one situation in Campus Companion where you need
a `StatefulWidget`.

**A2.** Give one example of *ephemeral* state and one example of *app*
state in Campus Companion. Where should each one live?

**A3.** In a `ConsumerWidget`, why do you use `ref.watch` inside `build`
but `ref.read` inside an `onPressed` callback?

### Part B — Read the code and predict (25 %)

**B1.** What does this program print? Write each line in order.

```dart
Future<void> main() async {
  print('A');
  final f = Future(() => print('B'));
  print('C');
  await f;
  print('D');
}
```

**B2.** What does this print?

```dart
void main() {
  String? name;
  print(name?.length ?? 0);
  name = 'Selam';
  print(name.length);
}
```

**B3.** This widget is the `body` of a `Scaffold`. What do you see on
the screen, and why?

```dart
Column(
  children: [
    const Text('Events'),
    ListView(
      children: const [Text('Coding club'), Text('Football')],
    ),
  ],
)
```

### Part C — Find the error and correct it (20 %)

**C1.** Pressing *Add* does not show the new note, and the debug console
shows an `Unsupported operation` error. Find the error and correct it.

```dart
@riverpod
class Notes extends _$Notes {
  @override
  List<Note> build() => const [];

  void add(Note note) {
    state.add(note);
  }
}
```

**C2.** The list shows the notes, but when a note is added it does not
appear until the screen is opened again. Find the error.

```dart
class NotesList extends ConsumerWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.read(notesProvider);
    return ListView(
      children: [for (final n in notes) Text(n.title)],
    );
  }
}
```

### Part D — Complete the code (20 %)

**D1.** Fill in the blanks so that the validator rejects an empty title
(after trimming) with `'Enter a title'`, rejects a title longer than 120
characters with `'At most 120 characters'`, and accepts anything else.

```dart
String? validateTitle(String? value) {
  if (value == null || ________________) return 'Enter a title';
  if (________________) return 'At most 120 characters';
  return ________;
}
```

**D2.** Put these lines in order to make a `togglePinned` method of the
`Notes` notifier. One line is not needed.

```text
(a)   ]);
(b)   state.add(note.copyWith(isPinned: true));
(c) void togglePinned(String id) {
(d)     if (note.id == id) note.copyWith(isPinned: !note.isPinned) else note,
(e)   state = List.unmodifiable([
(f) }
(g)     for (final note in state)
```

### Part E — Write two test cases (15 %)

**E1.** `initials` returns the upper-case first letters of the first two
words of a name, and an empty string for an empty name. For example,
`initials('abebe kebede')` is `'AK'`.

```dart
String initials(String fullName) { /* ... */ }
```

Write **two** `test` cases with `expect`. Choose cases that would catch
two *different* mistakes, and say in one line which mistake each one
catches.

### Answers to the sample mid-exam paper

**A1.** A `StatelessWidget` is described completely by its constructor
arguments and cannot change by itself. A `StatefulWidget` has a `State`
object that lives across rebuilds and can call `setState` to rebuild.
Example: the note editor screen, which holds text controllers; or the
check-in counter in week 2. (2 marks: difference 1, valid example 1.)

**A2.** Ephemeral: whether a tile is expanded, the text in a field being
typed, a scroll position — it lives in the widget's `State`. App state:
the list of notes or the signed-in profile — it lives in a provider,
because several screens use it. (2 marks.)

**A3.** `ref.watch` in `build` subscribes the widget, so it rebuilds when
the provider changes. A callback runs once, when the user taps, and only
needs the current value or the notifier; watching there would create a
subscription for no reason, so it uses `ref.read`. (2 marks.)

**B1.** `A`, `C`, `B`, `D`. The function passed to `Future` runs later,
after the current synchronous code, so `C` prints before `B`; `await f`
waits for it before `D`. (3 marks: order 2, reason 1.)

**B2.** `0`, then `5`. After the assignment, Dart knows `name` is not null
(type promotion), so `name.length` needs no `!`. (2 marks.)

**B3.** An error, not the list: "Vertical viewport was given unbounded
height". A `Column` lets its children be as tall as they like, and a
`ListView` tries to be as tall as possible. Fix: wrap the `ListView` in
`Expanded`. (3 marks: what you see 1, reason 1, fix 1.)

**C1.** `state.add(note)` changes the list in place. The state is an
unmodifiable list, so this throws, and Riverpod is never told that the
state changed. Correct: `state = List.unmodifiable([...state, note]);`
(2 marks.)

**C2.** `ref.read` in `build` reads the value once and does not
subscribe. Correct: `ref.watch(notesProvider)`. (2 marks.)

**D1.** `value.trim().isEmpty`; `value.length > 120` (or
`value.trim().length > 120`); `null`. (3 marks.)

**D2.** `c, e, g, d, a, f`. Line `b` is not needed: it changes the list
in place and adds a second note. (3 marks.)

**E1.** Any two cases that catch different mistakes, for example:

```dart
test('uses the first letter of the first two words, in upper case', () {
  expect(initials('abebe kebede'), 'AK'); // catches: forgot toUpperCase
});

test('returns an empty string for an empty name', () {
  expect(initials(''), ''); // catches: a crash on an empty string
});
```

Other good cases: a single word (`'Selam'` → `'S'`), three words (only
the first two count), extra spaces. Two cases that check the same thing
earn 2 of 4 marks. (4 marks: two correct tests 2, two different mistakes
named 2.)

---

## Sample final-exam design question (Part F)

**F1.** Campus Companion will let a student save their favourite bus
routes. A route has a name and a list of about ten stops. A student saves
at most twenty routes. The routes must survive a restart, work offline,
and be shown in a list sorted by name.

(a) Name **two** of these storage options that could work and choose
one: `shared_preferences`, a JSON file, `drift`, Cloud Firestore.
Give **two** reasons for your choice and **one** reason against an
option you rejected. (6 marks)

(b) The app will later sync routes between a student's phones. Which
part of your code changes, and which parts do not? Use the names of the
layers from the course. (4 marks)

### Answer and marking scheme

(a) Several answers earn full marks if the reasons are correct. Example:

- **Choice: a JSON file (or `shared_preferences` with one JSON string).**
  The data is small (twenty routes), it is read and written as a whole,
  and it needs no queries: sorting twenty items in Dart is enough. It
  works offline with no setup.
- **Against `drift`:** a database with tables and migrations is more
  work than the data needs; it pays off with many rows, queries or
  relations.
- **Against Cloud Firestore:** it needs an account and network for the
  first sync, and the requirement is offline, single-device storage.

A student who chooses `drift` earns full marks with reasons such as
"stops are a second table, and I can sort with `orderBy` in the query".

Marks: two workable options named 1; choice 1; two correct reasons for it
2; one correct reason against another option 2. A reason that is not true
for this data (for example "shared_preferences cannot store lists") earns
nothing.

(b) Only the **data** layer changes: a new implementation of the
`RoutesRepository` interface (for example one that uses Firestore with
offline persistence, or that syncs the local file). The **domain** model
(`Route`) and the **presentation** layer (screens and providers that
call the repository) do not change, because they depend on the interface,
not on the storage. The provider that creates the repository is changed,
or overridden, to return the new implementation.

Marks: data layer changes 1; domain unchanged 1; presentation unchanged
1; the reason (they depend on the interface) 1.
