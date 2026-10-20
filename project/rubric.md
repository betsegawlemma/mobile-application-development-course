# Final project rubric

The final submission is marked out of 100 and scaled to the project's
45 % share; proposal, milestones and presentation make up the rest of the
30 % course weight (see `README.md`).

## How to read the levels

Each area has four levels. A level is reached only when **every** point
in its description is true. The mark for an area is

> level ÷ 4 × the area's points

so level 4 gives full marks, level 3 gives three quarters, level 2 half
and level 1 a quarter. An area with nothing to mark gets 0.

Before you tag `final`, score your own submission with this table, with
one sentence of evidence per area, in `MILESTONE.md`.

## Areas and levels

| Area | Points | 4 | 3 | 2 | 1 |
|---|---|---|---|---|---|
| **Functionality** | 20 | Every "must" and "should" story works without a crash; empty lists, no network and invalid input each show a message | Every "must" story works without a crash; one of empty, no network or invalid input is not handled | At most one "must" story missing or broken; no crash on the main path | Two or more "must" stories missing, or the app crashes in normal use |
| **Architecture and code quality** | 15 | Feature-first folders; no business logic in widgets; state in Riverpod; immutable models; every repository behind an interface; `flutter analyze --fatal-infos` clean | As 4, but logic in at most two widgets | Feature-first folders, but logic in three or more widgets **or** one repository not behind an interface; analyser clean only after the final commit | No feature folders, or global mutable state, or analyser errors on the final tag |
| **Data and backend** | 15 | Local persistence survives a restart; a REST source and a Firebase source (Auth and Firestore), each behind an interface; every screen that loads data has loading, error and empty states; no keys in the repository; Firestore rules tested | As 4, but one screen misses one state | All three sources present; two or more screens miss a state, or rules untested | Local, REST or Firebase source missing, or data lost on restart, or a key committed |
| **Testing** | 15 | Every repository has a test with a fake, including one failure path; every screen that loads data has loading, data, empty and error widget tests; one integration test per main story; line coverage of at least 60 %; CI green on the `final` tag | As 4, but one feature has no failure-path test, or coverage between 50 % and 60 % | Tests for at most half the features, or CI red on the `final` tag | Tests do not run |
| **Device feature** | 5 | One device feature (camera, location or a sensor) with every permission outcome handled with a distinct message; behind a service interface and tested with a fake | As 4, but one permission outcome not handled | Works on the success path only; no test | Missing, or crashes when permission is refused |
| **AI feature** | 5 | One AI feature with consent and disclosure, matching the group's `AI_FEATURE.md`; slow, refused and wrong answers each handled; output shown, never acted on without the user confirming; behind a service interface and tested with a fake | As 4, but one failure (slow, refused or wrong) not handled | Works on the success path only; no test | Missing, or crashes when consent is refused |
| **User experience and accessibility** | 10 | Consistent theme; no overflow at 360 px and 900 px wide; every icon-only button has a semantics label; contrast passes the guideline test; a second locale if proposed | One of these four points not met | Two not met | Overflow errors in normal use, or unusable at 360 px |
| **Documentation** | 5 | README with screenshots, setup steps a TA can follow, and an architecture diagram; `DECISIONS.md` with at least three decisions and their reasons; `AI_USAGE.md` that names each generated file, the change you made and one verified error, with an AI-use level per entry | One of the three files incomplete | Two incomplete | README only, or missing |
| **Process** | 5 | Every member authored at least one merged pull request **and** reviewed at least one pull request by another member, per milestone; merge commits keep each member's history; tags at each milestone | One member misses one pull request or one review in one milestone | Several pull requests merged without review, or direct commits to `main` | One member did almost everything, or no pull requests |
| **Release** | 5 | Two flavours, `development` and `production`, each with its own application id: development uses the Firebase emulators and a local or test REST server, production the real endpoints; the signed release build attached to the tag is the production flavour; app icon and splash; version set; `PRIVACY.md` and the data-safety table match the app | Signed build, one other point missing | Debug build only | No build |

**Total: 100**

The coverage figure is one number the course uses everywhere: **line
coverage of at least 60 % in the project**. Coverage shows which code no
test runs; it is not a measure of test quality.

## Individual marks

Your project mark is the group mark multiplied by your **individual
factor**:

> individual factor = your average peer score ÷ the group's average peer
> score, limited to the range 0.8–1.2

The peer scores come from the anchored peer evaluation after Milestone 2
and after the final submission (`peer-evaluation.md`). The instructor
may change the factor after looking at the commit history and the oral
checks, and records the reason in writing. Your milestone marks are
also multiplied by your individual oral score (see `milestones.md`).

## Penalties
- Late submission: see `../syllabus/policies.md`.
- Code that you cannot explain at the oral check: that part is not
  credited for you, and you get a second check within one week.
- Missing `AI_USAGE.md`: −5 points. If AI use is evident and was not
  disclosed, that is referred under the integrity policy.
