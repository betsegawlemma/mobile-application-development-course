# Project ideas

Fifteen ideas with local relevance. Each lists the scope for a group of
four, the course topics it exercises, and the main risk. You may propose
your own idea; use the same questions to check it.

**Every project needs** local persistence, a REST source, Firebase (Auth
and Firestore), one device feature and one AI feature (see
[README.md](README.md)). The "Topics exercised" column shows what an idea
needs naturally; add the parts it lacks where they serve a user story.

**Scope guide.** *Small* — four to five screens. *Medium*
— six to eight screens, authentication, one or two device features.
*Large* — only with a convincing plan; ambition without completion scores
poorly.

| # | Idea | Scope | Topics exercised | Main risk |
|---|---|---|---|---|
| 1 | **Campus events and clubs** — browse events, register, club pages, organiser posting | Small–Medium | REST and Firestore, auth, lists, forms | Needs an organiser role and moderation |
| 2 | **Lost and found for campus** — post found items with photo and location, claim them | Small | Firebase Auth, Firestore, Storage, camera, location | Photo upload on slow networks; privacy of finders |
| 3 | **Minibus and Anbessa bus route helper** — routes, stops, fares, nearest stop | Medium | Local database (drift), location, maps | Route data must be collected by the group |
| 4 | **Cafeteria / cafe menu and queue** — daily menu, pre-order, estimated queue | Medium | REST backend, auth, notifications | Needs cooperation from a cafe owner |
| 5 | **Study group finder** — courses, availability, matching, chat | Medium | Firestore real-time, auth, forms | Chat scope can grow without limit; keep it simple |
| 6 | **Library seat and book reservation** — availability, reservation, reminders | Small–Medium | REST backend, local notifications | Data must be simulated if the library has no API |
| 7 | **Farm advisory (Amharic-first)** — crop calendar, weather, market prices, offline articles | Medium | Localisation, local persistence, REST (weather/price API), offline-first | Content quality; needs a domain contact |
| 8 | **Small-business inventory and sales** — products, stock, sales log, daily report | Small | drift, forms, charts, export | Multi-user sync is out of scope; keep single device |
| 9 | **Telebirr-style expense tracker** — categories, budgets, SMS import (optional), charts | Small | drift, forms, charts, permissions | SMS reading needs careful permission handling; make it optional |
| 10 | **Clinic appointment booking** — clinics, slots, booking, reminders | Medium | REST backend, auth, notifications | Realistic slot logic; do not store real patient data |
| 11 | **Blood donation coordinator** — donor profiles, requests, nearby donors | Medium | Firebase, location, notifications | Sensitive data; strict privacy rules required |
| 12 | **Amharic flashcards and quiz** — decks, spaced repetition, progress | Small | drift, animations, gestures (swipe), localisation | Spaced-repetition algorithm must be tested |
| 13 | **Campus navigation** — buildings, rooms, routes, accessibility notes | Medium | Maps or custom image maps, location, local data | Map data collection; offline maps |
| 14 | **Equb (rotating savings) manager** — groups, contributions, turns, reminders | Small–Medium | Firestore, auth, notifications | Financial correctness; no real payments |
| 15 | **Tutoring marketplace** — tutors, subjects, booking, ratings | Medium | Firebase, auth, reviews, chat (optional) | Trust and moderation; ratings need rules |

## Questions to check your own idea

1. Can you describe the user in one sentence and name one real person who
   fits it?
2. Can you build a working version of the "must" stories by week 6
   (Milestone 1) with in-memory data, and add the real data source by
   week 10 (Milestone 2)?
3. Where does the data come from, and what happens when the network is
   unavailable?
4. Does the idea require a paid service, a partner organisation or data
   you do not have? If so, what is the fallback?
5. Does it store personal or financial data? If so, how is it protected,
   and can you use fake data for the demonstration?
