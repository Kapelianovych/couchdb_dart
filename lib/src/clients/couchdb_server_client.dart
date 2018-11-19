import 'dart:convert';
import 'dart:io';

import '../entities/db_response.dart';
import '../exceptions/couchdb_exception.dart';
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
  Future<DbResponse> head(String path) async {
    final headers = <String, List<String>>{};

    final req = await HttpClient().headUrl(Uri.parse('$connectUri/$path'))
      ..headers.set('Accept', 'application/json');
    final res = await req.close();

    if (
      res.statusCode != HttpStatus.ok
      && res.statusCode != HttpStatus.created
      && res.statusCode != HttpStatus.accepted
    ) {
      throw CouchDbException(res.statusCode);
    }

    res.headers.forEach((header, heads) => headers.putIfAbsent(header, () => heads));
    return DbResponse(headers: headers);
  }

  @override
  Future<DbResponse> get(String path) async {
    final headers = <String, List<String>>{};

    final req = await HttpClient().getUrl(Uri.parse('$connectUri/$path'))
      ..headers.set('Accept', 'application/json');
    final res = await req.close();
    final resBody = jsonDecode(await res.transform(utf8.decoder).join());
    final json = Map<String, Object>.from(resBody);

    res.headers.forEach((header, heads) => headers.putIfAbsent(header, () => heads));
    json['headers'] = headers;

    if (
      res.statusCode != HttpStatus.ok
      && res.statusCode != HttpStatus.created
      && res.statusCode != HttpStatus.accepted
    ) {
      throw CouchDbException(res.statusCode, response: DbResponse.fromJson(json));
    }

    return DbResponse.fromJson(json);
  }

  @override
  Future<DbResponse> put(String path, { Map<String, Object> body }) async {
    final headers = <String, List<String>>{};

    final req = await HttpClient().putUrl(Uri.parse('$connectUri/$path'))
      ..headers.set('Accept', 'application/json');

    if (body != null) {
      req
        ..headers.contentType = ContentType.json
        ..write(jsonEncode(body));
    }

    final res = await req.close();
    final resBody = jsonDecode(await res.transform(utf8.decoder).join());
    final json = Map<String, Object>.from(resBody);

    res.headers.forEach((header, heads) => headers.putIfAbsent(header, () => heads));
    json['headers'] = headers;

    if (
      res.statusCode != HttpStatus.ok
      && res.statusCode != HttpStatus.created
      && res.statusCode != HttpStatus.accepted
    ) {
      throw CouchDbException(res.statusCode, response: DbResponse.fromJson(json));
    }

    return DbResponse.fromJson(json);
  }

  @override
  Future<DbResponse> post(String path, { Map<String, Object> body, Map<String, String> headers }) async {
    final headers = <String, List<String>>{};

    final req = await HttpClient().postUrl(Uri.parse('$connectUri/$path'))
      ..headers.set('Accept', 'application/json');

    if (headers != null) {
      headers.forEach((header, value) => req.headers.set(header, value));
    }

    if (body != null) {
      req
        ..headers.contentType = ContentType.json
        ..write(jsonEncode(body));
    }

    final res = await req.close();
    final resBody = jsonDecode(await res.transform(utf8.decoder).join());
    final json = Map<String, Object>.from(resBody);

    res.headers.forEach((header, heads) => headers.putIfAbsent(header, () => heads));
    json['headers'] = headers;

    if (
      res.statusCode != HttpStatus.ok
      && res.statusCode != HttpStatus.created
      && res.statusCode != HttpStatus.accepted
    ) {
      throw CouchDbException(res.statusCode, response: DbResponse.fromJson(json));
    }

    return DbResponse.fromJson(json);
  }

  @override
  Future<DbResponse> delete(String path, { Map<String, Object> body }) async {
    final headers = <String, List<String>>{};

    final req = await HttpClient().deleteUrl(Uri.parse('$connectUri/$path'))
      ..headers.set('Accept', 'application/json');

    if (body != null) {
      req
        ..headers.contentType = ContentType.json
        ..write(jsonEncode(body));
    }

    final res = await req.close();
    final resBody = jsonDecode(await res.transform(utf8.decoder).join());
    final json = Map<String, Object>.from(resBody);

    res.headers.forEach((header, heads) => headers.putIfAbsent(header, () => heads));
    json['headers'] = headers;

    if (
      res.statusCode != HttpStatus.ok
      && res.statusCode != HttpStatus.created
      && res.statusCode != HttpStatus.accepted
    ) {
      throw CouchDbException(res.statusCode, response: DbResponse.fromJson(json));
    }

    return DbResponse.fromJson(json);
  }

  @override
  Future<DbResponse> copy(String path) async {
    final headers = <String, List<String>>{};

    final req = await HttpClient().openUrl('COPY', Uri.parse('$connectUri/$path'))
      ..headers.set('Accept', 'application/json');
    final res = await req.close();
    final resBody = jsonDecode(await res.transform(utf8.decoder).join());
    final json = Map<String, Object>.from(resBody);

    res.headers.forEach((header, heads) => headers.putIfAbsent(header, () => heads));
    json['headers'] = headers;

    if (
      res.statusCode != HttpStatus.ok
      && res.statusCode != HttpStatus.created
      && res.statusCode != HttpStatus.accepted
    ) {
      throw CouchDbException(res.statusCode, response: DbResponse.fromJson(json));
    }

    return DbResponse.fromJson(json);
  }
}