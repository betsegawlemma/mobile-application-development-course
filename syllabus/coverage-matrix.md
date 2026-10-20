# Coverage matrix

Every item in the official course outline, and where it is taught. Added
industry topics follow.

## Chapter 1 — Introducing Flutter and getting started

| Outline item | Week | Where |
|---|---|---|
| Introducing Flutter | 1 | notes §1 "Why mobile, and why Flutter"; slides 4–8; comparing native, web and cross-platform is named in mid exam part A |
| Defining widgets and elements | 1, 2 | week 1 notes §2 "How Flutter draws pixels"; week 2 notes §4 "The three trees" (moved from week 1) |
| Understanding widget lifecycle events | 2 | notes §4; `LifecycleLogger` in the lab |
| The StatelessWidget and StatefulWidget lifecycle | 2 | notes §4 table and state diagram; lab task 2 (decide stateless or stateful for each widget, defended at Checkpoint A), task 3 |
| Understanding the widget tree | 1, 2 | week 1 notes §2, slide "The widget tree"; week 2 slide "Three trees" |

## Chapter 2 — Creating a Hello World app

| Outline item | Week | Where |
|---|---|---|
| Setting up the project | 1 | lab tasks 1–3; notes §4 "Anatomy of a Flutter project" |
| Using hot reload | 1 | notes §2 "Hot reload vs hot restart"; lab task 2 |

## Chapter 3 — Learning Dart basics

| Outline item | Week | Where |
|---|---|---|
| Why use Dart? | 1 | notes §3 "Dart, part I" |
| Commenting code | 1 | notes §3 "Comments and `main`" |
| Referencing variables | 1 | notes §3 "Variables and types" |
| Declaring variables | 1 | notes §3; `var`/`final`/`const`/`late` |
| Using operators | 1 | notes §3 "Operators worth knowing" |
| Using flow statements | 1 | notes §3 "Control flow"; switch expressions |
| Using functions | 1 | notes §3 "Functions"; exercises 1–8 |
| Import packages | 1 | notes §4; `flutter pub add` |
| Using classes | 2 | notes §1 "Classes"; exercise 1 |
| Class inheritance | 2 | notes §2; sealed `Shape` hierarchy |
| Class mixins | 2 | notes §2 "Mixins"; exercise 3 (Extra task) |
| Implementing asynchronous programming | 2, 10 | week 2 notes §3 "Asynchronous programming" (futures), exercise 7; streams in week 10 notes "Streams: a short revision" |

## Chapter 4 — Using common widgets

| Outline item | Week | Where |
|---|---|---|
| Using basic widgets | 3 | notes §2 "The building blocks" |
| SafeArea | 3 | notes §2 table; `ProfileScreen` |
| Container | 3 | notes §2 (`ContactTile`); `EventCard` date block (lab task 2) |
| Text | 3 | notes §3 "Text, RichText and the theme" |
| RichText | 3 | notes §3 (`Text.rich` and `RichText`); `EventCard` venue line; lab task 2 |
| Column | 3 | notes §2 "Row and Column" |
| Row | 3 | notes §2 (`ContactTile`, `CoursePage`); lab tasks 2, 4 and 6 (`NoteCard`, own design) |
| Buttons | 3 | notes §4 "Buttons" table; `ProfileScreen` actions |
| FloatingActionButton | 3 | notes §4; used from week 2 onwards |
| AssetBundle | 3 | notes §5 "Assets"; lab task 1; week 8 `rootBundle.loadString` |
| Checking orientation | 3 | notes §6; `MediaQuery.orientationOf`; lab task 4 |

## Chapter 5 — Creating an app's navigation

