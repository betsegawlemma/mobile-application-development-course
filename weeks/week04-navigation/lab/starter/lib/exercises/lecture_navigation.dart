// Week 4 lecture navigation — the worked go_router examples shown in the
// notes and slides, and built in the live coding. A small campus library
// app. Each lab task is similar to one example here, but not the same:
//
//   BookPage: BottomAppBar + docked FAB  <->  EventDetailScreen  (lab Task 2)
//   two shell branches (Books, Loans)    <->  four branches      (lab Task 3)
//   /books/:isbn on the root navigator   <->  /events/:id        (lab Task 4)
//   LibraryDrawer, 'Opening hours'       <->  AppDrawer          (lab Task 5)
//   choose a desk, result via pop        <->  edit profile       (lab Task 6)
//   Available / On loan tabs             <->  Upcoming / Past    (lab Task 7)
//
// Run it on its own:
//   flutter run -d chrome -t lib/exercises/lecture_navigation.dart
// The tests in test/exercises/lecture_navigation_test.dart show how it
// behaves.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(LibraryApp());

class Book {
  const Book({
    required this.isbn,
    required this.title,
    required this.author,
    this.onLoan = false,
  });

  final String isbn;
  final String title;
  final String author;
  final bool onLoan;
}

const libraryBooks = [
  Book(isbn: '111', title: 'Fikir Eskemekabir', author: 'Haddis Alemayehu'),
  Book(
    isbn: '222',
    title: 'Clean Code',
    author: 'Robert C. Martin',
    onLoan: true,
  ),
  Book(isbn: '333', title: 'Oromay', author: 'Baalu Girma'),
];

/// Library paths in one place.
abstract final class LibraryRoutes {
  static const books = '/books';
  static const bookDetail = '/books/:isbn';
  static const loans = '/loans';
  static const chooseDesk = '/loans/desk';
  static const hours = '/hours';

  static String bookFor(String isbn) => '/books/$isbn';
}

final libraryRootKey = GlobalKey<NavigatorState>(debugLabel: 'library root');

GoRouter createLibraryRouter({String initialLocation = LibraryRoutes.books}) {
  return GoRouter(
    navigatorKey: libraryRootKey,
    initialLocation: initialLocation,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            LibraryShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: LibraryRoutes.books,
                builder: (context, state) => const BooksPage(),
                routes: [
                  // '/books/:isbn', on the root navigator: it covers the bar.
                  GoRoute(
                    path: ':isbn',
                    parentNavigatorKey: libraryRootKey,
                    builder: (context, state) {
                      final isbn = state.pathParameters['isbn']!;
                      final book = libraryBooks
                          .where((b) => b.isbn == isbn)
                          .firstOrNull;
                      return BookPage(book: book);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: LibraryRoutes.loans,
                builder: (context, state) => const LoansPage(),
                routes: [
                  GoRoute(
                    path: 'desk',
                    parentNavigatorKey: libraryRootKey,
                    builder: (context, state) => ChooseDeskPage(
                      current: state.uri.queryParameters['current'] ?? '',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: LibraryRoutes.hours,
        builder: (context, state) => const OpeningHoursPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: Center(child: Text('Nothing at ${state.uri.path}')),
    ),
  );
}

class LibraryApp extends StatelessWidget {
  LibraryApp({GoRouter? router, super.key})
    : _router = router ?? createLibraryRouter();

  final GoRouter _router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Campus library',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF5D4037),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

/// The frame around the two branches.
class LibraryShell extends StatelessWidget {
  const LibraryShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _titles = ['Books', 'Loans'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[navigationShell.currentIndex])),
      drawer: const LibraryDrawer(),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Books',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_return_outlined),
            selectedIcon: Icon(Icons.assignment_return),
            label: 'Loans',
          ),
        ],
      ),
    );
  }
}

class LibraryDrawer extends StatelessWidget {
  const LibraryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(child: Text('Campus library')),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('Opening hours'),
            onTap: () {
              Navigator.pop(context); // close the drawer first
              context.push(LibraryRoutes.hours);
            },
          ),
        ],
      ),
    );
  }
}

/// Two tabs inside one branch: the books that are available and the books
/// that are on loan.
class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final available = libraryBooks.where((b) => !b.onLoan).toList();
    final onLoan = libraryBooks.where((b) => b.onLoan).toList();

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Available'),
              Tab(text: 'On loan'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _BookList(books: available, emptyText: 'No books available'),
                _BookList(books: onLoan, emptyText: 'No books on loan'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BookList extends StatelessWidget {
  const _BookList({required this.books, required this.emptyText});

  final List<Book> books;
  final String emptyText;

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) return Center(child: Text(emptyText));
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return ListTile(
          title: Text(book.title),
          subtitle: Text(book.author),
          onTap: () => context.push(LibraryRoutes.bookFor(book.isbn)),
        );
      },
    );
  }
}

/// One book. [book] is null when the ISBN in the URL matches no book.
class BookPage extends StatelessWidget {
  const BookPage({required this.book, super.key});

  final Book? book;

  @override
  Widget build(BuildContext context) {
    final book = this.book;
    if (book == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Book not found')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: ListTile(title: Text(book.title), subtitle: Text(book.author)),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Reserve',
        onPressed: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Reserved ${book.title}')));
        },
        child: const Icon(Icons.bookmark_add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(
              tooltip: 'Share',
              icon: const Icon(Icons.share),
              onPressed: () {},
            ),
            const Spacer(),
            IconButton(
              tooltip: 'Report a problem',
              icon: const Icon(Icons.flag_outlined),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

/// Shows the pick-up desk and lets the user change it on another page.
class LoansPage extends StatefulWidget {
  const LoansPage({super.key});

  @override
  State<LoansPage> createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  String _desk = 'Main desk';

  Future<void> _chooseDesk() async {
    // Uri encodes the query parameter (spaces, Amharic, '&').
    final uri = Uri(
      path: LibraryRoutes.chooseDesk,
      queryParameters: {'current': _desk},
    );
    final desk = await context.push<String>(uri.toString());
    if (!mounted || desk == null) return; // null: back without choosing
    setState(() => _desk = desk);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Pick-up desk: $_desk'),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: _chooseDesk,
          child: const Text('Change desk'),
        ),
      ],
    );
  }
}

/// Returns the chosen desk with context.pop(value).
class ChooseDeskPage extends StatelessWidget {
  const ChooseDeskPage({required this.current, super.key});

  final String current;

  static const desks = ['Main desk', 'Science library', 'Law library'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick-up desk')),
      body: ListView(
        children: [
          for (final desk in desks)
            ListTile(
              title: Text(desk),
              trailing: desk == current ? const Icon(Icons.check) : null,
              onTap: () => context.pop(desk),
            ),
        ],
      ),
    );
  }
}

class OpeningHoursPage extends StatelessWidget {
  const OpeningHoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Opening hours')),
      body: const Center(child: Text('Monday to Saturday, 8:00 to 20:00')),
    );
  }
}
