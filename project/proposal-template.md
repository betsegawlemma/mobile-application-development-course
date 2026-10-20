# Project proposal

**Due:** end of week 3 · **Submit:** commit it as `PROPOSAL.md` in the root
of your group's repository and tag that commit `proposal`

Replace every *italic* instruction with your own text. Keep the whole
proposal under four pages.

---

## 1. Title and one-sentence description

*A working title and one sentence: "An app that helps [users] to [do
what] so that [benefit]."*

## 2. Group

*Student IDs, emails and GitHub usernames are in `project.yaml`; do not
repeat them here.*

| Name | Role |
|---|---|
| | *e.g. team lead, UI, data/backend, testing* |
| | |
| | |
| | |

*Roles are starting points; everyone writes code in every layer.*

## 3. The problem

*Who has this problem? How do they deal with it today? Why is a mobile
app the right solution? Two or three paragraphs. If you have talked to a
potential user, say what you learned.*

## 4. Users

*Describe two or three types of user (for example, "a first-year student
who does not know the campus" and "a club organiser who posts events").
For each: what they need from the app and how often they would use it.*

## 5. User stories

*Five to eight, in the form "As a [user type], I want [action] so that
[benefit]." Mark each as **must**, **should** or **could**. The "must"
stories define your minimum product.*

1. As a …, I want … so that …. (**must**)
2. …

## 6. Screens

*List every screen with one line describing what it shows and which user
stories it serves. Add hand-drawn or simple digital sketches for the four
most important screens (photos of paper sketches are fine).*

| Screen | Purpose | User stories |
|---|---|---|
| | | |

## 7. Data model

*The main entities and their fields, and how they relate. A simple
diagram or a list such as:*

```
Event: id, title, start, venue, description, organiserId
User: id, name, email, programme
Registration: userId, eventId, createdAt
```

## 8. Data sources

*Which data is stored locally (and with what: shared_preferences, drift)?
Which comes from a REST web service (one you build or find), and which
from Firebase (Auth, Firestore)? Every project needs local persistence, a
REST source and Firebase.*

## 9. Device feature and AI feature

*Every project needs one device feature (camera, location or a sensor)
**and** one AI feature (for example a summary or a suggestion). For each,
say which user story needs it. For the device feature, say which
permissions it asks for; for the AI feature, what data is sent and to
whom.*

## 10. Risks

*Three to five things that could go wrong (a third-party API might be
unavailable, a feature might need a paid service, a member has exams)
and what you will do about each.*

| Risk | Likelihood | Plan |
|---|---|---|
| | | |

## 11. Milestone plan

*Which user stories will be complete at Milestone 1 (week 6), Milestone 2
(week 10) and the final submission (week 14)? Milestone 1 should contain
all screens with navigation and in-memory state; Milestone 2 should
contain real data.*

## 12. AI-use plan

*Which AI tools, if any, does the group intend to use, and for what
(learning, generating boilerplate, reviewing code, writing tests)? See
`../syllabus/policies.md`.*

---

## How the proposal is marked (10 points)

| Criterion | Points |
|---|---|
| The problem and the users are specific, and one real person who has the problem is named | 2 |
| User stories in the given form, each marked must, should or could | 2 |
| The screens and the data model cover every "must" story | 2 |
| Local, REST and Firebase data named, and a device feature and an AI feature chosen | 2 |
| Risks and the milestone plan are realistic for four people and the course weeks | 2 |

## Approval

The instructor returns each proposal with one of these decisions and a
short written comment:

- **Approved.**
- **Approved with changes** — the changes are listed; make them before
  Milestone 1.
- **Revise and resubmit by the end of week 4** — the group may not start
  Milestone 1 work on the parts that must be revised.
