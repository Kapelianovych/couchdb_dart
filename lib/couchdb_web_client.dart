import 'dart:convert';
import 'dart:html';

import 'package:http/browser_client.dart';

import 'src/clients/base/couchdb_base_client.dart';
import 'src/entities/db_response.dart';
import 'src/exceptions/couchdb_exception.dart';

/// Client for interacting with database via browser-side applications
class CouchDbWebClient extends CouchDbBaseClient {
  /// Creates only one instance of [CouchDbWebClient] per multiple calls.
  ///
  /// It is recommend to don't use CouchDB as standalone server, because CouchDB is created for one thing -
  /// storing data and no more. Though it is your decision.
  factory CouchDbWebClient(
          {String username,
          String password,
          String host,
          int port}) =>
      _client ??= CouchDbWebClient._create(username, password, host, port);

  CouchDbWebClient._create(this.username, this.password, this.host, this.port);

  static CouchDbWebClient _client;

  /// Host
  String host;

  /// Port
  int port;

  /// Username of database user
  String username;

  /// Password of database user
  String password;

  final _browserClient = BrowserClient();

  /// Base64 encoded [username] and [password]
  String get authCredentials =>
      const Base64Encoder().convert('$username:$password'.codeUnits);

  @override
  String get connectUri => 'http://$host:$port';

  @override
  Future<DbResponse> head(String path, {Map<String, String> reqHeaders}) async {
    final resHeaders = <String, List<String>>{};

    final tmpHeaders = reqHeaders ?? <String, String>{};
    tmpHeaders['Authorization'] = 'Basic $authCredentials';

    final res =
        await _browserClient.head('$connectUri/$path', headers: tmpHeaders);
    _browserClient.close();

    if (res.statusCode != 200 &&
        res.statusCode != 201 &&
        res.statusCode != 202) {
      throw CouchDbException(res.statusCode);
    }

    // TODO(YevenKap): split headerValue
    res.headers.forEach((headerName, headerValue) =>
        resHeaders[headerName] = <String>[headerValue]);
    return DbResponse(headers: resHeaders);
  }

  @override
  Future<DbResponse> get(String path, {Map<String, String> reqHeaders}) async {
    final resHeaders = <String, List<String>>{};
    Map<String, Object> json;

    final tmpHeaders = reqHeaders ?? <String, String>{};
    tmpHeaders['Authorization'] = 'Basic $authCredentials';
    tmpHeaders.putIfAbsent('Accept', () => 'application/json');

    final uriString = path.isNotEmpty ? '$connectUri/$path' : '$connectUri';

    final res =
        await _browserClient.get(uriString, headers: tmpHeaders);
    _browserClient.close();

    final resBody = jsonDecode(res.body);

    if (resBody is int) {
      json = <String, Object>{'limit': resBody};
    } else if (resBody is List) {
      json = <String, Object>{'results': List<Object>.from(resBody)};
    } else {
      json = Map<String, Object>.from(resBody);
    }

    res.headers.forEach((headerName, headerValue) =>
        resHeaders[headerName] = <String>[headerValue]);
    json['headers'] = resHeaders;

    if (res.statusCode != 200 &&
        res.statusCode != 201 &&
        res.statusCode != 202) {
      throw CouchDbException(res.statusCode,
          response: DbResponse.fromJson(json));
    }

    return DbResponse.fromJson(json);
  }

