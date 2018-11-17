import 'dart:convert';
import 'dart:io';

import 'base/couchdb_base_client.dart';

class CouchDbServerClient extends CouchDbBaseClient {

  factory CouchDbServerClient({
    String username,
    String password,
    String host = '127.0.0.1',
    int port = 5984
  }) => _client ??= CouchDbServerClient._create(
          username,
          password,
          host,
          port
        );

  CouchDbServerClient._create(
    this.username,
    this.password,
    this.host,
    this.port
  );

  static CouchDbServerClient _client;

  String host;
  int port;
  String username;
  String password;

  @override
  String get connectUri => 'http://$username:$password@$host:$port';

  @override
  Future<Map<String, List<String>>> head(String path) async {
    final headers = <String, List<String>>{};

    final req = await HttpClient().headUrl(Uri.parse('$connectUri/$path'));
    final res = await req.close();
    res.headers.forEach((header, heads) => headers.putIfAbsent(header, () => heads));
    return headers;
  }

  @override
  Future<Map<String, Object>> get(String path) async {
    final req = await HttpClient().getUrl(Uri.parse('$connectUri/$path'))
      ..headers.set('Accept', 'application/json');
    final res = await req.close();
    return Map<String, Object>.from(jsonDecode(await res.transform(utf8.decoder).join()));
  }

  @override
  Future<Map<String, Object>> put(String path, Object body) async {
    final req = await HttpClient().putUrl(Uri.parse('$connectUri/$path'))
      ..headers.contentType = ContentType.json
      ..write(jsonEncode(body));
    final res = await req.close();
    return jsonDecode(await res.transform(utf8.decoder).join());
  }

  @override
  Future<Map<String, Object>> post(String path, Object body) async {
    final req = await HttpClient().postUrl(Uri.parse('$connectUri/$path'))
      ..headers.contentType = ContentType.json
      ..write(jsonEncode(body));
    final res = await req.close();
    return jsonDecode(await res.transform(utf8.decoder).join());
  }

  @override
  Future<Map<String, Object>> delete(String path, [Object body]) async {
    final req = await HttpClient().deleteUrl(Uri.parse('$connectUri/$path'))
      ..headers.contentType = ContentType.json
      ..write(jsonEncode(body));
    final res = await req.close();
    return jsonDecode(await res.transform(utf8.decoder).join());
  }

  @override
  Future<Map<String, Object>> copy(String path) async {
    final req = await HttpClient().openUrl('COPY', Uri.parse('$connectUri/$path'))
      ..headers.set('Accept', 'application/json');
    final res = await req.close();
    return jsonDecode(await res.transform(utf8.decoder).join());
  }
}