// Week 4 named routes demo — Navigator 1.0 with MaterialApp.routes,
// onGenerateRoute and onUnknownRoute. Lab Task 1 asks you to read this
// file and predict what it does before you run it.
//
// Run it in a browser and open an address yourself:
//   flutter run -d web-server --web-port 8090 -t lib/exercises/named_routes_demo.dart
//   then open http://localhost:8090/#/events/42
// Or run it like any app:
//   flutter run -d chrome -t lib/exercises/named_routes_demo.dart
// The tests in test/exercises/named_routes_demo_test.dart show how it
// behaves.

import 'package:flutter/material.dart';

void main() => runApp(const NamedRoutesDemoApp());

/// A very small event: an id that appears in the URL, and a title.
class DemoEvent {
  const DemoEvent(this.id, this.title);

  final int id;
  final String title;
}

const demoEvents = [
  DemoEvent(7, 'Chess club final'),
  DemoEvent(42, 'Career fair'),
  DemoEvent(108, 'Blood donation day'),
];

/// The demo app. [initialRoute] lets a test start at any route name; in a
/// browser, the address after `#` is used instead.
class NamedRoutesDemoApp extends StatelessWidget {
  const NamedRoutesDemoApp({this.initialRoute, super.key});

  final String? initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named routes demo',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF00695C),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      // 1. Fixed names: one entry for each screen that needs no data.
      routes: {
        '/': (context) => const DemoHomePage(),
        '/events': (context) => const DemoEventListPage(),
      },
      // 2. A name that is not in the table above comes here.
      onGenerateRoute: generateDemoRoute,
      // 3. When onGenerateRoute returns null as well, this route is used.
      onUnknownRoute: (settings) => MaterialPageRoute<void>(
        settings: settings,
        builder: (context) => DemoNotFoundPage(name: settings.name ?? ''),
      ),
    );
  }
}

/// Builds the route for a name such as `/events/42`, or returns null.
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

/// The first screen. It also shows Navigator 1.0 without names: it pushes
/// a route object and waits for a result.
class DemoHomePage extends StatefulWidget {
  const DemoHomePage({super.key});

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  String _campus = 'Sidist Kilo';

  Future<void> _chooseCampus() async {
    // Data goes forward in the constructor; the result comes back from
    // Navigator.pop. It is null when the user goes back without choosing.
    final campus = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => DemoCampusPage(current: _campus)),
    );
    if (!mounted || campus == null) return;
    setState(() => _campus = campus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Named routes demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Campus: $_campus'),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: _chooseCampus,
            child: const Text('Choose a campus'),
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () => Navigator.pushNamed(context, '/events'),
            child: const Text('All events'),
          ),
        ],
      ),
    );
  }
}

class DemoEventListPage extends StatelessWidget {
  const DemoEventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: ListView(
        children: [
          for (final event in demoEvents)
            ListTile(
              title: Text(event.title),
              subtitle: Text('/events/${event.id}'),
              onTap: () => Navigator.pushNamed(context, '/events/${event.id}'),
            ),
        ],
      ),
    );
  }
}

class DemoEventPage extends StatelessWidget {
  const DemoEventPage({required this.event, super.key});

  final DemoEvent event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Event ${event.id}')),
      body: Center(child: Text(event.title)),
    );
  }
}

class DemoNotFoundPage extends StatelessWidget {
  const DemoNotFoundPage({required this.name, super.key});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unknown route')),
      body: Center(child: Text('No screen for $name')),
    );
  }
}

/// Returns the chosen campus with Navigator.pop(context, value).
class DemoCampusPage extends StatelessWidget {
  const DemoCampusPage({required this.current, super.key});

  final String current;

  static const campuses = ['Sidist Kilo', 'Amist Kilo', 'Arat Kilo'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose a campus')),
      body: ListView(
        children: [
          for (final campus in campuses)
            ListTile(
              title: Text(campus),
              trailing: campus == current ? const Icon(Icons.check) : null,
              onTap: () => Navigator.pop(context, campus),
            ),
        ],
      ),
    );
  }
}
