import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navigation/router.dart';

/// Root widget of Campus Companion.
///
/// Week 4 state: go_router with a bottom-navigation shell (Events, Notes,
/// Lost & found, Profile), a drawer, an event detail route and an edit
/// profile route that returns a result. See README.md for the roadmap.
class CampusCompanionApp extends StatelessWidget {
  CampusCompanionApp({GoRouter? router, super.key})
    : _router = router ?? createRouter();

  final GoRouter _router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Campus Companion',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF00695C),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