| Outline item | Week | Where |
|---|---|---|
| Using the Navigator | 4 | notes §1 "Navigator 1.0" (`_chooseCampus` in `named_routes_demo.dart`); lab task 2 |
| Using the named Navigator route | 4 | notes §1 "Named routes and their limits" (`named_routes_demo.dart`: `routes`, `onGenerateRoute`, `onUnknownRoute`); lab task 1 (read and predict) |
| Using the BottomNavigationBar | 4 | notes §3; `NavigationBar` with the Material 2 equivalent named |
| Using the BottomAppBar | 4 | notes §4 (`BookPage`); `EventDetailScreen` with a docked FAB (lab task 2) |
| Using the TabBar and TabBarView | 4 | notes §4 (`BooksPage`); Upcoming/Past on the feed (lab task 7) |
| Using the Drawer and ListView | 4 | notes §4 (`LibraryDrawer`); `AppDrawer` (lab task 5); Settings entry in lab task 8 (own design) |

## Chapter 6 — Applying interactivity

| Outline item | Week | Where |
|---|---|---|
| Setting up GestureDetector: the basics | 7 | notes §1; `TapCounter` in the playground |
| Implementing the Draggable and DragTarget widgets | 7 | notes §3; `LongPressDraggable` and the drop zones (lab Task 2, test first) |
| Using the GestureDetector for moving and scaling | 7 | notes §1 "Moving and scaling"; `MovableScalableBox` |
| Using the InkWell and InkResponse gestures | 7 | notes §1 "InkWell and InkResponse"; `InkDemo`; the playground reset button (lab Task 5c) |

## Chapter 7 — Saving data with local persistence

| Outline item | Week | Where |
|---|---|---|
| Understanding the JSON format | 8 | notes §2 "JSON" |
| Using database classes to write, read and serialise JSON | 8 | notes §2 and §4 (lecture example: bookmarks); lab Tasks 1 and 3 (`NotesJson`, `DriftNotesRepository`) |
| Formatting dates | 8 | notes §5; lab Task 4a (`DateFormat` in `EventCard` and the detail) |
| Sorting a list of dates | 8 | notes §5; lab Task 4b (`EventsScreen` upcoming and past) |
| Retrieving data with the FutureBuilder | 8 | notes §6; lab Task 5 (`AboutScreen`); compared with `AsyncValue` in week 9 notes §5 |

## Chapter 8 — Adding the Firebase and Firestore backend

| Outline item | Week | Where |
|---|---|---|
| What are Firebase and Cloud Firestore? | 10 | notes §1 "Backend-as-a-service" |
| Structuring and data modelling Cloud Firestore | 10 | notes §4 "The data model"; lab Task 6 (`DESIGN.md`, comments on a post) |
| Viewing Firebase Authentication capabilities | 10 | notes §3 "Authentication" |
| Viewing Cloud Firestore security rules | 10 | notes §5; lab Task 5a (evaluate `weak.rules`); `firebase/firestore.rules` |
| Configuring the Firebase project | 10 | notes §2; `firebase/README.md`; lab task 1 |
| Adding a Cloud Firestore database and implementing security | 10 | notes §4–5; lab tasks 3 and 5; rules tests (one written first, Task 5b) |

## Added industry topics

