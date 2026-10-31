// Lab Task 8 — Your own design: where does Settings go?
//
// A small app with the same shape as Campus Companion: three tabs in a
// StatefulShellRoute, an AppBar and a Drawer. The requirement:
//
//   Settings must be reachable from every tab and must hide the bottom bar.
//
// Decide how the user opens Settings and on which navigator its route
// goes. Write your two decisions in DECISIONS.md, then implement them.
//
// Run it:  flutter run -d chrome -t lib/exercises/settings_design.dart
// Test it: flutter test test/exercises/settings_design_test.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(SettingsDesignApp());

abstract final class DesignRoutes {
  static const home = '/home';
  static const timetable = '/timetable';
  static const map = '/map';
  static const settings = '/settings';
}

final designRootKey = GlobalKey<NavigatorState>(debugLabel: 'design root');

GoRouter createDesignRouter({String initialLocation = DesignRoutes.home}) {
  return GoRouter(
    navigatorKey: designRootKey,
    initialLocation: initialLocation,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            DesignShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: DesignRoutes.home,
                builder: (context, state) => const _TabPage('Home'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: DesignRoutes.timetable,
                builder: (context, state) => const _TabPage('Timetable'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: DesignRoutes.map,
                builder: (context, state) => const _TabPage('Map'),
              ),
            ],
          ),
        ],
      ),
      // TODO(lab): Task 8 — the route for DesignRoutes.settings. Which
      // navigator must it be on so that it hides the bottom bar?
    ],
  );
}

class SettingsDesignApp extends StatelessWidget {
  SettingsDesignApp({GoRouter? router, super.key})
    : _router = router ?? createDesignRouter();

  final GoRouter _router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Settings design',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF00695C),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

class DesignShell extends StatelessWidget {
  const DesignShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _titles = ['Home', 'Timetable', 'Map'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[navigationShell.currentIndex])),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(child: Text('Settings design')),
            const AboutListTile(
              icon: Icon(Icons.info_outline),
              applicationName: 'Settings design',
            ),
          ],
        ),
      ),
      // TODO(lab): Task 8 — a way to open Settings from every tab. Choose
      // where it goes and write the reason in DECISIONS.md.
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.schedule), label: 'Timetable'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
        ],
      ),
    );
  }
}

class _TabPage extends StatelessWidget {
  const _TabPage(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('The $name tab'));
  }
}

/// The Settings screen itself is given. Where it goes is your decision.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: const [
          ListTile(title: Text('Theme'), subtitle: Text('Same as the system')),
          ListTile(title: Text('Language'), subtitle: Text('English')),
          ListTile(title: Text('Show past events'), subtitle: Text('On')),
        ],
      ),
    );
  }
}
