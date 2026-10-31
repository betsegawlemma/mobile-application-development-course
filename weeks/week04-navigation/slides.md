---
marp: true
theme: course
title: "Week 4 — Navigation"
paginate: true
footer: "Mobile Applications Development · Week 4 · Betsegaw Lemma · AAU"
---

<!-- _class: lead -->
<!-- _paginate: false -->

# Navigation

Week 4 · Mobile Applications Development
B.Sc. Computer Science · Addis Ababa University

---

## Lecture topics

1. Navigator 1.0: push, pop, results
2. Named routes and their limits
3. go_router: declarative routes
4. Bottom navigation with per-tab stacks
5. Drawer, TabBar, BottomAppBar
6. Testing navigation, lab preview

---

<!-- _class: lead -->

# 1 · Navigator 1.0

---

## The stack

```
   ┌─────────────────┐   ← top: EventDetailScreen   (pop removes this)
   │ ┌───────────────┴─┐
   └─┤ EventsScreen    │ ← bottom
     └─────────────────┘
```

- `MaterialApp` gives you a `Navigator`
- **push** a route on top; **pop** it off
- back button / back gesture ⇒ `pop`

---

## Push and pop

```dart
Navigator.push(context, route);   // put a route on top
Navigator.pop(context);           // remove the top route
```

- `MaterialPageRoute` = platform transition + automatic back button
- `Navigator.push(context, …)` uses the **nearest** navigator

Examples: `lib/exercises/named_routes_demo.dart` and
`lib/exercises/lecture_navigation.dart` (starter and solution).

---

## Data forward, result back

```dart
// lab/solution/lib/exercises/named_routes_demo.dart
Future<void> _chooseCampus() async {
  final campus = await Navigator.push<String>(
    context,
    MaterialPageRoute(builder: (context) => DemoCampusPage(current: _campus)),
  );
  if (!mounted || campus == null) return;
  setState(() => _campus = campus);
}

// in DemoCampusPage
onTap: () => Navigator.pop(context, campus),
```

Forward: **constructor arguments**. Back: **`pop(result)`**, typed via `push<T>`.
After the `await`: check `mounted`.

---

<!-- _class: pause -->

## What does `name` hold?

```dart
final name = await Navigator.push<String>(context, route);
```

…if the user presses the Android back button instead of Save?

---

<!-- _class: lead -->

# 2 · Named routes

---

## Named routes

```dart
// lab/solution/lib/exercises/named_routes_demo.dart
routes: {
  '/': (context) => const DemoHomePage(),
  '/events': (context) => const DemoEventListPage(),
},
onGenerateRoute: generateDemoRoute,     // names not in the map
onUnknownRoute: (settings) => …,        // when that returns null

Navigator.pushNamed(context, '/events');
```

Separates callers from screen classes. You will see it in older code.

---

## A parameter in a name

```dart
// lab/solution/lib/exercises/named_routes_demo.dart
Route<void>? generateDemoRoute(RouteSettings settings) {
  final segments = Uri.parse(settings.name ?? '').pathSegments;
  if (segments.length == 2 && segments[0] == 'events') {
    final id = int.tryParse(segments[1]);
    final event = demoEvents.where((e) => e.id == id).firstOrNull;
    if (event != null) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (context) => DemoEventPage(event: event),
      );
    }
  }
  return null;
}
```

---

<!-- _class: pause -->

## What does the user see?

The user taps *Career fair* in the list:
`Navigator.pushNamed(context, '/events/42')`.

Which function builds the page? With which id?
And for `'/events/5'`?

---

## Limits of named routes

1. **Parameters in the path** — `/events/42` needs manual parsing
2. **Nested navigation** — per-tab back stacks are hard
3. **Deep links and web URLs** — no declarative URL → screen mapping

Flutter's answer: the Router API (Navigator 2.0) — powerful, but a lot of code.
**`go_router`**: the Flutter team's package that makes it practical.

---

<!-- _class: lead -->

# 3 · go_router

---

## Paths in one place

```dart
// lab/solution/lib/exercises/lecture_navigation.dart
abstract final class LibraryRoutes {
  static const books      = '/books';
  static const bookDetail = '/books/:isbn';
  static const loans      = '/loans';
  static const chooseDesk = '/loans/desk';
  static const hours      = '/hours';

  static String bookFor(String isbn) => '/books/$isbn';
}
```

