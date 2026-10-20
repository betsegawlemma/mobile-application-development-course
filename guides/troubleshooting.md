# Troubleshooting

Errors you are likely to meet in this course, with the fix. Search this
page before asking — and if your problem is not here, add it in a pull
request.

## Installation and tooling

**`flutter: command not found`**
`flutter/bin` is not on your `PATH`, or you edited the wrong shell
profile. Open a **new** terminal after editing. Check with
`which flutter`.

**`flutter doctor` says "Unable to locate Android SDK"**
Install Android Studio, open it once, and let it install the SDK. If it
is elsewhere: `flutter config --android-sdk /path/to/Sdk`.

**"Android licence status unknown"**
```bash
flutter doctor --android-licenses     # accept each one
```
If that fails, install *Android SDK Command-line Tools* in Android
Studio → SDK Manager → SDK Tools, then run it again.

**`cmdline-tools component is missing`**
The same place: SDK Manager → SDK Tools → *Android SDK Command-line
Tools (latest)*.

**Gradle downloads forever, or fails with a timeout**
The first Android build downloads several hundred megabytes. On a slow
connection, leave it; if it fails, run `flutter build apk` again — it
resumes. A proxy needs `systemProp.http.proxyHost` in
`android/gradle.properties`.

**`Could not resolve all files for configuration`**
Usually a network failure mid-download. `flutter clean`, then build
again.

**A Java version error from Gradle**
Use JDK 17 or 21. Check with `java -version`; point Flutter at the right
one with `flutter config --jdk-dir <path>`.

**`flutter pub get` fails because there is no network**
Ask a TA for the USB drive with the filled package cache (`pub-cache`).
Copy the folder to your home folder, set `PUB_CACHE` to it (Linux and
macOS: `export PUB_CACHE=$HOME/pub-cache`; Windows: `setx PUB_CACHE
%USERPROFILE%\pub-cache`, then open a new terminal), and run
`flutter pub get --offline`. Lab 1, "Without internet", has the steps.

## Dart and build

**"Target of URI doesn't exist: 'x.g.dart'" / "undefined name `fooProvider`"**
You changed an annotated file and did not regenerate:
```bash
dart run build_runner build -d
```
Keep `dart run build_runner watch -d` running while you work.

You only need this when you change a file that has an annotation
(`@riverpod`, `@freezed`, `@JsonSerializable`, a drift table). The
generated files are committed, so a lab runs without `build_runner`.

**`build_runner` prints "These options have been removed and were ignored: --delete-conflicting-outputs"**
Harmless. The `build_runner` version in the course deletes conflicting
outputs without being asked, so `-d` is no longer needed; the course
commands keep it so that they also work with older versions. A warning
that the "SDK language version is newer than `analyzer` language
version" is also harmless when the build finishes and `flutter analyze`
is clean.

**"The getter 'x' isn't defined for the type 'AppLocalizations'"**
You added a message to `app_en.arb` but did not regenerate:
```bash
flutter gen-l10n
```

**Analyzer errors everywhere after opening the project**
`flutter pub get` has not run, or the IDE is using the wrong SDK.
Run it, then restart the analysis server (VS Code: *Dart: Restart
Analysis Server*).

**"Because campus_companion depends on X which requires Y…"**
A version conflict. `flutter pub upgrade --major-versions`, or pin the
older package. Read the message from the bottom up — the last line names
the real conflict.

## Running the app

**"No devices found"**
`flutter devices`. For Android, start an emulator from Android Studio or
`flutter emulators --launch <id>`; check `adb devices` lists it. For a
physical phone, enable *Developer options → USB debugging* and accept
the prompt on the phone.

**The app builds but shows a black or white screen**
Look at the console. Usually an exception in `main` — often Firebase
started without `WidgetsFlutterBinding.ensureInitialized()`.

**Hot reload does nothing**
You changed `main()`, a global, an enum, or a class's shape. Press `R`
for a hot restart.

