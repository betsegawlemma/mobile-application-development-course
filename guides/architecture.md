# Architecture

The structure every week of this course uses, and the reasoning behind
it. Milestone 1 and the final rubric are assessed against it.

## The shape

```
lib/
├── main.dart                     ProviderScope + runApp + Firebase start-up
├── app.dart                      MaterialApp.router, theme, locale
├── core/                         shared by every feature
│   ├── router/                   router.dart, app_shell.dart
│   ├── theme/                    app_theme.dart
│   ├── network/                  dio_provider.dart, app_exception.dart
│   ├── device/                   permission, location, photo, sensors
│   ├── firebase/                 bootstrap and options
│   └── presentation/             screens with no feature of their own
└── features/
    ├── events/
    │   ├── domain/               event.dart                  (pure Dart)
    │   ├── data/                 repository, providers, DTOs
    │   └── presentation/         screens and widgets
    ├── notes/      domain/ data/ presentation/
    ├── profile/    domain/ data/ presentation/
    ├── auth/       domain/ data/ presentation/
    ├── lost_found/ domain/ data/ presentation/
    ├── ai/         domain/ data/ presentation/
    └── settings/   domain/ data/ presentation/
```

**Feature first.** Everything about notes is in one folder. To
understand a feature you open one directory; to delete one you delete a
directory. Grouping by type (`screens/`, `widgets/`, `models/`) works
until about fifty files, after which every feature is spread across four
places.

## The three layers

```
presentation  ──►  data  ──►  domain
 widgets,           repositories,      models,
 ref.watch,         notifiers,         business rules,
 no business logic  providers, DTOs    pure Dart
```

**domain** — what the app is about. `Event`, `Note`, `LostItem`,
`AppUser`, `Summary`. Immutable (`freezed`), with the rules that belong
to the data itself (`Event.isUpcoming`, `LostItem.isOwnedBy`). No
Flutter imports, no I/O, no packages beyond `freezed_annotation`.

**data** — where the data comes from and how it changes. Repository
interfaces and their implementations, DTOs for wire formats, Riverpod
notifiers and providers. Knows about domain; knows nothing about
widgets.

**presentation** — widgets. Watches providers, calls notifier methods,
renders. Contains no business logic and no plugin types.

**The dependency rule:** dependencies point inward. A domain file that
imports `package:flutter/material.dart` is a warning sign; a widget that
constructs a repository is another.

## Repositories

Every external thing is behind an interface:

| Feature | Interface | Implementations |
|---|---|---|
| events | `EventsRepository` | `InMemory…` (weeks 5–8), `Rest…` (week 9), fakes in tests |
| notes | `NotesRepository` | `InMemory…`, `Drift…` (week 8) |
| auth | `AuthRepository` | `FirebaseAuth…` (week 10), fake |
| lost & found | `LostFoundRepository` | `Firestore…` (week 10), `FakeFirebaseFirestore` |
| settings | `SettingsRepository` | `SharedPrefs…` (week 8) |
| location, photos, permissions | `LocationService`, `PhotoService`, `PermissionService` | plugin-backed, fakes |
| AI | `Summariser` | stub, cloud (week 13) |

This is what made weeks 9, 10 and 11 possible without rewriting screens:
the events feed moved from sample data to HTTP by changing one provider.
It is also what makes the app testable at all — a widget test cannot
call a real camera.

```dart
@riverpod
EventsRepository eventsRepository(Ref ref) =>
    RestEventsRepository(ref.watch(dioProvider));
```

```dart
// in a test
ProviderScope(overrides: [
  eventsRepositoryProvider.overrideWithValue(FakeEventsRepository()),
])
```

## Errors

One sealed family (`core/network/app_exception.dart`), whatever the
source:

```
AppException
├── NetworkException      offline, timeout
├── ServerException       5xx
├── NotFoundException     404
├── ValidationException   400/422, refused permission, rejected input
└── ParseException        the response was not the shape we expected
```

The data layer translates `DioException`, `FirebaseAuthException`,
`FirebaseException` and `FormatException` into these. The UI switches
over them and never imports dio or Firebase. Because the class is
`sealed`, adding a case makes every incomplete `switch` fail to compile.

## State

- **Ephemeral state** (a text controller, a selected tab, "is this
  expanded") stays in the widget, in `setState`.
- **Application state** (notes, events, the signed-in user, settings)
  lives in a Riverpod provider.
- Notifiers assign a **new** state object; models are immutable, and
  lists are rebuilt with a collection literal.
- Derived values are providers (`sortedNotes`), not code in `build`.
- Asynchronous state is an `AsyncValue`, so loading and error are
  handled by the type system rather than by booleans.

## Naming

| Thing | Convention | Example |
|---|---|---|
| File | `snake_case.dart` | `events_repository.dart` |
| Domain model | noun | `Event`, `LostItem` |
| Repository interface | `<Thing>Repository` | `NotesRepository` |
| Implementation | `<Source><Thing>Repository` | `DriftNotesRepository` |
| DTO | `<Thing>Dto` | `EventDto` |
| Notifier | plural or `<Thing>Notifier` | `Notes`, `ProfileNotifier` |
| Screen | `<Thing>Screen` | `EventDetailScreen` |
| Route constant | in `Routes` | `Routes.eventDetail` |
| Test | mirrors the file | `test/features/notes/note_test.dart` |

## Where things go — a decision table

| I am adding… | It goes in |
|---|---|
| a field on an existing model | `features/<f>/domain/` |
| a rule about that data ("is it upcoming?") | the model, in `domain/` |
| a call to an API | `features/<f>/data/` behind the repository interface |
| a conversion from JSON | a DTO in `features/<f>/data/dto/` |
| sorting or filtering for a screen | a provider in `features/<f>/data/` |
| a button, a layout, an animation | `features/<f>/presentation/` |
| something two features need | `core/` |
| a new screen for a new concern | a new feature folder |

## What this is not

It is not "clean architecture" with use-case classes for every
operation. That adds a layer this size of app does not need. If a
feature grows beyond a few repository methods, a use-case class is a
reasonable next step — but start without one.

## Further reading

- Flutter's own architecture recommendations: https://docs.flutter.dev/app-architecture
- `guides/state-management-comparison.md` in this repository
- Week 5 notes, which introduce all of this with the code