A typing mistake becomes a compile error, not a blank screen.

---

## Routes and nested routes

```dart
// lab/solution/lib/exercises/lecture_navigation.dart
GoRoute(
  path: LibraryRoutes.books,
  builder: (context, state) => const BooksPage(),
  routes: [
    GoRoute(                                   // '/books/:isbn'
      path: ':isbn',
      parentNavigatorKey: libraryRootKey,      // cover the bottom bar
      builder: (context, state) {
        final isbn = state.pathParameters['isbn']!;
        final book = libraryBooks.where((b) => b.isbn == isbn).firstOrNull;
        return BookPage(book: book);           // null → "Book not found"
      },
    ),
  ],
),
```

No `int.tryParse`, no `pathSegments`: `go_router` matches `:isbn` for you.

---

## Navigating

| Call | Effect |
|---|---|
| `context.go('/events/1')` | **replace** the stack (like clicking a link) |
| `context.push('/events/1')` | **push** on top; back returns |
| `context.pop(result)` | pop, optionally returning a result |
| `context.push<String>(…)` | typed result |

`push` for detail/edit flows · `go` for tabs and redirects

---

## Result via go_router

```dart
// lab/solution/lib/exercises/lecture_navigation.dart
Future<void> _chooseDesk() async {
  final uri = Uri(
    path: LibraryRoutes.chooseDesk,
    queryParameters: {'current': _desk},
  );
  final desk = await context.push<String>(uri.toString());
  if (!mounted || desk == null) return; // null: back without choosing
  setState(() => _desk = desk);
}

// in ChooseDeskPage
onTap: () => context.pop(desk),
```

`Uri(queryParameters:)` encodes spaces and Amharic correctly.

---

## Connecting the router to the app

```dart
// lab/solution/lib/app.dart
class CampusCompanionApp extends StatelessWidget {
  CampusCompanionApp({GoRouter? router, super.key})
      : _router = router ?? createRouter();
  final GoRouter _router;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Campus Companion',
        theme: ThemeData(colorSchemeSeed: const Color(0xFF00695C)),
        routerConfig: _router,
      );
}
```

`MaterialApp.router` replaces `home:`. Injectable router ⇒ tests can start anywhere.

---

## Errors

```dart
// lab/solution/lib/exercises/lecture_navigation.dart
errorBuilder: (context, state) => Scaffold(
  appBar: AppBar(title: const Text('Page not found')),
  body: Center(child: Text('Nothing at ${state.uri.path}')),
),
```

Try in Chrome: `#/books/333` · `#/books/999` · `#/shelves`

---

<!-- _class: lead -->

# 4 · Bottom navigation with per-tab stacks

---

## What users expect

Open a page on one tab → switch to another tab → switch back.
The page should **still be open**.

⇒ one navigator **per tab**, inside a shared frame.

`StatefulShellRoute.indexedStack`

---

## Route tree

```
Root navigator
├── StatefulShellRoute  (LibraryShell: AppBar + Drawer + NavigationBar)
│   ├── branch 0  /books
│   └── branch 1  /loans
├── /books/:isbn     (parentNavigatorKey: root — covers the bar)
├── /loans/desk      (root)
└── /hours           (outside the shell — root)
```

Inside a branch ⇒ the bar stays. On the root navigator ⇒ the bar is covered.

---

## The shell route

```dart
// lab/solution/lib/exercises/lecture_navigation.dart
StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) =>
      LibraryShell(navigationShell: navigationShell),
  branches: [
    StatefulShellBranch(routes: [GoRoute(path: LibraryRoutes.books, …)]),
    StatefulShellBranch(routes: [GoRoute(path: LibraryRoutes.loans, …)]),
  ],
),
```

---

## The shell widget

```dart
// lab/solution/lib/exercises/lecture_navigation.dart
Scaffold(
  appBar: AppBar(title: Text(_titles[navigationShell.currentIndex])),
  drawer: const LibraryDrawer(),
  body: navigationShell,
  bottomNavigationBar: NavigationBar(
    selectedIndex: navigationShell.currentIndex,
    onDestinationSelected: (index) => navigationShell.goBranch(
      index, initialLocation: index == navigationShell.currentIndex),
    destinations: const [
      NavigationDestination(icon: Icon(Icons.menu_book_outlined),
          selectedIcon: Icon(Icons.menu_book), label: 'Books'),
      …
    ],
  ),
)
```

