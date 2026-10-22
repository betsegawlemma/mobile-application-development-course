# Using AI assistants well

This guide is the practical companion to the AI-use policy in
`../syllabus/policies.md` and to week 13. It is about tools such as
Claude, ChatGPT, Gemini and GitHub Copilot when you are writing Flutter
code.

The short version: **an assistant produces a draft; you are responsible
for the result.** Everything below follows from that.

---

## 1. What they are good at, and what they are not

| Good at | Weak at |
|---|---|
| Explaining an error message | Knowing your code base |
| Code you could write yourself but do not need to practise | Choosing an architecture for your project |
| A first draft of a test from a description | Knowing which package version you are on |
| Translating between languages or styles | Anything that needs current documentation |
| Reviewing your code for obvious problems | Admitting when it does not know |

The last row matters most. A model will answer confidently with a method
that does not exist, a package that was renamed, or an API from three
versions ago. This is not rare; plan for it.

---

## 2. Prompting for Flutter work

### Give it the constraints
A bad prompt: *"my code does not work"*. A useful one:

> I am on Flutter 3.47.7 with flutter_riverpod 3.3. `flutter analyze`
> says *"The getter 'valueOrNull' isn't defined for the type
> 'AsyncValue<List<Room>>'"* on this line: *(paste the line)*. Explain
> what the error means and what to use in this version. Do not rewrite
> the rest of the file.

Name the versions, the packages, the file, and what must **not** change.
Then check the answer: the package's `CHANGELOG.md` says what was
removed and what replaces it.

### Labs and projects are different
In your project, where you choose the tasks, a precise contract helps:
a test you wrote, or the interface that must not change.

**In a lab, do not paste the lab's test and ask for code that passes it.
That is the lab's work, not yours.** The tests turn green, and you still
do not know whether you could write the code yourself. Follow the AI-use
level under each lab task (`../syllabus/policies.md`), and see "Using an
assistant while you are learning" in the week 1 and week 13 notes.

### Ask for the shape you want
> Return only the changed method, with the same style as the file I
> pasted. British spelling in comments. No `print`.

### Ask it to explain, then check the explanation
> Explain what `ref.watch` does differently from `ref.read` in this
> notifier, and what breaks if I swap them.

Check each sentence of the explanation against the documentation, the
package source or a small test. If the explanation is wrong, the code it
came with may be wrong too. An explanation can also be wrong when the
code is right.

### Ask for alternatives when you are deciding
> Give me two ways to do this, with the trade-offs, and say which you
> would pick for a student project with two weeks left.

---

## 3. Verifying what comes back

Week 1 gave you a five-step check: predict, run, analyse, test, and
check every claim. This longer checklist adds the questions that matter
once your app has layers, packages and users. Run it on every block of
more than a few lines that you keep.

1. **Does it compile?** `flutter analyze --fatal-infos`.
2. **Do the tests pass?** If there is no test, write one before you
   trust the code.
3. **Does every API exist?** Search the package documentation for each
   unfamiliar method. Invented methods are the most common failure.
4. **Is it for the right version?** Riverpod 2 and 3 differ; so do
   Flutter 3.16 and 3.47. Check the package's changelog if something
   looks unfamiliar.
5. **Does it fit this code base?** Does it respect the layers
   (`presentation → data → domain`), use the repository, use
   `AppException`?
6. **Can you explain every line?** If not, either learn it or delete it.
   This is also a course rule.
7. **Is anything unsafe?** Hard-coded keys, disabled certificate checks,
   `catch (_) {}` that hides errors, SQL built by string concatenation.
8. **Is anything wasteful?** A rebuild of a whole list, an image at full
   resolution, a request inside `build`.

---

## 4. What not to paste into an assistant

- **Secrets**: API keys, service-account files, `google-services.json`,
  passwords, tokens. Assume anything you paste is stored.
- **Personal data**: real names, phone numbers, student records, another
  person's message. If your app holds user data, use invented examples.
- **Code you are not allowed to share**: an employer's or client's
  source.
- **Exam, exit-task or quiz questions.** Exams and exit tasks are
  AI-free, and you answer a quiz before you open the answers or any
  tool (see the policy).

When you need help with code that contains something sensitive, reduce
it to a small example with invented values first. That usually produces
a better answer anyway.

---

## 5. Licensing and attribution

- Generated code can resemble its training data. For anything longer
  than a few lines, check that you are not reproducing a recognisable
  library.
- Some assistants can cite sources; when they do, follow the link and
  check the licence.
- In this course, mark a substantial kept block with a comment:
  ```dart
  // Generated with <tool>, reviewed and modified by <name>.
  ```
  and record it in the AI note of the lab, or in your group's
  `AI_USAGE.md` for project work (template in
  `../project/AI_USAGE-template.md`).
