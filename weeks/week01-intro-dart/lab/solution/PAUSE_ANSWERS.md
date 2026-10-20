# Week 1 — answers to the lecture pause questions

For the instructor. These answers were removed from the speaker notes in
`slides.md`, because students can read the speaker notes before the
lecture. Ask students to write their prediction on paper (or vote by show
of hands) before you reveal the answer.

1. **What happens?** (hot reload) — The first change appears at once. The
   second does nothing: hot reload does not re-run `main()`. Hot restart
   (`R`) is needed.
2. **What prints?** — `10 5`. `b` was computed while `a` was null, so it is
   5. Then `a ??= 10` assigns 10.
3. **What is the type, and what prints?** — `evens` is an `Iterable<int>`
   (lazy). `print(evens)` prints `(2, 4)`; `evens.toList()` prints `[2, 4]`.
   `where` is lazy; call `toList()` when you need a `List`.
