# Project milestones

Each milestone is a Git tag in the group repository plus a `MILESTONE.md`
in the repository root. A TA reviews the tagged commit and holds an
**individual oral check** with each member in the following lab (see
below).

Every `MILESTONE.md` contains:

- what is done and what is not;
- who did what: for each member, the pull requests they authored and the
  pull requests they reviewed;
- the group's **self-score** against the mini-rubric, with one sentence of
  evidence per row, written **before** you tag the milestone;
- one thing the group will change before the next milestone.

The milestone also includes an `AI_USAGE.md` (template in
`AI_USAGE-template.md`).

## Milestone 1 — screens, navigation, state

**Due:** end of week 6 · **Tag:** `m1`

### Deliverables
- Feature-first project structure (`lib/core`, `lib/features/<feature>/{domain,data,presentation}`).
- Every screen from the proposal exists and is reachable through
  `go_router` (bottom navigation or drawer, detail routes with parameters).
- Application state in Riverpod providers with `freezed` models;
  in-memory repositories behind interfaces.
- At least five unit or widget tests.
- The output of `flutter analyze --fatal-infos` and `flutter test`, run on
  the tagged commit, pasted into `MILESTONE.md`. Continuous integration is
  not required yet: you set it up yourselves after week 12.

### Mini-rubric (10 points)

| Criterion | Points |
|---|---|
| All proposed screens present and navigable | 3 |
| Feature-first structure; state in providers, not widgets | 2 |
| Tests present; analyser and tests clean in the pasted output | 1 |
| Repository hygiene: branches, pull requests, readable history | 1 |
| Individual oral check (recorded per member) | 3 |

## Milestone 2 — data, backend, tests

**Due:** end of week 10 · **Tag:** `m2`

### Deliverables
- Local persistence working (drift or shared_preferences as appropriate).
- Both remote data sources working, each for at least one user story:
  a REST web service and Firebase (Auth and Cloud Firestore), each behind
  a repository interface, with loading/error/empty states in the UI.
- Authentication if the app has user accounts.
- Tests for the data layer (repositories with fakes or mocks) and for the
  main user flows. Paste the `flutter test --coverage` summary into
  `MILESTONE.md`.
- Updated `README.md` with setup instructions someone else can follow.
- A first pass of the release and accessibility checklists from week 14
  (`../weeks/week14-release/lab/README.md`): which points pass and which do
  not yet. You get feedback on it before the final submission.

### Mini-rubric (10 points)

| Criterion | Points |
|---|---|
| Local persistence correct across restarts | 2 |
| REST and Firebase sources each behind an interface; error and loading states handled | 2 |
| Data-layer and flow tests passing | 2 |
| README setup steps work on a TA's machine | 1 |
| Individual oral check (recorded per member) | 3 |

## Individual oral check

At each milestone and at the final submission, the TA checks every member
separately, in the lab after the deadline.

1. The TA picks one function or widget that the member did **not** list
   as their own work in `MILESTONE.md`.
2. The TA asks three questions, always of these three types:
   1. **Trace.** "What does this code do when *<a given input>*?"
   2. **Place.** "Why is it in this layer, or in this provider?"
   3. **Change.** "Change it so that *<a small new requirement>*." The
      member makes the change on screen and runs it.
3. Each answer scores **0** (cannot answer), **1** (partly correct) or
   **2** (correct and complete). The individual score is 0–6.
4. You may answer by pointing at, tracing or changing the code, not only
   by speaking, and you may use Amharic for single words you do not know
   in English.

The individual score gives the oral points in the mini-rubric (6 → 3,
5 → 3, 4 → 2, 3 → 2, 2 → 1, 1 → 1, 0 → 0) and also **multiplies your
milestone mark**:

| Individual score | Your milestone mark |
|---|---|
| 5–6 | 100 % of the group mark |
| 3–4 | 80 % of the group mark |
| 0–2 | 50 % of the group mark, and a second check one week later; if the second check scores 3 or more, you get 80 % |

The TA records the score, the code that was asked about and one sentence
of feedback for each member.

## Final submission

**Due:** end of week 14 · **Tag:** `final`

See `rubric.md`. In addition to the milestone content:

- one device feature with every permission outcome handled, **and** one
  AI feature behind an interface with consent and disclosure;
- an integration test and an accessibility check;
- continuous integration (GitHub Actions) running analyze and test, green
  on the `final` tag;
- two flavours, `development` (Firebase emulators and a local or test REST
  server) and `production` (the real endpoints);
- a signed release build of the production flavour attached to the tag,
  with `PRIVACY.md` and the data-safety table;
- `USER_TEST.md`: who tried the app, three things they did, two problems
  they found and what you changed;
- the presentation materials.

The individual oral check is held for the final submission as well.
