# Testing strategy

What to test, at which level, and how to keep the suite fast enough that
people run it. Weeks 6 and 12 teach the mechanics; this is the summary
to work from.

## Write the test yourself, and write it first

In the labs, you write the tests: week 6 asks for the failing test of a
new requirement before the code, in front of the TA. A test written
first states what the code must do before you see how it does it. A test
that an assistant wrote to pass existing code usually checks what the
code does, not what it should do. The AI-use level under each lab task
says how much help you may have (`../syllabus/policies.md`).

## The levels

| Level | Tool | Runs on | Speed | Test |
|---|---|---|---|---|
| **Unit** | `flutter_test` | Dart VM | ms | models, notifiers, providers, repositories, pure functions |
| **Widget** | `WidgetTester` | Dart VM, headless | tens of ms | one widget or screen: rendering, taps, text entry |
| **Golden** | `matchesGoldenFile` | Dart VM | tens of ms | appearance of components; large-font layouts |
| **Integration** | `integration_test` | device or emulator | seconds | end-to-end journeys with real plugins and storage |
| **Rules** | `@firebase/rules-unit-testing` | Firestore emulator | seconds | who may read and write what |

**Choose the lowest level at which the test still means something.**
Week 12 ("Choosing a test level") asks one question: *what must be real
for this test to show that the behaviour works?* Only Dart code: unit. A
screen and its inputs: widget. The device, real plugins, a real database
or server, or several features together: integration. How it looks:
golden. A higher level is slower and a failure tells you less about
where the fault is; a lower level cannot see what it replaced with a
fake. Lab 12 asks you to make and defend these decisions for the
lost-and-found feature.

**Move logic out of widgets.** If a behaviour can be tested as a unit
test, do not test it through widgets. This is why sorting notes is a
provider (testable in a `ProviderContainer`) rather than code inside
`build`.

## What to test in each feature

For a typical feature, aim for:

- **domain**: every rule and every edge case. These are the cheapest
  tests you will ever write — `Note.preview` with an empty body, a long
  line, trailing spaces.
- **data**: the repository against a fake transport (`FakeHttpAdapter`,
  `FakeFirebaseFirestore`, `NativeDatabase.memory()`); the notifier
  against a fake repository. Cover the failure paths — a 500, a timeout,
  a malformed response — because those are the ones nobody tries manually.
- **presentation**: the states a screen can be in (loading, data, empty,
  error) and the main interaction. Not every pixel.
- **journey**: one integration test per feature at most.

## What not to test

- Generated code (`*.g.dart`, `*.freezed.dart`) — exclude it from
  coverage too.
- The framework. `Text` renders text.
- Private implementation details. Assert on what the user sees or what
  the API returns, not on the widget tree's shape.
- Getters that only return a field.

## Do your tests find faults?

A test that passes on wrong code does not protect you. In week 6,
`tool/check_faults.sh` runs your tests once on the correct code and then
once on each of several faulty versions of it, and reports which faults
your tests catch. When a fault is not caught, add the test that fails on
it. `tool/check_faults.sh --show` then shows the line each fault
changed. Use the same idea in the project: break one line on purpose,
run the tests, and check that one of them fails.

## Fakes, mocks and the real thing

| Use | When |
|---|---|
| **Fake** (a working, simplified implementation) | you need realistic behaviour in many tests — `FakeEventsRepository`, `InMemoryNotesRepository`, `FakeFirebaseFirestore` |
| **Mock** (`mocktail`) | you need one specific answer, or to verify a call happened — `verify(() => repo.fetchAll()).called(1)` |
| **The real implementation** | the thing under test is the implementation — `DriftNotesRepository` against `NativeDatabase.memory()` |

Mock at **boundaries** — network, database, plugins, platform. Never
mock code you own and want covered: mocking the notifier to test the
screen hides real bugs.

## Naming and structure

```dart
group('Note.preview', () {
  test('returns the first line unchanged when short', () { … });
  test('cuts long lines at maxLength with an ellipsis', () { … });
});
```

- The test name is a **sentence about behaviour**, not "test1" or
  "preview works".
- One behaviour per test; arrange, act, assert.
- `setUp` creates fresh objects — never share state between tests.
- Mirror the source tree: `lib/features/notes/domain/note.dart` →
  `test/features/notes/note_test.dart`.

## Determinism

A test that passes on one run and fails on the next, with no change to
the code, is worse than no test: people learn to ignore it. The three
usual causes, and the fix each time:

1. **Real time.** Inject it: `isUpcoming({DateTime? now})`, `nowProvider`,
   a `clock` parameter on `ShakeDetector`. Never call `DateTime.now()`
   inside code under test.
2. **The network.** Replace the transport (`FakeHttpAdapter`) or the
   repository. No test may need the internet.
3. **Shared state.** `ProviderContainer.test()`, `setUp`, and cleaning
   up after integration tests, which use the device's real storage.

Also: disable Riverpod's automatic retry in tests
(`retry: (retryCount, error) => null`), or a test of a failing provider
waits for retries that will never succeed.

## Coverage

```bash
tool/coverage.sh            # or: flutter test --coverage
```

Filter out generated files before reading the number. CI requires
**line coverage of at least 60 % in the project**. That is a minimum,
not a target: coverage tells you which lines *ran*, not which were
*checked*. Use the report to find
untested branches — an `else` nobody executed, an error path nobody
exercised — and ignore the percentage otherwise.

## Speed

A suite people do not run finds nothing. Keep it fast enough that you
run it before every commit:

- unit and widget tests do the work; integration tests are few;
- no real delays — inject `Duration.zero` into fakes, use
  `tester.pump(duration)` which advances fake time instantly;
- tag the slow or platform-specific ones (`-x golden`) so a quick run is
  possible.

## In CI

Week 12's workflow runs, in order: regenerate and diff, format the files
people write, analyse, test with coverage (line coverage of at
least 60 % in the project), build.

Golden images made on one operating system can differ by a few pixels
from images made on another. A team chooses one of two ways: make the
images on Linux in CI (a job started by hand that uploads them) and let
CI check them on every push, skipping them locally on Windows or macOS
with `-x golden`; or skip them in CI with `-x golden` and check them on
the one computer that made them. This repository uses the first way. Integration tests run on a
schedule or before a release, not on every push.

## A checklist for a pull request

- [ ] New behaviour has a test at the lowest level that can cover it.
- [ ] Failure paths are covered, not only the successful case.
- [ ] No test depends on real time, the network, or another test.
- [ ] Test names read as sentences.
- [ ] Nothing that is mocked is code we own and want covered.
- [ ] `flutter test` passes locally and in CI.

## Further reading

- Flutter testing overview: https://docs.flutter.dev/testing/overview
- mocktail: https://pub.dev/packages/mocktail
- Riverpod testing: https://riverpod.dev/docs/how_to/testing
- Weeks 6 and 12 of this course
