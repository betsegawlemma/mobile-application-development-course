import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/about_screen.dart';
import '../screens/check_in_screen.dart';
import '../screens/events_screen.dart';
import '../screens/profile_screen.dart';
import 'app_shell.dart';

/// Route paths in one place so screens never hard-code strings twice.
abstract final class Routes {
  static const events = '/events';
  static const eventDetail = '/events/:id';
  static const notes = '/notes';
  static const lostFound = '/lost-found';
  static const profile = '/profile';
  static const editProfile = '/profile/edit';
  static const checkIn = '/check-in';
  static const about = '/about';

  static String eventDetailFor(String id) => '/events/$id';
}

/// The root navigator hosts full-screen routes (detail, edit, about) that
/// cover the bottom navigation bar. Each shell branch has its own
/// navigator, which is what keeps the tab's back stack when you switch
/// tabs and come back.
final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

GoRouter createRouter({String initialLocation = Routes.events}) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialLocation,
    debugLogDiagnostics: false,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.events,
                builder: (context, state) => const EventsScreen(),
                // TODO(lab): Task 4 — add a nested GoRoute(path: ':id') that
                // builds EventDetailScreen for state.pathParameters['id']
                // (null event when no sample event matches). Give it
                // parentNavigatorKey: rootNavigatorKey so it covers the
                // navigation bar.
              ),
            ],
          ),
          // TODO(lab): Task 3 — add branches for Routes.notes (NotesScreen)
          // and Routes.lostFound (LostFoundScreen), in that order, between
          // events and profile. Then add the matching destinations in
          // AppShell.
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile,
                builder: (context, state) => const ProfileScreen(),
                // TODO(lab): Task 6 — nested GoRoute(path: 'edit') on the
                // root navigator that builds EditProfileScreen with
                // initialName from state.uri.queryParameters['name'].
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Routes.checkIn,
        builder: (context, state) => const CheckInScreen(),
      ),
      GoRoute(
        path: Routes.about,
        builder: (context, state) => const AboutScreen(),
      ),
    ],
    // TODO(lab): Task 4 — an errorBuilder for locations that match no
    // route: a Scaffold with the AppBar title 'Not found' and the text
    // 'No route for <location>' (state.uri). Write its test first.
  );
}