- Employers differ: some forbid assistants entirely, some require
  disclosure, some provide their own. Ask on your first day.

---

## 6. Building an AI feature into an app

This is a different question from using an assistant to write code.
Week 13's lab adds a note summariser; the structure it uses is the one
to copy.

### Put it behind an interface
```dart
// weeks/week13-responsible-ai/lab/solution/lib/features/ai/domain/summariser.dart
abstract interface class Summariser {
  Future<Summary> summarise(String text);
  bool get sendsDataOffDevice;
}
```

The app depends on the interface, not on a vendor. The offline stub, an
on-device model and a cloud API all satisfy it, and swapping them is one
line in a provider.

### On device or in the cloud?

| | On device | Cloud |
|---|---|---|
| Privacy | text never leaves the phone | text is sent to a third party |
| Cost | none per use | per request |
| Works offline | yes | no |
| Quality | limited by the phone | best available models |
| Size | tens of megabytes in the app | none |
| Latency | fast, predictable | network-dependent |

For a student project, prefer on-device or a stub. If you use a cloud
model, do not ship the API key in the app: a client binary can be read,
and a leaked key is charged to you. Calls go through a small server of
yours (the week 9 backend is the shape) that holds the key.

### Rules the UI must enforce
1. **Ask before sending.** The app shows a consent dialog before it uses
   a summariser whose `sendsDataOffDevice` is true.
2. **Label the output.** Every summary carries a disclosure line: people
   have a right to know when text was produced by a machine.
3. **Never replace the user's text silently.** Offer the result; let
   them decide.
4. **Handle failure.** Models are slow, rate-limited and sometimes
   wrong. The screen shows a message and still works, and the user's
   text is unchanged. Write a test for this case.

### Prompt injection
Text from a user — or from a web page, or a document — can contain
instructions aimed at the model ("ignore your instructions and …").
No technique removes this risk completely; you reduce it in layers.
First, keep the instruction and the data separate. The week 13 lecture
example asks a cloud model for tags for a note title:

```dart
// weeks/week13-responsible-ai/lab/solution/lib/exercises/lecture_ai.dart
static Map<String, Object> body(String title) => {
  'model': 'example-model',
  'max_tokens': 20,
  'messages': [
    {'role': 'system', 'content': instruction},
    // The title is its own message: it is data, not part of the
    // instruction.
    {'role': 'user', 'content': title},
  ],
};
```

Separate messages reduce the risk, but a model can still follow
instructions it finds in a user message. So, second, treat the output as
untrusted: show it, never execute it, and never let it trigger an action
(delete, send, pay) without a human confirming. Never build an
instruction by concatenating user text into it.

### Cost and limits
Cloud models charge per token and enforce rate limits. Send only what is
needed, cap the response length (`max_tokens`), cache results, and put a
sensible limit on how often a user can trigger the feature. Section 10
of the week 13 notes works through a monthly cost for 500 users.

---

## 7. Honest use in this course

You are allowed to use assistants for labs and the project, at the
AI-use level printed under each lab task:

| Level | Name | In short |
|---|---|---|
| 0 | No AI | Write it yourself; the task trains the skill. |
| 1 | Explain only | Ask for an explanation; do not paste its code. |
| 2 | Review | Write it first, then ask for a review and record what it found. |
| 3 | Draft and verify | An assistant may draft; you run the checklist and record the result. |

What you must do:

- **disclose** in the three-line AI note at the end of each lab, which
  the TA reads at a checkpoint, and in `AI_USAGE.md` with your
  individual declaration at each project milestone;
- **understand** everything you submit. TA checkpoints in labs and
  individual oral checks at milestones test this. If you cannot explain
  a part, that part earns no credit and you get a second check; this is
  not misconduct by itself;
- **verify** before you keep it;
- **keep exit tasks and exams AI-free**, and answer each quiz before you
  open the answers or any tool.

The full rules are in `../syllabus/policies.md`.

A group that used an assistant well — with a disclosure that names what
was generated, what was changed and what was found wrong in it — scores
better than one that pretends not to have used it. The reflection in
week 13's lab asks what you can explain without an assistant, and what
you cannot yet.

## Further reading

- Flutter documentation (the source of truth for APIs): https://docs.flutter.dev
- pub.dev changelogs, for when a model's answer is version-confused
- OWASP top ten for large language model applications:
  https://owasp.org/projects/top-10-for-large-language-model-applications
- Your own AI notes from earlier labs and your group's `AI_USAGE.md` —
  read them again at the end of the term and see what you would do
  differently.
