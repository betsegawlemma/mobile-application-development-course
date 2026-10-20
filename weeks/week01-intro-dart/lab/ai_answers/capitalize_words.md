# Saved assistant answer

**Prompt:** Write a Dart function `capitalizeWords(String text)` that makes
the first letter of each word upper case. Explain how it works.

---

**Answer:**

Here is a simple and efficient solution:

```dart
String capitalizeWords(String text) {
  return text
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}
```

How it works:

1. `split(' ')` breaks the text into words. It ignores repeated spaces, so
   `'hello   world'` works correctly too.
2. For each word, `word[0].toUpperCase()` makes the first letter upper
   case, and `word.substring(1)` keeps the rest of the word unchanged.
3. `join(' ')` puts the words back together with single spaces.

Example:

```dart
print(capitalizeWords('addis ababa university')); // Addis Ababa University
```

Tip: for a single word you can also simply call `'hello'.capitalize()`,
which Dart provides on every `String`.

This function handles all inputs safely.
