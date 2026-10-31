# Week 4 quiz — self-check

Answer on paper, without running code and before you open the answers or
any tool. Then open each answer to check. Item 11 is marked as an
exam-style question: it has the form of Part B of the mid exam
(`syllabus/exams.md`).

**1.** What is the difference between `context.go` and `context.push`?

<details><summary>Answer</summary>
`go` replaces the navigation stack with the stack for the new location
(like following a link); `push` adds the new route on top so the back
button returns to the previous screen.
</details>

**2.** How does a pushed screen return a value to the screen that pushed
it, and what does the caller receive if the user presses back instead?

<details><summary>Answer</summary>
`context.pop(value)` (or `Navigator.pop(context, value)`); the caller
awaits `push<T>` and receives `value`. On back without a result it
receives `null`.
</details>

**3.** Name three things named routes (`MaterialApp.routes`) make hard
that `go_router` makes easy.

<details><summary>Answer</summary>
Path parameters (`/events/42`), nested navigation with per-tab back
stacks, and deep links / web URLs mapped declaratively to screens.
</details>

**4.** What does `parentNavigatorKey: rootNavigatorKey` do on a route
nested under a shell branch?

<details><summary>Answer</summary>
Pushes the route on the root navigator instead of the branch's navigator,
so it appears above the shell and covers the bottom navigation bar.
</details>

**5.** Find the error:
```dart
ListTile(
  title: const Text('About'),
  onTap: () => context.push(Routes.about),
)
```
inside a `Drawer`.

<details><summary>Answer</summary>
The drawer is never closed; it is still open when the user returns. Call
`Navigator.pop(context)` before `context.push`.
</details>

**6.** Why is `sampleEvents.where((e) => e.id == id).firstOrNull` used
in the detail route builder instead of `firstWhere`?

<details><summary>Answer</summary>
The id comes from a URL and may not exist (an old deep link, a typing mistake).
`firstWhere` throws; `firstOrNull` returns null so the screen can show
"not found".
</details>

**7.** What does `StatefulShellRoute.indexedStack` give you that a plain
`ShellRoute` does not?

<details><summary>Answer</summary>
A separate navigator (back stack) per branch, preserved when switching
tabs, and `goBranch` to switch between them.
</details>

**8.** Which widget would you use for: (a) five top-level sections,
(b) an "Upcoming / Past" split of one list, (c) share/bookmark actions on
a detail page, (d) a rarely used Settings page?

<details><summary>Answer</summary>
(a) `NavigationBar` in a shell route; (b) `TabBar` + `TabBarView`;
(c) `BottomAppBar`; (d) `Drawer` (an icon button in the `AppBar` is also
a good answer: both are on every tab and neither uses a place in the
bottom bar).
</details>

**9.** Predict the error:
```dart
Column(children: [
  const TabBar(tabs: [Tab(text: 'A'), Tab(text: 'B')]),
  TabBarView(children: [ListView(), ListView()]),
])
```

<details><summary>Answer</summary>
Unbounded height: `TabBarView` needs a bounded height inside a `Column`.
Wrap it in `Expanded`. (Also needs a `DefaultTabController` ancestor.)
</details>

**10.** Why build the edit-profile location with
`Uri(path: ..., queryParameters: {'name': _name})` instead of string
interpolation?

<details><summary>Answer</summary>
`Uri` percent-encodes the value, so names with spaces, `&`, `#` or
non-Latin characters produce a valid URL and round-trip correctly.
</details>

**11.** *(Exam-style question.)* Trace the navigation. The library app
from the lecture (`lecture_navigation.dart`) starts at `/books`. Its
`/books/:isbn` route has `parentNavigatorKey: libraryRootKey`, and
`/hours` is a route outside the shell. These steps happen one after the
other. After each step, write the page the user sees and whether there is
a back arrow in the app bar.

1. `context.go('/books/111')`
2. The user presses the back arrow.
3. `context.go('/hours')`
4. `context.go('/loans')`, then `context.push('/books/333')`, then the
   user presses the back arrow.

<details><summary>Answer</summary>
1. The book page for 111, **with** a back arrow. `go` builds the stack
   from the path: `/books/111` is nested under `/books`, so the stack is
   the books list with the book page on top.
2. The books list, with the bottom bar and no back arrow.
3. The opening hours page, **without** a back arrow: `/hours` has no
   parent route, so `go` leaves nothing under it.
4. The loans page: `push` put the book page on top of the loans page, and
   back removed it. The user does not return to the Books tab.
</details>

**12.** Evaluate this test. It is meant to check that a deep link to an
unknown event shows the not-found text. Does it check that? Explain, and
say what you would change.

```dart
testWidgets('a deep link to an unknown event shows not found', (tester) async {
  await pumpApp(tester, initial: '/events/nope');
  expect(find.textContaining('Not Found'), findsOneWidget);
});
```

<details><summary>Answer</summary>
No. With no `:id` route and no `errorBuilder` (the lab starter),
`go_router` shows its own error page, whose title is *Page Not Found*, so
the test **passes on the wrong code**. With the finished route the screen
shows *Event not found* (lower-case "not found"), so the test **fails on
the right code**. `textContaining` is case-sensitive and matches any page
with those words. Expect the exact text of the page you mean:
`find.text('Event not found')`, and write the test first, so that you see
it fail for the right reason before the route exists.
</details>

**13.** Put these lines in order so that the method opens the room
picker and shows the room the user chose. Two lines are not needed.

```text
A   Future<void> _pickRoom() async {
B     final room = await context.push<String>('/rooms/pick');
C     if (!mounted || room == null) return;
D     setState(() => _room = room);
E   }
F     final room = context.push<String>('/rooms/pick');
G     context.go('/rooms/pick');
```

<details><summary>Answer</summary>
A, B, C, D, E. Line F is wrong: without `await`, `room` is a
`Future<String?>`, not the chosen room. Line G is wrong: `go` replaces
the stack and returns no result, so the picker cannot send the room back.
</details>

## Questions from earlier weeks

**14.** (From week 2) Find the error:

```dart
Future<void> _edit() async {
  final r = await context.push<String>('/profile/edit');
  setState(() => _name = r!);
}
```

<details><summary>Answer</summary>
Two errors. `r` is `null` when the user presses back or *Cancel*, and
`r!` then throws. And after the `await` the profile screen may have been
closed, so `setState` can be called on a `State` that is no longer in the
tree. Add `if (!mounted || r == null) return;` after the `await` and
remove the `!`.
</details>

**15.** (From week 3) `EventsScreen` shows a grid when its
`LayoutBuilder` reports `constraints.maxWidth >= 600`. The app runs in a
1000-pixel-wide browser window, but the feed is in an `Expanded` in a
`Row`, next to a 450-pixel side panel. Does the feed show a list or a grid? What would
it show if the code used `MediaQuery.sizeOf(context).width` instead?

<details><summary>Answer</summary>
A list: `LayoutBuilder` reports the width the feed itself gets, 550
pixels. `MediaQuery.sizeOf(context).width` is the width of the whole
window, 1000, so the feed would show a grid that is too narrow for its
cells. Decide a layout from the space the widget has, not from the size
of the screen.
</details>
