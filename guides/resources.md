# Resources

The official reference list from the course outline, annotated with the
weeks each book supports, plus the documentation you will actually use
day to day.

## Use these first

Books go out of date; these are updated with each release.

| Source | Use it for |
|---|---|
| https://docs.flutter.dev | the authoritative answer on anything Flutter |
| https://api.flutter.dev | the API reference — every class, with examples |
| https://dart.dev/language | the language tour and Effective Dart |
| https://pub.dev | packages, with their changelogs and example code |
| https://riverpod.dev | state management as used in this course |
| https://firebase.google.com/docs/flutter | Firebase with FlutterFire |
| https://drift.simonbinder.eu | the database layer from week 8 |

When an AI assistant and the documentation disagree, the documentation
is right (see `ai-assisted-development.md`).

## The outline's reference list

None is required. They differ mainly in level and in how current they
are — check the Flutter version each one targets before following its
code.

| Book | Best for | Weeks |
|---|---|---|
| *Beginning App Development with Flutter* | a slow first introduction to widgets and navigation | 1–5 |
| *Flutter Apprentice* | project-based, thorough, well edited | 1–9 |
| *Flutter in Action* | explains the framework's model, not only the API | 1–5 |
| *Programming Flutter* | concise, practical, good on state | 2–7 |
| *Flutter Complete Reference 2.0* | a reference to look things up in | all |
| *Practical Flutter* / *Pragmatic Flutter* | worked applications end to end | 3–10 |
| *Google Flutter Mobile Development Quick Start Guide* | a fast overview | 1–4 |
| *Learn Google Flutter Fast* | many short examples | 1–4 |
| *Flutter for Beginners* | a slower introduction, Dart included | 1–3 |
| *Flutter Succinctly* | short and free | 1–3 |
| *Managing State in Flutter Pragmatically* | the state-management comparison in depth | 5 |
| *Flutter Architectures* | layering and project structure | 5, 9 |
| *Flutter Engineering* | testing, CI, performance, release — the closest to weeks 6, 12 and 14 | 6, 12, 14 |
| *Flutter Libraries We Love* | choosing packages | 8–11 |
| *Flutter: Développez vos applications mobiles multiplateformes avec Dart* | French readers | 1–6 |
| *Flutter Apps Development: Build Cross-Platform Flutter Apps with Trust* | a second perspective on the basics | 1–5 |

## By topic

The week in brackets is where the course teaches the topic.

**Dart** (weeks 1–2) — https://dart.dev/language · https://dart.dev/effective-dart ·
https://dartpad.dev (try code without a project) · asynchrony:
https://dart.dev/libraries/async/async-await

**Widgets, the three trees and the `State` lifecycle** (week 2) —
https://docs.flutter.dev/resources/architectural-overview ·
https://api.flutter.dev/flutter/widgets/State-class.html

**Layout** (week 3) — *Understanding constraints*:
https://docs.flutter.dev/ui/layout/constraints · the widget catalogue:
https://docs.flutter.dev/ui/widgets · responsive design:
https://docs.flutter.dev/ui/adaptive-responsive

**Navigation** (week 4) — https://docs.flutter.dev/ui/navigation ·
`go_router`: https://pub.dev/documentation/go_router/latest/

**State** (week 5) — https://riverpod.dev · Flutter's own comparison:
https://docs.flutter.dev/data-and-backend/state-mgmt/options ·
https://bloclibrary.dev

**Architecture** (week 5) — https://docs.flutter.dev/app-architecture ·
`architecture.md` in this folder

**Testing** (weeks 6 and 12) — https://docs.flutter.dev/testing/overview ·
mocktail: https://pub.dev/packages/mocktail ·
https://riverpod.dev/docs/how_to/testing ·
integration tests: https://docs.flutter.dev/testing/integration-tests ·
`testing-strategy.md` in this folder

**Interactivity: gestures, keys, forms, animations** (week 7) —
https://docs.flutter.dev/ui/interactivity/gestures ·
forms: https://docs.flutter.dev/cookbook/forms/validation ·
https://docs.flutter.dev/ui/animations/implicit-animations

**Persistence and `FutureBuilder`** (week 8) —
https://docs.flutter.dev/cookbook/persistence ·
drift: https://drift.simonbinder.eu ·
JSON: https://docs.flutter.dev/data-and-backend/serialization/json

**Networking, and `FutureBuilder` or a provider** (week 9) —
https://docs.flutter.dev/cookbook/networking ·
dio: https://pub.dev/packages/dio ·
HTTP status codes: https://developer.mozilla.org/docs/Web/HTTP/Status

**Firebase and streams** (week 10) — https://firebase.flutter.dev · rules:
https://firebase.google.com/docs/rules · testing rules:
https://firebase.google.com/docs/rules/unit-tests · emulators:
https://firebase.google.com/docs/emulator-suite · plans:
https://firebase.google.com/pricing

**Device features** (week 11) — permissions:
https://developer.android.com/guide/topics/permissions/overview ·
https://pub.dev/packages/permission_handler ·
https://pub.dev/packages/geolocator ·
https://pub.dev/packages/image_picker

**Performance and CI** (week 12) — https://docs.flutter.dev/perf/best-practices ·
DevTools: https://docs.flutter.dev/tools/devtools/overview

**Responsible AI** (week 13) — `ai-assisted-development.md` in this folder ·
https://owasp.org/www-project-top-10-for-large-language-model-applications/ ·
https://pair.withgoogle.com/guidebook/

**Accessibility and localisation** (week 14) —
https://docs.flutter.dev/ui/accessibility-and-internationalization/accessibility ·
https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization

**Release** (week 14) — https://docs.flutter.dev/deployment/android ·
https://docs.flutter.dev/deployment/ios ·
https://docs.flutter.dev/deployment/flavors

## Free courses and videos

- *Flutter codelabs* — short, official, hands-on:
  https://docs.flutter.dev/codelabs
- *Flutter* on YouTube — *Widget of the Week* and *Decoding Flutter*:
  https://www.youtube.com/@flutterdev
- *Dart and Flutter: The Complete Developer's Guide* and similar paid
  courses are fine, but check the Flutter version they target.

## Staying current

- Flutter release notes: https://docs.flutter.dev/release/release-notes
- Breaking changes: https://docs.flutter.dev/release/breaking-changes
- The changelog of every package you depend on, before upgrading it

## Ethiopian and regional community

Search for Flutter meetups and developer groups in Addis Ababa; some
meet at universities and co-working spaces. A local group is a good
place to ask about internships.