  @override
  Future<DbResponse> put(String path,
      {Object body, Map<String, String> reqHeaders}) async {
    final resHeaders = <String, List<String>>{};

    final tmpHeaders = reqHeaders ?? <String, String>{};
    tmpHeaders['Authorization'] = 'Basic $authCredentials';
    tmpHeaders
      ..putIfAbsent('Accept', () => 'application/json')
      ..putIfAbsent('Content-Type', () => 'application/json');

    final encodedData = body is Map ? jsonEncode(body) : body;

    final res = await _browserClient.put('$connectUri/$path',
        headers: tmpHeaders, body: encodedData);
    _browserClient.close();

    final resBody = jsonDecode(res.body);
    final json = Map<String, Object>.from(resBody);

    res.headers.forEach((headerName, headerValue) =>
        resHeaders[headerName] = <String>[headerValue]);
    json['headers'] = resHeaders;

    if (res.statusCode != 200 &&
        res.statusCode != 201 &&
        res.statusCode != 202) {
      throw CouchDbException(res.statusCode,
          response: DbResponse.fromJson(json));
    }

    return DbResponse.fromJson(json);
  }

  @override
  Future<DbResponse> post(String path,
      {Map<String, Object> body, Map<String, String> reqHeaders}) async {
    final resHeaders = <String, List<String>>{};

    final tmpHeaders = reqHeaders ?? <String, String>{};
    tmpHeaders['Authorization'] = 'Basic $authCredentials';
    tmpHeaders
      ..putIfAbsent('Accept', () => 'application/json')
      ..putIfAbsent('Content-Type', () => 'application/json');

    final encodedData = jsonEncode(body);

    final res = await _browserClient.post('$connectUri/$path',
        headers: tmpHeaders, body: encodedData);
    _browserClient.close();

    final resBody = jsonDecode(res.body);

    Map<String, Object> json;
    if (resBody is List) {
      json = <String, Object>{'results': List<Object>.from(resBody)};
    } else {
      json = Map<String, Object>.from(resBody);
    }

    res.headers.forEach((headerName, headerValue) =>
        resHeaders[headerName] = <String>[headerValue]);
    json['headers'] = resHeaders;

    if (res.statusCode != 200 &&
        res.statusCode != 201 &&
        res.statusCode != 202) {
      throw CouchDbException(res.statusCode,
          response: DbResponse.fromJson(json));
    }

    return DbResponse.fromJson(json);
  }

  @override
  Future<DbResponse> delete(String path,
      {Map<String, String> reqHeaders}) async {
    final resHeaders = <String, List<String>>{};

    final tmpHeaders = reqHeaders ?? <String, String>{};
    tmpHeaders['Authorization'] = 'Basic $authCredentials';
    tmpHeaders.putIfAbsent('Accept', () => 'application/json');

    final res =
        await _browserClient.delete('$connectUri/$path', headers: tmpHeaders);
    _browserClient.close();

    final resBody = jsonDecode(res.body);
    final json = Map<String, Object>.from(resBody);

    res.headers.forEach((headerName, headerValue) =>
        resHeaders[headerName] = <String>[headerValue]);
    json['headers'] = resHeaders;

    if (res.statusCode != 200 &&
        res.statusCode != 201 &&
        res.statusCode != 202) {
      throw CouchDbException(res.statusCode,
          response: DbResponse.fromJson(json));
    }

    return DbResponse.fromJson(json);
  }

  @override
  Future<DbResponse> copy(String path, {Map<String, String> reqHeaders}) async {
    final resHeaders = <String, List<String>>{};

    final tmpHeaders = reqHeaders ?? <String, String>{};
    tmpHeaders['Authorization'] = 'Basic $authCredentials';
    tmpHeaders.putIfAbsent('Accept', () => 'application/json');

    final res = await HttpRequest.request('$connectUri/$path',
        requestHeaders: tmpHeaders, method: 'COPY');

    final rawBody = res.responseText;
    final resBody = jsonDecode(rawBody);
    final json = Map<String, Object>.from(resBody);

    res.responseHeaders.forEach((headerName, headerValue) =>
        resHeaders[headerName] = <String>[headerValue]);
    json['headers'] = resHeaders;

    if (res.status != 200 && res.status != 201 && res.status != 202) {
      throw CouchDbException(res.status, response: DbResponse.fromJson(json));
    }

    return DbResponse.fromJson(json);
  }
}
