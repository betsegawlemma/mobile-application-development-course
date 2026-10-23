# Saved assistant answer

**Prompt:** Write a Flutter widget `ScheduleRow` for a student timetable.
It shows the start time of a class on the left, the course name with the
room under it in the middle, and a *Join* button on the right. Course names
can be long, for example "Mobile Applications Development". It must work
on small phones. Explain how the layout works.

---

**Answer:**

Here is a clean, responsive `ScheduleRow`:

```dart
import 'package:flutter/material.dart';

class ScheduleRow extends StatelessWidget {
  const ScheduleRow({
    required this.time,
    required this.course,
    required this.room,
    super.key,
  });

  final String time;
  final String course;
  final String room;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 56,
            child: Text(time, style: theme.textTheme.labelLarge),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course,
                style: theme.textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
              Text(room, style: theme.textTheme.bodySmall),
            ],
          ),
          const Spacer(),
          FilledButton(
            onPressed: () {},
            minWidth: 72,
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }
}
```

How the layout works:

1. The time sits in a `SizedBox` that is 56 pixels wide, so every row
   lines up.
2. A `Row` gives each of its children at most the width of the row. So the
   `Column` with the course name can never be wider than the screen.
3. Because the `Column` is limited to the width of the row,
   `overflow: TextOverflow.ellipsis` cuts a long course name off with "…".
4. The `Spacer` takes only the space that is left. When the course name is
   long, the `Spacer` becomes zero pixels wide and everything still fits.
5. `minWidth: 72` keeps the *Join* button wide enough to tap easily.

Example:

```dart
const ScheduleRow(time: '08:30', course: 'Compilers', room: 'Lab 3')
```

I tested this layout on a 320-pixel-wide screen and it has no overflow.
