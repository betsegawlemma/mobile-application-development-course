import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';

import 'events_store.dart';

/// Builds the HTTP handler. Separate from `main` so tests can call it
/// without opening a port.
Handler buildApi(EventsStore store) {
  final router = Router()
    ..get('/', (Request _) => _json({'name': 'campus_backend', 'status': 'ok'}))
    ..get('/health', (Request _) => _json({'status': 'ok'}))
    ..get('/events', (Request req) => _listEvents(store, req))
    ..get('/events/<id>', (Request _, String id) => _getEvent(store, id))
    ..post('/events', (Request req) => _createEvent(store, req))
    ..put(
      '/events/<id>',
      (Request req, String id) => _updateEvent(store, req, id),
    )
    ..delete('/events/<id>', (Request _, String id) => _deleteEvent(store, id))
    // Deliberately broken endpoint so the app's error handling can be
    // exercised without turning the server off.
    ..get('/fail', (Request _) => _error(500, 'Simulated server failure'))
    // Slow endpoint for testing loading states and timeouts:
    // /slow waits 3 seconds, /slow?seconds=15 waits 15.
    ..get('/slow', _slow);

  return const Pipeline()
      .addMiddleware(logRequests())
      // CORS lets Flutter web (and browser tools) call the API.
      .addMiddleware(corsHeaders())
      .addMiddleware(_jsonErrors())
      .addHandler(router.call);
}

/// The longest wait `/slow` accepts, so a typing mistake cannot keep a
/// request open for hours.
const maxSlowSeconds = 60;

Future<Response> _slow(Request req) async {
  final text = req.url.queryParameters['seconds'];
  final seconds = text == null ? 3 : int.tryParse(text);
  if (seconds == null || seconds < 0 || seconds > maxSlowSeconds) {
    return _error(
      400,
      'seconds must be a whole number from 0 to $maxSlowSeconds',
    );
  }
  await Future<void>.delayed(Duration(seconds: seconds));
  return _json({'status': 'finally', 'seconds': seconds});
}

Response _listEvents(EventsStore store, Request req) {
  final page = int.tryParse(req.url.queryParameters['page'] ?? '1') ?? 1;
  final limit = int.tryParse(req.url.queryParameters['limit'] ?? '20') ?? 20;
  if (page < 1 || limit < 1 || limit > 100) {
    return _error(400, 'page must be >= 1 and 1 <= limit <= 100');
  }
  final items = store.list(page: page, limit: limit);
  return _json({
    'items': items,
    'page': page,
    'limit': limit,
    'total': store.count,
  });
}

Response _getEvent(EventsStore store, String id) {
  final event = store.find(id);
  return event == null ? _error(404, 'Event $id not found') : _json(event);
}

Future<Response> _createEvent(EventsStore store, Request req) async {
  final body = await _readJson(req);
  try {
    final created = store.create(body);
    return _json(created, status: 201);
  } on ValidationError catch (e) {
    return _error(422, e.message);
  }
}

Future<Response> _updateEvent(EventsStore store, Request req, String id) async {
  final body = await _readJson(req);
  try {
    final updated = store.update(id, body);
    return updated == null
        ? _error(404, 'Event $id not found')
        : _json(updated);
  } on ValidationError catch (e) {
    return _error(422, e.message);
  }
}

Response _deleteEvent(EventsStore store, String id) {
  return store.delete(id) ? Response(204) : _error(404, 'Event $id not found');
}

Future<EventJson> _readJson(Request req) async {
  final text = await req.readAsString();
  final decoded = text.isEmpty ? null : jsonDecode(text);
  if (decoded is! Map<String, Object?>) {
    throw const FormatException('Request body must be a JSON object');
  }
  return decoded;
}

Response _json(Object body, {int status = 200}) => Response(
  status,
  body: jsonEncode(body),
  headers: {'content-type': 'application/json; charset=utf-8'},
);

Response _error(int status, String message) =>
    _json({'error': message, 'status': status}, status: status);

/// Turns uncaught FormatExceptions into 400 responses and anything else
/// into a 500 with a JSON body, so clients always get JSON.
Middleware _jsonErrors() =>
    (inner) => (req) async {
      try {
        return await inner(req);
      } on FormatException catch (e) {
        return _error(400, e.message);
      } catch (e) {
        return _error(500, 'Internal error: $e');
      }
    };
