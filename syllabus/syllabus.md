# Syllabus — Mobile Applications Development

| | |
|---|---|
| **Programme** | B.Sc. in Computer Science, Addis Ababa University |
| **Course code** | TBD |
| **Instructor** | Betsegaw Lemma — betsegawlemma@gmail.com |
| **Term** | TBD (14 teaching weeks) |
| **Contact hours** | 2 h lecture + 3 h lab per week |
| **Prerequisites** | Introductory programming, data structures |
| **Materials** | https://betsegawlemma.github.io/mobile-application-development-course/ |

## Course description

This project-oriented course deals with the concepts of mobile applications.
Most people in our communities now use mobile phones. In this
course we focus on the creation of mobile solutions for modern platforms,
including the major mobile operating systems. Topics include the Flutter
framework, the Dart programming language, user interface design, app
architecture, testing, integration with web services and cloud backends,
responsible use of AI, and app distribution.

## Learning outcomes

On successful completion of this course you will be able to:

1. **Explain** the mobile platform landscape and the architecture of Flutter
   (widgets, elements, render objects, the widget lifecycle).
2. **Write** idiomatic, null-safe Dart including classes, mixins, generics and
   asynchronous code.
3. **Build** adaptive user interfaces with layout, navigation, gestures and
   forms that share a common data model.
4. **Structure** an application using feature-first architecture and Riverpod
   state management so that it is testable and maintainable.
5. **Test** applications at unit, widget, integration and golden levels,
   run those tests in continuous integration, and measure performance with
   Flutter DevTools.
6. **Integrate** an app with local storage, a REST web service and a
   Firebase backend (authentication, Cloud Firestore, security rules).
7. **Use** device sensors, camera and location with correct permission
   handling to enhance interaction and feedback.
8. **Apply** AI assistants responsibly in development and design AI-powered
   features with attention to privacy, cost and transparency.
9. **Release** an app: flavours, signing, store submission, accessibility and
   localisation.
10. **Collaborate** in a team using version control and code review.

## Weekly plan

| Wk | Topic | Outline chapter | Lab |
|---|---|---|---|
| 1 | Mobile landscape, Flutter, Dart I | 1, 2, 3 | Environment setup, Hello World, Dart exercises |
| 2 | Dart II (classes, mixins, async); widget lifecycle | 3, 1 | Capstone skeleton, stateful screen, async exercises |
| 3 | Layout and common widgets; responsive design | 4 | Events feed and Profile screens (static) |
| 4 | Navigation: Navigator, named routes, go_router, tabs, drawer | 5 | Wire all four capstone screens |
| 5 | State management and app architecture (setState → Riverpod) | — | Refactor to Riverpod + feature-first |
| 6 | Testing I: unit and widget tests, mocking, TDD | — | Unit, widget and provider tests for the notes feature; tests written first; one test for an untested branch |
| 7 | Interactivity: gestures, drag & drop, forms, animations | 6 | Swipe-to-delete, reorder, validated forms |
| 8 | Local persistence: JSON, shared_preferences, drift | 7 | Notes persist across restarts · **Mid exam** (weeks 1–7) |
| 9 | Networking: REST, dio, repository pattern | — | Events feed CRUD against the course REST backend |
| 10 | Firebase: Auth, Firestore, security rules, emulators | 8 | Lost-and-found with auth and real-time updates |
| 11 | Device features: sensors, camera, location, permissions | — | Photo + location on posts; shake-to-refresh |
| 12 | Testing II & quality: integration/golden tests, CI, DevTools | — | Integration/golden tests; test levels; CI in your project repository |
| 13 | Responsible AI: AI-assisted development; AI features in apps | — | AI note summary behind a provider-agnostic interface |
| 14 | Release: flavours, signing, stores, accessibility, i18n | — | Signed release build; accessibility audit |

Full mapping of every outline item to a week and section, and of every
course outcome to its assessment: `coverage-matrix.md`.

## Assessment

| Component | Weight | When |
|---|---|---|
| Mid exam | 30 % | Week 8 — covers weeks 1–7 |
| Group project | 30 % | Proposal wk 3 · M1 wk 6 · M2 wk 10 · Submission wk 14 · Presentation wk 15 |
| Final exam | 40 % | Exam period — covers weeks 1–14, including week 8 |

Both exams are on paper and closed book, with a one-page API reference
sheet. [`exams.md`](exams.md) has the blueprint for each exam, the
reference sheet and a sample paper with answers.

**Week 8 is examined in the final exam, not in the mid exam.**

**Lab work is individual and formative.** Each lab has two TA-signed
checkpoints and ends with a short supervised exit task, done without an
assistant. The TA records a level for each checkpoint and a score for the
exit task, and returns a "Next step" line to you. Lab marks do not count
towards the course mark, but missing more than three labs caps the
project mark (see `policies.md`). Lab solutions are released after each
lab week.

See `policies.md` for the AI-use levels, late-work and integrity
policies, and `../project/README.md` for the project.

## Textbook and references

There is no required textbook. The official reference list:

- Beginning App Development with Flutter
- Flutter Apps Development: Build Cross-Platform Flutter Apps with Trust
- Flutter Apprentice
- Flutter Complete Reference 2.0
- Flutter : Développez vos applications mobiles multiplateformes avec Dart
- Flutter for Beginners
- Flutter in Action
- Flutter Libraries We Love
- Flutter Succinctly
- Google Flutter Mobile Development Quick Start Guide
- Learn Google Flutter Fast
- Managing State in Flutter Pragmatically
- Practical Flutter
- Pragmatic Flutter
- Programming Flutter
- Flutter Architectures
- Flutter Engineering

Primary online references: https://docs.flutter.dev, https://dart.dev/guides,
https://riverpod.dev, https://firebase.google.com/docs/flutter. An annotated
list is in `../guides/resources.md`.

## Tooling

Flutter **3.47.7** stable (Dart 3.13.5). Install instructions and
troubleshooting are in week 1 and `../guides/troubleshooting.md`. You need a
laptop that can run an Android emulator *or* a physical Android/iOS device
with USB debugging enabled; Chrome is enough for the first three weeks.
