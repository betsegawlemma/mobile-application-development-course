import 'package:flutter/material.dart';

import 'check_in_screen.dart';
import 'events_screen.dart';
import 'profile_screen.dart';

/// Home screen with three sections. The SegmentedButton switch is a
/// stand-in for real navigation, which arrives in week 4.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum _Section { events, profile, checkIn }

class _HomeScreenState extends State<HomeScreen> {
  _Section _section = _Section.events;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campus Companion')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SegmentedButton<_Section>(
              segments: const [
                ButtonSegment(
                  value: _Section.events,
                  label: Text('Events'),
                  icon: Icon(Icons.event),
                ),
                ButtonSegment(
                  value: _Section.profile,
                  label: Text('Profile'),
                  icon: Icon(Icons.person),
                ),
                ButtonSegment(
                  value: _Section.checkIn,
                  label: Text('Check-in'),
                  icon: Icon(Icons.how_to_reg),
                ),
              ],
              selected: {_section},
              onSelectionChanged: (selection) =>
                  setState(() => _section = selection.first),
            ),
          ),
          // Expanded gives the section the rest of the column's height;
          // without it a ListView inside a Column has unbounded height and
          // throws.
          Expanded(
            child: switch (_section) {
              _Section.events => const EventsScreen(),
              _Section.profile => const ProfileScreen(),
              _Section.checkIn => const CheckInScreen(),
            },
          ),
        ],
      ),
    );
  }
}