| Topic | Week | Where |
|---|---|---|
| State management (setState → Riverpod) | 5 | notes §1–3 (`lecture_check_in.dart`, `lecture_reminders.dart`); lab tasks 1–3, 4 (own design); `guides/state-management-comparison.md` |
| Application architecture, layers, repositories | 5 | notes §4; lab task 0 (read), task 4 (place a feature in folders and layers); `guides/architecture.md` |
| Immutable models with code generation | 5 | notes §3 (a provider by hand and with the generator), §4 "freezed"; lab task 0 (read the generated provider and `note.freezed.dart`) |
| Unit testing | 6 | notes §2 (`lecture_testing.dart`, choosing cases from a rule); lab task 1; `guides/testing-strategy.md` |
| Widget testing | 6 | notes §3; lab task 5 (the student chooses the cases from a requirement; checked at Checkpoint B) |
| Fakes and mocks | 6 | notes §4 (`FakeQuoteRepository`); lab task 4a (a mock), 4b (a fake written by hand, `events_fake_test.dart`) |
| Testing Riverpod | 6 | notes §5 |
| Test-driven development | 6 | notes §6 (live coding `lecture_archive.dart`); lab task 2, Checkpoint A (new requirement, test first) |
| Checking that tests find faults (faulty versions) | 6 | notes §7; lab task 1 (`tool/check_faults.sh`), task 3 (an assistant's tests) |
| Forms and validation | 7 | notes §4; lab Task 3 (a form-validation test written first, then the form) |
| Implicit animations | 7 | notes §5; lab Tasks 4 and 5c (`AnimatedContainer`, `AnimatedOpacity`) |
| Key–value preferences | 8 | notes §3 `shared_preferences`; lab Task 2 |
| SQLite and migrations | 8 | notes §4 drift; lab Task 3 (upsert from the drift documentation, `delete` test first, read the migration in 3d); extra Task 6 writes one |
| HTTP and REST | 9 | notes §1–2 (authentication tokens at the "explain" level; week 10 uses ID tokens); `backend/`; lab Task 1 |
| Timeouts | 9 | notes §1 (`/slow?seconds=`); lab Task 4b (`/slow?seconds=15` against the app's 10 s receive timeout) |
| DTOs and error mapping | 9 | notes §3–4 (`lecture_networking.dart`); lab Task 2 (422 test first), Task 3b (missing `await` in `_guard`) |
| CRUD over HTTP, paging, retry | 9 | notes §5; lab Tasks 3, 4 and 5 (`mounted` after `await`; 5b edits a title through `update` from the detail screen, `event_edit_test.dart`); Task 7 (design a register endpoint) |
| Testing the network layer | 9 | notes §6; `FakeHttpAdapter`; lab Task 2a |
| Diagnosing a failing request | 9 | notes §7 "When a request fails"; lab Task 4c |
| GraphQL and WebSockets (overview) | 9 | notes §8; slides; quiz item 16 |
| Checking an assistant's answer (networking) | 9 | lab Task 6 (`lab/ai_answers/server_status.md`) |
| Authentication and route protection | 10 | notes §3 |
| Security rules and their tests | 10 | notes §5 |
| Backend-as-a-service compared with REST | 10 | notes §1 (comparison table); lab Task 1 step 5 (which data of the student's own project goes to REST and which to Firebase, in `DECISIONS.md`, explained at Checkpoint A) |
| Permissions | 11 | notes §1 and §5 (`lecture_device.dart`: `checkCamera`, *Open settings* with a recording fake); lab Tasks 1, 3 and 5 (*Open settings* on a blocked location) |
| Sensors | 11 | notes §2 (`FlipDetector`, when `dispose` runs); lab Task 2 (`ShakeDetector`: test first, when is it released), Task 6 (compass from its interface, own design) |
| Camera, file upload, remote images | 11 | notes §3 (`ProfileAvatar` in `lecture_device.dart`: a remote image with `errorBuilder` and `loadingBuilder`); lab Task 4 (4c: the board's photo shown safely, `lost_found_photo_test.dart`) |
| Location | 11 | notes §4; lab Tasks 3 and 5 |
| Integration testing | 12 | notes §1–2 (choosing a test level); lab Task 1 (a restart test made to fail by a planted fault), Task 2 (test levels for lost-and-found, own design) |
| Golden testing | 12 | notes §3 (`lecture_golden_test.dart`, goldens on different operating systems); lab Task 3 |
| Continuous integration and coverage | 12 | notes §4 (`examples/backend-ci.yml`, reading a failed run); lab Task 4 (workflow from requirements, 60 % floor), Task 5 (a saved failing log); `.github/workflows/ci.yml` |
| DevTools and performance | 12 | notes §5–6; lab Task 6 (prediction table, measured rebuilds) |
| AI-assisted development | 1, 13 | week 1 notes §5; week 13 notes part A (§2 learning with an assistant, §4 checklist for code and explanations); lab 13 Task 1 (own prompt written first and compared with a saved and a short prompt in `PROMPTS.md`; saved answers in `lab/ai_answers/`); `guides/ai-assisted-development.md` |
| AI features, consent, disclosure, prompt injection | 13 | notes part B (§10 cost worked example); lab 13 Tasks 3–5 (failure test written first, `AI_FEATURE.md`) |
| Build flavours | 14 | notes §1; lab Task 4 (`app_config_test.dart`) |
| Signing and release builds | 14 | notes §2; lab Task 4 (signed APK, keystore not tracked) |
| Store submission and distribution | 14 | notes §3 (Play registration fee and closed test, direct APK sharing and its risks, privacy policy and data safety); lab Task 5 (`RELEASE.md`, `PRIVACY.md` with a data-safety table for the student's project) |
| Localisation (English and Amharic) | 14 | notes §4 (`lecture_release.dart`, checking a translation); lab Task 1 (own translation compared with a saved machine translation), Task 2 (fallback test written first) |
| Accessibility | 14 | notes §5 (`RoomCard`, audit protocol and severity); lab Task 3 (event card semantics; TalkBack audit of the student's project, `ACCESSIBILITY.md`) |
| Git workflow and code review | — | `guides/git-workflow.md`, `guides/code-review-checklist.md`; used from week 6 |

## Assessment mapping

| Outline requirement | Where |
|---|---|
| Mid exam 30 % | week 8; covers weeks 1–7 (`syllabus/exams.md`) |
| Project 30 % | `project/` — proposal, two milestones, submission, presentation |
| Final exam 40 % | examination period; covers weeks 1–14, including week 8 (`syllabus/exams.md`) |
| Groups of four, emailed with the subject "Mobile App Project" | `project/README.md`, `project/proposal-template.md` |

## Course outcomes and assessment

Which assessment gives evidence for each course learning outcome (CLO).
The outcomes are listed in `syllabus.md`. "Exam part" refers to the
blueprints in `exams.md` (mid parts A–E, final parts A–F). "Lab" means
the TA checkpoints and the supervised exit task.

| CLO | Weeks taught | Lab evidence | Project evidence | Exam part |
|---|---|---|---|---|
| 1 Explain the platform and Flutter's architecture | 1, 2 | labs 1–2 checkpoints; exit tasks 1–2 | presentation answers | mid A, B; final A |
| 2 Write idiomatic, null-safe Dart | 1, 2 | labs 1–2 exercises (AI level 0–1); exit tasks 1–2 | all code; oral check | mid B, D; final B, D |
| 3 Build adaptive interfaces | 3, 4, 7 | labs 3, 4, 7; "Your own design" tasks | M1 screens; final Functionality, User experience | mid B, C, D; final F |
| 4 Structure an app with feature-first architecture and Riverpod | 5 (used to 14) | lab 5; exit task 5 | M1 structure; final Architecture; oral check "Place" question | mid A, C, D; final C, D |
| 5 Test at every level, run tests in CI, and measure performance with Flutter DevTools | 6, 7, 12 (tests in most labs) | lab 6 test-first task; student-written tests in labs 2, 4, 5, 7, 9–11, 13; lab 12 DevTools task | M1 and M2 tests; final Testing (60 % line coverage, CI green) | mid E; final E |
| 6 Integrate local storage, a REST service and Firebase | 8, 9, 10 | labs 8–10; rules tests in lab 10 | M2 data; final Data and backend | final B, C, D, F |
| 7 Use sensors, camera and location with correct permission handling | 11 | lab 11 | final "Device feature" | final C, F |
| 8 Use AI assistants responsibly and design AI features | 1, 3, 6, 9, 13 | week 1 verification task; seeded faulty answers in labs 3, 6, 9; lab 13 `AI_FEATURE.md` | `AI_USAGE.md` (Documentation); final "AI feature" | final A, F |
| 9 Release an app with flavours, accessibility and localisation | 3, 14 | lab 14 (translation compared with a machine version; fallback test first; TalkBack audit and `PRIVACY.md` on the project); exit task 14 | M2 release and accessibility checklist; final Release (flavours and signed build), User experience | final F |
| 10 Collaborate in a team using version control and code review | 1 (Git), used from week 3 | — | Process row (pull requests and reviews per member); repository hygiene in M1; peer evaluation | — (assessed in the project only) |
