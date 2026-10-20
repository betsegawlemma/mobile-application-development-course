import 'dart:convert';

import 'package:campus_backend/api.dart';
import 'package:campus_backend/events_store.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

void main() {
  late Handler api;

  setUp(() => api = buildApi(EventsStore()));

  Future<Response> call(String method, String path, {Object? body}) async {
    return await api(
      Request(
        method,
        Uri.parse('http://localhost$path'),
        body: body == null ? null : jsonEncode(body),
        headers: {'content-type': 'application/json'},
      ),
    );
  }

  Future<Map<String, Object?>> json(Response r) async =>
      jsonDecode(await r.readAsString()) as Map<String, Object?>;

  test('GET /events lists seed data with paging metadata', () async {
    final r = await call('GET', '/events?limit=2');
    expect(r.statusCode, 200);
    final body = await json(r);
    expect((body['items'] as List).length, 2);
    expect(body['total'], 6);
    expect(body['page'], 1);
  });

  test('GET /events?page=2&limit=4 returns the remainder', () async {
    final body = await json(await call('GET', '/events?page=2&limit=4'));
    expect((body['items'] as List).length, 2);
  });

  test('GET /events rejects a bad limit with 400', () async {
    expect((await call('GET', '/events?limit=0')).statusCode, 400);
  });

  test('GET /events/:id returns one event or 404', () async {
    expect(
      (await json(await call('GET', '/events/e1')))['title'],
      'Flutter study group',
    );
    expect((await call('GET', '/events/nope')).statusCode, 404);
  });

  test('POST /events creates and returns 201 with an id', () async {
    final r = await call(
      'POST',
      '/events',
      body: {
        'title': 'New',
        'start': '2026-11-01T10:00:00.000',
        'venue': 'online',
      },
    );
    expect(r.statusCode, 201);
    final created = await json(r);
    expect(created['id'], isA<String>());
    expect(created['isFree'], isTrue, reason: 'default applied');

    final list = await json(await call('GET', '/events?limit=100'));
    expect(list['total'], 7);
  });

  test('POST /events validates the body with 422', () async {
    final r = await call(
      'POST',
      '/events',
      body: {'title': '', 'start': 'x', 'venue': 'moon'},
    );
    expect(r.statusCode, 422);
    expect((await json(r))['error'], contains('title'));
  });

  test('POST /events with a non-JSON body returns 400', () async {
    final r = await api(
      Request('POST', Uri.parse('http://localhost/events'), body: 'not json'),
    );
    expect(r.statusCode, 400);
  });

  test('PUT /events/:id replaces the event', () async {
    final r = await call(
      'PUT',
      '/events/e1',
      body: {
        'title': 'Renamed',
        'start': '2026-10-14T16:00:00.000',
        'venue': 'technology',
      },
    );
    expect(r.statusCode, 200);
    expect((await json(r))['title'], 'Renamed');
    expect(
      (await call(
        'PUT',
        '/events/nope',
        body: {
          'title': 'x',
          'start': '2026-01-01T00:00:00.000',
          'venue': 'online',
        },
      )).statusCode,
      404,
    );
  });

  test('DELETE /events/:id returns 204 then 404', () async {
    expect((await call('DELETE', '/events/e1')).statusCode, 204);
    expect((await call('DELETE', '/events/e1')).statusCode, 404);
  });

  test('GET /fail returns a JSON 500', () async {
    final r = await call('GET', '/fail');
    expect(r.statusCode, 500);
    expect(r.headers['content-type'], contains('application/json'));
  });

  group('GET /slow', () {
    test('waits three seconds by default', () async {
      final watch = Stopwatch()..start();
      final r = await call('GET', '/slow');
      expect(r.statusCode, 200);
      expect((await json(r))['seconds'], 3);
      expect(watch.elapsed, greaterThanOrEqualTo(const Duration(seconds: 3)));
    });

    test('?seconds=1 waits one second', () async {
      final watch = Stopwatch()..start();
      final r = await call('GET', '/slow?seconds=1');
      expect(r.statusCode, 200);
      expect((await json(r))['seconds'], 1);
      expect(watch.elapsed, greaterThanOrEqualTo(const Duration(seconds: 1)));
      expect(watch.elapsed, lessThan(const Duration(seconds: 3)));
    });

    test('?seconds=0 answers at once', () async {
      expect((await json(await call('GET', '/slow?seconds=0')))['seconds'], 0);
    });

    test('rejects a value that is not a whole number from 0 to 60', () async {
      for (final bad in ['abc', '-1', '61', '2.5']) {
        final r = await call('GET', '/slow?seconds=$bad');
        expect(r.statusCode, 400, reason: 'seconds=$bad');
      }
    });
  });

  test('responses to browser requests carry CORS headers', () async {
    // Browsers send an Origin header; the middleware answers with
    // Access-Control-Allow-Origin so Flutter web can call the API.
    final r = await api(
      Request(
        'GET',
        Uri.parse('http://localhost/health'),
        headers: {'origin': 'http://localhost:3000'},
      ),
    );
    expect(r.headers['access-control-allow-origin'], isNotNull);
  });
}
