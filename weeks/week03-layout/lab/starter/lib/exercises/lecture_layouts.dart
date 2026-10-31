// Week 3 lecture layouts — the worked examples shown in the notes and
// slides, and built in the live coding. Each lab task is similar to one
// example here, but not the same:
//
//   ContactTile  <->  EventCard      (lab Task 2)
//   RoomsPage    <->  EventsScreen   (lab Task 3)
//   CoursePage   <->  ProfileScreen  (lab Task 4)
//
// Run them on their own:
//   flutter run -d chrome -t lib/exercises/lecture_layouts.dart
// The tests in test/exercises/lecture_layouts_test.dart show how they
// behave.

import 'package:flutter/material.dart';

void main() => runApp(const LectureLayoutsApp());

/// A small app that shows the three examples, one at a time.
class LectureLayoutsApp extends StatelessWidget {
  const LectureLayoutsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lecture layouts',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF00695C),
        useMaterial3: true,
      ),
      home: const LectureLayoutsHome(),
    );
  }
}

enum _Example { contacts, rooms, course }

class LectureLayoutsHome extends StatefulWidget {
  const LectureLayoutsHome({super.key});

  @override
  State<LectureLayoutsHome> createState() => _LectureLayoutsHomeState();
}

class _LectureLayoutsHomeState extends State<LectureLayoutsHome> {
  _Example _example = _Example.contacts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lecture layouts')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SegmentedButton<_Example>(
              segments: const [
                ButtonSegment(
                  value: _Example.contacts,
                  label: Text('Contacts'),
                ),
                ButtonSegment(value: _Example.rooms, label: Text('Rooms')),
                ButtonSegment(value: _Example.course, label: Text('Course')),
              ],
              selected: {_example},
              onSelectionChanged: (selection) =>
                  setState(() => _example = selection.first),
            ),
          ),
          Expanded(
            child: switch (_example) {
              _Example.contacts => ListView(
                padding: const EdgeInsets.all(8),
                children: const [
                  ContactTile(
                    name: 'Hanna Tesfaye Gebremedhin Wolde',
                    role: 'Lecturer',
                    office: 'Room 214, Science faculty',
                    online: true,
                  ),
                  ContactTile(
                    name: 'Yonas Alemu',
                    role: 'Lab assistant',
                    office: 'Lab 3',
                  ),
                ],
              ),
              _Example.rooms => const RoomsPage(rooms: sampleRooms),
              _Example.course => const CoursePage(
                code: 'CS 341',
                title: 'Mobile Applications Development',
                credits: 5,
              ),
            },
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// ContactTile: a Row of a fixed-size box, an Expanded column and an icon.
// ---------------------------------------------------------------------------

/// One person in a staff list.
class ContactTile extends StatelessWidget {
  const ContactTile({
    required this.name,
    required this.role,
    required this.office,
    this.online = false,
    super.key,
  });

  final String name;
  final String role;
  final String office;
  final bool online;

  String get initials => name
      .split(' ')
      .where((w) => w.isNotEmpty)
      .take(2)
      .map((w) => w[0])
      .join();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // A Container with a decoration: the colour goes inside the
            // BoxDecoration, never next to it.
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Text(
                initials,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colors.onSecondaryContainer,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Expanded gives the column the width that is left, so a long
            // name gets a bounded width and can end in "...". Remove it and
            // a long name overflows to the right.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Text.rich: several styles in one paragraph. It uses the
                  // default text style of the screen as its base.
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
                ],
              ),
            ),
            if (online)
              Icon(
                Icons.circle,
                size: 12,
                color: colors.primary,
                semanticLabel: 'Online',
              ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// RoomsPage: a list on narrow screens, a grid on wide ones.
// ---------------------------------------------------------------------------

const sampleRooms = [
  'Lab 1',
  'Lab 2',
  'Lab 3',
  'Room 101',
  'Room 102',
  'Room 214',
  'Library reading room',
  'Main hall',
  'Seminar room A',
  'Seminar room B',
];

/// A list of rooms. LayoutBuilder gives the constraints of *this* widget,
/// so the page decides by the width it really has, not by the device.
class RoomsPage extends StatelessWidget {
  const RoomsPage({required this.rooms, super.key});

  final List<String> rooms;

  static const wideBreakpoint = 600.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= wideBreakpoint) {
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 72,
            ),
            itemCount: rooms.length,
            itemBuilder: (context, index) => _RoomTile(name: rooms[index]),
          );
        }
        // ListView.builder builds only the items that are visible.
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: rooms.length,
          itemBuilder: (context, index) => _RoomTile(name: rooms[index]),
        );
      },
    );
  }
}

class _RoomTile extends StatelessWidget {
  const _RoomTile({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.meeting_room),
        title: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CoursePage: three equal figures, a group of buttons, and a layout that
// changes with the orientation.
// ---------------------------------------------------------------------------

/// A course overview page.
class CoursePage extends StatelessWidget {
  const CoursePage({
    required this.code,
    required this.title,
    required this.credits,
    super.key,
  });

  final String code;
  final String title;
  final int credits;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // orientationOf rebuilds this widget only when the orientation changes.
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    final header = Column(
      children: [
        CircleAvatar(
          radius: 40,
          child: Icon(Icons.school, size: 40, color: theme.colorScheme.primary),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: theme.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        Text('$code · $credits credits', style: theme.textTheme.bodyMedium),
      ],
    );

    final figures = Row(
      children: [
        // Expanded shares the row's width equally between the figures.
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

    // Wrap: the buttons go onto a second line when the width runs out.
    final actions = Wrap(
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
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: isLandscape
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: header),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    children: [figures, const SizedBox(height: 16), actions],
                  ),
                ),
              ],
            )
          : Column(
              children: [
                header,
                const SizedBox(height: 24),
                figures,
                const SizedBox(height: 16),
                actions,
              ],
            ),
    );
  }
}

class _Figure extends StatelessWidget {
  const _Figure({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(value, style: theme.textTheme.headlineSmall),
        Text(label, style: theme.textTheme.labelMedium),
      ],
    );
  }
}
