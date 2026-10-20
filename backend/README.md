# campus_backend

A small REST API in Dart (`package:shelf`) that serves the Campus
Companion events feed. Used from week 9 of the course. Data is kept in
memory and reset on restart.

## Run

```bash
cd backend
dart pub get
dart run bin/server.dart          # http://localhost:8080
```

From an **Android emulator** the host machine is `http://10.0.2.2:8080`.
From a **physical phone** on the same Wi-Fi use your computer's LAN
address, e.g. `http://192.168.1.20:8080` (find it with `ip addr` /
`ipconfig`), and allow the port through your firewall. From the iOS
simulator, `http://localhost:8080` works.

With Docker:

```bash
docker build -t campus-backend .
docker run --rm -p 8080:8080 campus-backend
```

## Endpoints

| Method | Path | Purpose |
|---|---|---|
| GET | `/health` | liveness |
| GET | `/events?page=1&limit=20` | paged list, soonest first |
| GET | `/events/{id}` | one event (404 if missing) |
| POST | `/events` | create (201; 422 on validation error) |
| PUT | `/events/{id}` | replace (200; 404; 422) |
| DELETE | `/events/{id}` | delete (204; 404) |
| GET | `/fail` | always 500 — for testing error handling |
| GET | `/slow?seconds=3` | responds after `seconds` seconds (default 3, at most 60; 400 otherwise) — for testing loading states and timeouts |

Every response is JSON, including errors: `{"error": "...", "status": 404}`.
Full contract: [`openapi.yaml`](openapi.yaml). Ready-made requests:
[`requests.http`](requests.http) (VS Code REST Client) — or import the
OpenAPI file into Bruno or Postman.

## Test

```bash
dart test
```

The tests call the handler directly with `shelf` `Request` objects; no
port is opened.

## Deploying (optional)

Any host that runs a Docker image works (Fly.io, Render, a VPS). Set the
`PORT` environment variable if the host requires a different port. The
course does not require a deployed instance; the local server is enough.
