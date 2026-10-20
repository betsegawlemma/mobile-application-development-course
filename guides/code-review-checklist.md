# Code review checklist

Use this for pull requests inside your group, and for the code you are
about to submit. It is ordered: the first section finds the problems
that matter most.

A review is about the code, not the person. Say "this rebuilds the whole
list" rather than "you always do this". Ask questions when you are not
sure: "what happens here if the request fails?" is more useful than a
guess.

## 1. Does it work, and do we know it works?

- [ ] There is a test for the new behaviour, at the lowest level that
      can cover it.
- [ ] Failure paths are covered: empty, offline, refused permission,
      server error, malformed response.
- [ ] `flutter analyze --fatal-infos` and `flutter test` pass in CI.
- [ ] The description says what changed and how it was checked.

## 2. Architecture

- [ ] Layers respected: no plugin, dio or Firebase types in
      `presentation/`; no Flutter imports in `domain/`.
- [ ] New external dependencies sit behind a repository or service
      interface.
- [ ] Business logic is in `domain/` or a provider, not in `build`.
- [ ] New files are in the right feature folder, named by convention.
- [ ] No new global mutable state.

## 3. State

- [ ] Ephemeral state (controllers, tabs) stays in the widget;
      application state is in a provider.
- [ ] State is **assigned**, never mutated in place.
- [ ] `ref.watch` in `build`, `ref.read` in callbacks.
- [ ] `select` used where a widget needs one field of a large object.
- [ ] Models are immutable.

## 4. Errors and edge cases

- [ ] Failures become `AppException` at the boundary; the UI switches
      over the sealed type.
- [ ] Every message is something a user can act on.
- [ ] No empty `catch`; nothing swallowed silently.
- [ ] `null` handled without `!` except where it is genuinely
      impossible.
- [ ] Loading, empty and error states exist for anything asynchronous.

## 5. Resources and lifecycle

- [ ] Controllers, focus nodes, subscriptions, timers and databases are
      disposed.
- [ ] `if (!mounted) return;` before `setState` after an `await`.
- [ ] No work in `build`: no sorting, parsing, I/O or future creation.

## 6. Performance

- [ ] `const` where possible.
- [ ] `ListView.builder` for anything that can grow.
- [ ] The smallest possible widget rebuilds.
- [ ] Images sized for the screen, not full resolution.

## 7. User interface

- [ ] Works at 320 dp and with a 2× system font.
- [ ] Both themes checked.
- [ ] Text comes from the localisation file, not a literal.
- [ ] `IconButton`s have tooltips; meaningful images have semantic
      labels; tap targets are at least 48 dp.
- [ ] Colour is not the only signal.
- [ ] Destructive actions can be undone or are confirmed.

## 8. Security and privacy

- [ ] No secrets in the repository: keys, keystores, `key.properties`,
      service-account files.
- [ ] Security rules updated when the data model changed, and tested.
- [ ] Personal data collected only where needed, and said so in the UI.
- [ ] Nothing sent to a third party (including an AI model) without
      consent.
- [ ] Input from outside — API, clipboard, file — is validated.

## 9. Clarity

- [ ] Names say what the thing is; no `data2`, `temp`, `handle`.
- [ ] Comments explain **why**, not what the code already says.
- [ ] Public APIs have doc comments.
- [ ] No commented-out code; no leftover `debugPrint`; no `TODO` without
      a name or an issue.
- [ ] The diff does one thing. A refactor and a feature belong in
      separate pull requests.

## 10. Repository hygiene

- [ ] Generated files regenerated and committed.
- [ ] `pubspec.yaml` changes are deliberate, with a reason in the
      description.
- [ ] No unrelated formatting churn.
- [ ] Commit messages describe the change.

---

## For the author, before requesting a review

1. Read your own diff first. You will find half the comments yourself.
2. Make sure CI is green before asking anyone to look.
3. Say what you are unsure about — that is where you want attention.
4. Keep it small. A 200-line pull request gets a real review; a
   2000-line one gets "looks good".

## For the reviewer

1. Reply within a day, even if only to say when you will look.
2. Separate "this must change" from "I would have done it differently".
3. Say what is good, not only what is wrong.
4. Approve when it is better than what is on `main`, not when it is
   perfect.
