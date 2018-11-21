import 'dart:convert';
import 'dart:io';

import '../entities/db_response.dart';
import '../exceptions/couchdb_exception.dart';
import 'base/couchdb_base_client.dart';

/// Client for interacting with database via server-side applications
class CouchDbServerClient extends CouchDbBaseClient {

  /// Creates only one instance of [CouchDbServerClient] per multiple calls.
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

  /// Host 
  String host;

  /// Port
  int port;

  /// Username of database user
  String username;

  /// Password of database user
  String password;

  @override
  String get connectUri => 'http://$username:$password@$host:$port';

  @override
  Future<DbResponse> head(String path, { Map<String, String> reqHeaders }) async {
    final resHeaders = <String, List<String>>{};

    final req = await HttpClient().headUrl(Uri.parse('$connectUri/$path'))
      ..headers.set('Accept', 'application/json');

    if (reqHeaders != null) {
      reqHeaders.forEach((header, value) => req.headers.set(header, value));
    }

    final res = await req.close();

    if (
      res.statusCode != HttpStatus.ok
      && res.statusCode != HttpStatus.created
      && res.statusCode != HttpStatus.accepted
    ) {
      throw CouchDbException(res.statusCode);
    }

    res.headers.forEach((header, heads) => resHeaders.putIfAbsent(header, () => heads));
    return DbResponse(headers: resHeaders);
  }

  @override
  Future<DbResponse> get(String path, { Map<String, String> reqHeaders }) async {
    final resHeaders = <String, List<String>>{};

    final req = await HttpClient().getUrl(Uri.parse('$connectUri/$path'))
      ..headers.set('Accept', 'application/json');

    if (reqHeaders != null) {
      reqHeaders.forEach((header, value) => req.headers.set(header, value));
    }

    final res = await req.close();
    final resBody = jsonDecode(await res.transform(utf8.decoder).join());

    Map<String, Object> json;
    switch(resBody.runtimeType) {
      case int:
        json = <String, Object>{ 'limit': resBody };
        break;
      default:
        json = Map<String, Object>.from(resBody);
    }

    res.headers.forEach((header, heads) => resHeaders[header] = heads);
    json['headers'] = resHeaders;

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
      ..headers.set('Accept', 'application/json')
      ..headers.contentType = ContentType.json;

    if (body != null) {
      req.write(jsonEncode(body));
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
  Future<DbResponse> post(String path,
      { Map<String, Object> body, Map<String, String> reqHeaders }) async {

    final resHeaders = <String, List<String>>{};

    final req = await HttpClient().postUrl(Uri.parse('$connectUri/$path'))
      ..headers.set('Accept', 'application/json')
      ..headers.contentType = ContentType.json;

    if (reqHeaders != null) {
      reqHeaders.forEach((header, value) => req.headers.set(header, value));
    }

    if (body != null) {
      req.write(jsonEncode(body));
    }

    final res = await req.close();
    final resBody = jsonDecode(await res.transform(utf8.decoder).join());

    Map<String, Object> json;
    switch(resBody.runtimeType) {
      case List:
        json = <String, List<Object>>{ 'result': List<Object>.from(resBody) };
        break;
      default:
        json = Map<String, Object>.from(resBody);
    }

    res.headers.forEach((header, heads) => resHeaders[header] = heads); 
    json['headers'] = resHeaders;

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
      ..headers.set('Accept', 'application/json')
      ..headers.contentType = ContentType.json;

    if (body != null) {
      req.write(jsonEncode(body));
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