**"setState() called after dispose()"**
An `await` finished after the user left the screen. Add
`if (!mounted) return;` before `setState`.

**"A RenderFlex overflowed by N pixels"**
Week 3. A `Text` in a `Row` needs `Expanded`; a `Column` needs its
children to fit. Check at 320 dp and with a large font.

**"Vertical viewport was given unbounded height"**
A `ListView` or `TabBarView` directly inside a `Column`. Wrap it in
`Expanded`.

**"No Material widget found"**
An `InkWell` or `ListTile` outside a `Material` ancestor. Wrap it in
`Material` or put it inside a `Scaffold` body or a `Card`.

**I cannot pinch on the emulator**
On the Android emulator, hold **Ctrl** (**Command** on macOS) and drag
with the mouse: two touch points move towards or away from each other.
Both points must land inside the widget, so scroll it to the middle of
the screen first. Chrome gives one pointer only, so you cannot pinch
there. The emulator's pinch is not exactly like two fingers; check on a
real phone when you can (week 7 lab, Task 5).

**"Unable to load asset: assets/images/x.png"**
The folder is not declared under `flutter: assets:` in `pubspec.yaml`,
or you did not hot **restart** after adding it.

## Network

**"No connection to the server" on a device but not the emulator**
`10.0.2.2` only means the host machine inside the Android emulator. Use
your computer's LAN address:
`flutter run --dart-define=API_URL=http://192.168.1.20:8080`, with the
phone on the same Wi-Fi and the port open in the firewall.

**A release build cannot reach an `http://` URL**
Android blocks cleartext traffic in release builds. Use HTTPS, or add a
network security configuration for development only.

**Requests never finish, and no error appears**
No timeouts set on the client. See week 9 (`connectTimeout`,
`receiveTimeout`).

**A CORS error in Flutter web**
The server must send `Access-Control-Allow-Origin`. The course backend
does; a third-party API may not, which is a reason to call it through
your own server.

## Firebase

**"No Firebase App '[DEFAULT]' has been created"**
`Firebase.initializeApp` did not run, or ran after the code that used
it. It belongs in `main`, after
`WidgetsFlutterBinding.ensureInitialized()`.

**`permission-denied` from Firestore**
The security rules rejected the operation. Read the rule that applies,
check `request.auth` is not null, and remember that rules do not filter:
a query that could return a forbidden document is rejected entirely.

**Nothing happens when writing, and no error**
You are writing to the emulator while reading from production, or the
reverse. Check the `USE_FIREBASE_EMULATOR` flag and the console output
at start-up.

**"Cloud Firestore backend didn't respond"**
The emulator is not running, or the host is wrong — `10.0.2.2` on the
Android emulator, `localhost` on the iOS simulator, and your computer's
address (`--dart-define=FIREBASE_EMULATOR_HOST=...`) on a physical phone.

## Ports and emulators

The course uses these ports on your computer:

| Service | Port |
|---|---|
| REST backend (`backend/`) | 8080 |
| Firestore emulator | 8081 |
| Authentication emulator | 9099 |
| Storage emulator | 9199 |
| Emulator UI | 4000 |

**"Port 8080 is not open" or "Could not start Firestore Emulator"**
Another program uses the port. Check that you start the emulators from a
folder whose `firebase.json` sets Firestore to 8081
(`weeks/week10-firebase/firebase/` or
`weeks/week10-firebase/lab/starter/firebase/`). To find the program, run
`lsof -i :8080` (Linux, macOS) or `netstat -ano | findstr :8080`
(Windows), and stop it.

**The backend says "Address already in use"**
A backend from an earlier terminal is still running, or the Firestore
emulator was started with an old `firebase.json` on 8080. Stop both and
start them again: the backend first, then the emulators.

**"firebase: command not found" or the emulators do not start**
`firebase-tools` needs Node.js (LTS), and the Firestore and Storage
emulators need a Java runtime (JDK 21 or newer). Check `node --version`
and `java -version`. The first `firebase emulators:start` downloads the
emulator files, so run it once while you have internet.

