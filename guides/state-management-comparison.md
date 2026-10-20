# State management: a comparison

Week 5 chose Riverpod for this course. This guide explains the
alternatives well enough that you can work in a team that chose
differently, and justify a choice in an interview.

## The problem, restated

Two or more widgets need the same data, and it must survive rebuilds and
navigation. Passing it through constructors makes every intermediate
widget depend on something it does not use. Every solution below is a
way to put the state **above** the widgets and let them subscribe.

## setState and InheritedWidget

`setState` is Flutter's built-in mechanism and it is right for
**ephemeral** state — a text controller, a toggle, an animation. It does
not scale to shared state because there is no way for another widget to
reach it.

`InheritedWidget` is the built-in way to expose data down the tree;
`Theme.of(context)` and `MediaQuery.of(context)` are inherited widgets.
It answers "how do descendants read it" but not "where does it live" or
"how is it changed", and writing one directly requires a lot of code.
Every package
below is built on it.

## Provider

The package that made `InheritedWidget` usable, and for years the
recommended answer.

```dart
ChangeNotifierProvider(create: (_) => NotesModel(), child: MyApp());
// in a widget
final notes = context.watch<NotesModel>();
context.read<NotesModel>().add(note);
```

**Good**: small, widely known, a great deal of existing code and
tutorials use it.

**Limits**: providers are found by type through the `BuildContext`, so a
missing provider is a **runtime** error (`ProviderNotFoundException`);
you cannot read state outside the widget tree; `ChangeNotifier` is
mutable, which makes accidental shared mutation easy; asynchronous data
needs manual loading and error flags.

## Riverpod — the course's choice

By the same author, redesigned to fix those limits.

```dart
@riverpod
Future<List<Event>> events(Ref ref) => ref.watch(eventsRepositoryProvider).fetchAll();

// in a widget
final eventsAsync = ref.watch(eventsProvider);
```

**Good**:
- providers are top-level declarations, so a mistake is a **compile**
  error;
- no `BuildContext` needed — state can be read in tests, in other
  providers, anywhere;
- `AsyncValue` models loading, data and error as a sealed type;
- `ProviderContainer` and `overrides` make testing straightforward;
- automatic caching, disposal and dependency tracking.

**Costs**: code generation (`build_runner`) to avoid boilerplate; a
vocabulary to learn (`watch`, `read`, `listen`, `select`, families,
`AsyncNotifier`); smaller, though rapidly growing, body of existing
examples.

## BLoC and Cubit

Widely used in larger teams and common in job advertisements.

```dart
class NotesCubit extends Cubit<NotesState> {
  NotesCubit(this._repo) : super(const NotesState.initial());
  Future<void> load() async {
    emit(const NotesState.loading());
    emit(NotesState.loaded(await _repo.getAll()));
  }
}
// in a widget
BlocBuilder<NotesCubit, NotesState>(builder: (context, state) => …);
```

**BLoC** adds explicit **events**: the widget dispatches
`NotesRequested()`, the bloc maps events to states. **Cubit** is the
same idea without the event classes.

**Good**: a very explicit, uniform structure that scales across a large
team; excellent testing tools (`bloc_test`); the event log is easy to
trace and to replay.

**Costs**: considerably more code per feature — a state class, often an
event class, a bloc, and the wiring; for a four-person student project
that overhead is rarely repaid.

## Others you may meet

- **signals** — fine-grained reactivity, similar to Solid.js. Small and
  fast; a smaller ecosystem.
- **GetX** — state, routing and dependency injection in one package with
  very little ceremony. Popular in tutorials; often criticised for
  hiding too much and for encouraging global mutable state. Be careful
  before adopting it in a team.
- **MobX**, **Redux** — familiar from other ecosystems; both used in
  Flutter but not common in new projects.

## Side by side

| | Provider | **Riverpod** | BLoC / Cubit | setState |
|---|---|---|---|---|
| Errors found at | run time | **compile time** | compile time | — |
| Needs `BuildContext` | yes | no | for the widget only | yes |
| Async built in | limited | `AsyncValue` | via states | no |
| Code per feature | low | low | high | very low |
| Testing | good | **excellent** | excellent | poor |
| Caching and disposal | manual | automatic | manual | — |
| Good for | small apps, existing code | most new apps | large teams | ephemeral state |

## Choosing

- **Ephemeral state**: always `setState`. Do not put a text controller in
  a provider.
- **A small app, or joining a code base that uses it**: Provider is
  fine.
- **A new app**: Riverpod — least code for the most safety, and
  asynchronous data is handled properly.
- **A large team with a strong convention**: BLoC, for uniformity.
- **Whatever the team already uses.** Consistency beats preference; the
  concepts transfer.

## What transfers, whatever you use

Everything in `guides/architecture.md` is independent of the choice:
immutable models, repositories behind interfaces, one sealed error
family, derived state computed outside widgets, and tests that replace
the data layer. Change the state package and those stay; that is why
they are worth learning first.

## Further reading

- Riverpod: https://riverpod.dev/docs/introduction/getting_started
- Provider: https://pub.dev/packages/provider
- BLoC: https://bloclibrary.dev
- Flutter's state-management options:
  https://docs.flutter.dev/data-and-backend/state-mgmt/options
