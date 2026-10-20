# Week 2 — answers to the lecture pause questions

For the instructor. These answers are not in the speaker notes of
`slides.md`, because students can read the speaker notes before the
lecture. Ask students to write their prediction on paper (or vote by show
of hands) before you reveal the answer.

1. **What prints?** (`Assignment.copyWith`) — `A`, `false`, `true`.
   `copyWith` returns a new object, so `a` keeps the title `A`. `a == b`
   is false because the titles differ. `a == a.copyWith()` is true
   because `==` compares the field values, not the identity of the
   objects.
2. **Order of output?** — `1`, `2`, `Adama: sunny`, `3`. Calling an
   `async` function starts it at once; `main` only pauses at the `await`.
3. **Predict the callbacks** (`TickCounter`) — `didUpdateWidget`, then
   `build`, then `dispose`. No `initState`: the parent passed a widget of
   the same type at the same place, so the `State` is kept and `_ticks`
   keeps its value; `didUpdateWidget` sees the new interval and restarts
   the timer. While time passes, each tick calls `setState`, so `build`
   also runs once per tick. When the widget is removed, `dispose` cancels
   the timer and the `State` (with `_ticks`) is gone.