**`npm install` fails with `ERESOLVE` or a peer dependency conflict**
The rules tests need `@firebase/rules-unit-testing` 5 together with
`firebase` 12, as in the course `package.json`. If you changed these
versions, or copied an older `package.json`, put the course versions
back, delete `node_modules/` and `package-lock.json`, and run
`npm install` again. Do not use `--force`.

**How do I run the rules tests against `weak.rules`?**
`rules.test.js` reads the rules file name from the environment variable
`RULES_FILE` (default `firestore.rules`). Setting a variable differs
between shells, so use the script, which works on every operating
system:
```bash
firebase emulators:exec --only firestore "npm run test:weak"
```
The test names start with the name of the rules file that was tested.
In lab 10, Task 5, some tests are meant to fail against `weak.rules`.

**A physical phone cannot reach the emulators**
1. The phone and the computer must be on the same Wi-Fi.
2. Pass your computer's address:
   `flutter run --dart-define=USE_FIREBASE_EMULATOR=true --dart-define=FIREBASE_EMULATOR_HOST=192.168.1.20 --dart-define=API_URL=http://192.168.1.20:8080`.
3. The course `firebase.json` files set `"host": "0.0.0.0"`, so the
   emulators accept connections from the network. Allow ports 8080, 8081,
   9099 and 9199 in your computer's firewall.
4. Some campus Wi-Fi networks block traffic between devices. Use your
   phone's hotspot for the computer instead.

## Database

**"no such column" after an update**
A schema change without a migration. See week 8: bump `schemaVersion`
and add the `onUpgrade` step. During development you can also uninstall
the app to start with a fresh database.

**"Failed to load dynamic library" in a drift test**
The drift tests (`NativeDatabase.memory()`) run SQLite on your computer,
not on the phone, so the computer needs the SQLite library. On the phone
the app uses the library from `sqlite3_flutter_libs`.

- **Linux** (`libsqlite3.so`): `test/sqlite_test_support.dart` falls
  back to `libsqlite3.so.0`, which every distribution with SQLite has.
  If that also fails, install SQLite (`sudo apt install libsqlite3-0`, or
  `libsqlite3-dev`).
- **Windows** (`sqlite3.dll` or `winsqlite3.dll`): the `sqlite3` package
  first tries `sqlite3.dll`, then `winsqlite3.dll`, which is part of
  Windows 10 and 11. If both fail, download the 64-bit "Precompiled
  Binaries for Windows" DLL from https://sqlite.org/download.html, unzip
  `sqlite3.dll` into a folder, add that folder to the `PATH`, and open a
  new terminal. (Ask a TA for the file if you have no network.)
- **macOS**: the `sqlite3` package uses the SQLite that comes with macOS
  (`/usr/lib/libsqlite3.dylib`); nothing to install.

## Tests

**A widget test fails with "Null check operator used on a null value" after adding localisation**
The test's `MaterialApp` has no localisation delegates. Use the
`localisedApp` helper.

**`pumpAndSettle` times out**
Something animates forever — usually a `CircularProgressIndicator`. Use
`pump(duration)` instead.

**A test passes alone and fails with the others**
Shared state. Create objects in `setUp`; use `ProviderContainer.test()`;
clean up after integration tests.

**A test of a failing provider never finishes**
Riverpod is retrying. Pass `retry: (retryCount, error) => null`.

**Golden tests fail on another machine**
Images made on one operating system can differ by a few pixels from
images made on another. The course's images are made on Linux, like the
CI runner. On Windows or macOS, skip them with `flutter test -x golden`,
and make new images on Linux (for example with a CI job started by hand;
see the week 12 lab, Task 3c).

## Getting help well

When you ask — in the lab, in Discussions, or from an AI assistant —
include:

1. what you were doing;
2. the **full** error message, as text, not a photo of the screen;
3. what you have already tried;
4. the relevant code, as a small example;
5. `flutter doctor -v` output for anything environmental.

Half the time, writing this out finds the answer before you send it.