One destination per branch, in the same order.
`NavigationBar` (M3) ≈ `BottomNavigationBar` (M2): `items/currentIndex/onTap`.

---

<!-- _class: pause -->

## Which screen is shown?

1. On **Books**, open *Oromay*
2. Tap **Loans**
3. Tap **Books**
4. Tap **Books** again

---

<!-- _class: lead -->

# 5 · Drawer, TabBar, BottomAppBar

---

## Drawer + ListView

```dart
// lab/solution/lib/exercises/lecture_navigation.dart
Drawer(
  child: ListView(padding: EdgeInsets.zero, children: [
    const DrawerHeader(child: Text('Campus library')),
    ListTile(
      leading: const Icon(Icons.schedule),
      title: const Text('Opening hours'),
      onTap: () {
        Navigator.pop(context);      // close the drawer FIRST
        context.push(LibraryRoutes.hours);
      },
    ),
  ]),
)
```

Drawer = secondary destinations. Bottom bar = 3–5 primary ones.
`AboutListTile`: name, version and licences, ready-made.

---

## TabBar + TabBarView

```dart
// lab/solution/lib/exercises/lecture_navigation.dart
DefaultTabController(
  length: 2,
  child: Column(children: [
    const TabBar(tabs: [Tab(text: 'Available'), Tab(text: 'On loan')]),
    Expanded(                                   // week 3 rule!
      child: TabBarView(children: [
        _BookList(books: available, emptyText: 'No books available'),
        _BookList(books: onLoan,    emptyText: 'No books on loan'),
      ]),
    ),
  ]),
)
```

Tabs split **one screen's** content. `DefaultTabController` keeps the screen stateless.

---

## BottomAppBar

```dart
// lab/solution/lib/exercises/lecture_navigation.dart
floatingActionButton: FloatingActionButton(
  tooltip: 'Reserve', onPressed: …, child: const Icon(Icons.bookmark_add)),
floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
bottomNavigationBar: BottomAppBar(
  shape: const CircularNotchedRectangle(),
  child: Row(children: [
    IconButton(tooltip: 'Share', icon: const Icon(Icons.share), onPressed: () {}),
    const Spacer(),
    IconButton(tooltip: 'Report a problem', icon: const Icon(Icons.flag_outlined), onPressed: () {}),
  ]),
),
```

Actions on **this** content, with a docked FAB. Not navigation.

---

## Which widget?

| Need | Widget |
|---|---|
| 3–5 top-level sections | `NavigationBar` in a shell route |
| secondary pages (about, help, settings) | `Drawer`, or an icon in the `AppBar` |
| sub-views of one screen | `TabBar` + `TabBarView` |
| actions on the current screen | `BottomAppBar` (+ docked FAB) |
| open detail / editor | `context.push`, usually on the root navigator |

---

<!-- _class: lead -->

# 6 · Testing navigation

---

## A real router in a widget test

```dart
// lab/solution/test/exercises/lecture_navigation_test.dart
testWidgets('an unknown ISBN shows "Book not found"', (tester) async {
  await pumpLibrary(tester, initial: '/books/999');
  expect(find.text('Book not found'), findsOneWidget);
});
```

`pumpLibrary` = `pumpWidget(LibraryApp(router: createLibraryRouter(initialLocation: …)))`
\+ `pumpAndSettle()`. Starting deep = a deep-link test.

**Test first:** write it, watch it fail, then add the route.

---

## Lab topics

1. Read and predict: named routes and `onGenerateRoute`
2. `Navigator.push` to the detail; its `BottomAppBar` + docked FAB
3. Two more shell branches + `NavigationBar` destinations
4. Not-found tests first, then `/events/:id` and the error page
5. Drawer with Check-in and About
6. Edit profile returns a result
7. Upcoming / Past tabs on the feed
8. Your own design: where does Settings go?

Checkpoint A after task 4, Checkpoint B after task 8, then the exit task.

---

## Before the next lecture

- Read: *State management* introduction (docs.flutter.dev/data-and-backend/state-mgmt/intro)
  and the Riverpod *Getting started* page (riverpod.dev)
- Milestone 1 is due after week 6 — plan your screens now

---

<!-- _class: lead -->
<!-- _paginate: false -->

# Questions?

Notes, lab and quiz: github.com/betsegawlemma/mobile-application-development-course
