import 'dart:io';

import 'package:campus_backend/api.dart';
import 'package:campus_backend/events_store.dart';
import 'package:shelf/shelf_io.dart' as io;

Future<void> main(List<String> args) async {
  // 0.0.0.0 so emulators and other devices on the network can reach it.
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  final server = await io.serve(buildApi(EventsStore()), ip, port);
  print(
    'campus_backend listening on http://${server.address.host}:${server.port}',
  );
  print('Android emulator reaches it at http://10.0.2.2:${server.port}');
}
