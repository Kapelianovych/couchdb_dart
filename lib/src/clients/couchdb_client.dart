import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart';

import '../entities/db_response.dart';
import '../exceptions/couchdb_exception.dart';

/// Client for interacting with database via server-side and web applications
class CouchDbClient {
  /// Creates instance of client with [username], [password], [host], [port], [cors], [auth] and
  /// [secret] (needed for proxy authentication) parameters
  ///
  /// [auth] may be one of:
  ///
  ///     - basic (default)
  ///     - cookie
  ///     - proxy
  ///
  CouchDbClient(
      {this.username,
      this.password,
      this.host = '0.0.0.0',
      this.port = 5984,
      this.auth = 'basic',
      this.cors = false,
      String secret})
      : secret = utf8.encode(secret);

  /// Host of database instance
  String host;

  /// Port database listened to
  int port;

  /// Username of database user
  String username;

  /// Password of database user
  String password;

  /// Authentication type used in requests
  ///
  /// May be one of:
  ///
  ///     - basic
  ///     - cookie
  ///     - proxy
  ///
  String auth;

  /// Holds authentication cookies
  String _cookies;

  /// Tells if CORS is enabled
  bool cors;

  /// Holds secret for proxy authentication
  List<int> secret;

  /// Client for requests
  final Client _client = Client();

  /// Request headers
  ///
  /// Already contains `Accept` and `Content-Type` headers defaults to `application/json`.
  final Map<String, String> _headers = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  /// Origin to be sent in CORS header
  String get origin => host;

  /// Gets connection URI like http://host:port
  String get connectUri => 'http://$host:$port';

  /// Base64 encoded [username] and [password]
  String get authCredentials =>
      const Base64Encoder().convert('$username:$password'.codeUnits);

  /// Gets unmodifiable request headers of this client
  Map<String, String> get headers => Map<String, String>.unmodifiable(_headers);

  /// Sets headers to [_headers]
  ///
  /// You can directly set your own headers as follows:
  /// ```dart
  /// final client = CouchDbWebClient(username: 'name', password: 'pass');
  /// client.modifyRequestHeaders(<String, String>{ ... })
  /// ```
  /// or define it using methods [head], [get], [put], [post], [delete] and [copy].
  void modifyRequestHeaders(Map<String, String> reqHeaders) {
    // If [reqHeaders] is null addAll method takes empty Map
    _headers.addAll(reqHeaders ?? <String, String>{});

    switch (auth) {
      case 'cookie':
        if (_cookies != null) {
          _headers['Cookie'] = _cookies;
        }
        break;
      case 'proxy':
        _headers['X-Auth-CouchDB-UserName'] = username;
        if (secret != null) {
          final encodedUsername = utf8.encode(username);
          _headers['X-Auth-CouchDB-Token'] =
              Hmac(sha1, secret).convert(encodedUsername).toString();
        }
        break;
      default:
        _headers['Authorization'] = 'Basic $authCredentials';
    }
    if (cors) {
      _headers['Origin'] = origin;
    }
  }

  /// HEAD method
  Future<DbResponse> head(String path, {Map<String, String> reqHeaders}) async {
    modifyRequestHeaders(reqHeaders);

    final res =
        await _client.head(Uri.parse('$connectUri/$path'), headers: headers);

    _checkForErrorStatusCode(res.statusCode);

    return DbResponse(null, headers: res.headers);
  }

  /// GET method
  Future<DbResponse> get(String path, {Map<String, String> reqHeaders}) async {
    Map<String, Object> json;

    modifyRequestHeaders(reqHeaders);

    final uriString = path.isNotEmpty ? '$connectUri/$path' : '$connectUri';
    final res = await _client.get(Uri.parse(uriString), headers: headers);

    final bodyUTF8 = utf8.decode(res.bodyBytes);
    if (res.headers['content-type'] == 'application/json') {
      final resBody = jsonDecode(bodyUTF8);

      if (resBody is int) {
        json = <String, Object>{'limit': resBody};
      } else if (resBody is List) {
        json = <String, Object>{'list': List<Object>.from(resBody)};
      } else {
        json = Map<String, Object>.from(resBody);
      }
    } else {
      // When body isn't JSON-valid then DbResponse try parse field from [json] and if it is null - error is thrown
      json = <String, Object>{};
    }

    _checkForErrorStatusCode(res.statusCode,
        body: bodyUTF8, headers: res.headers);

    return DbResponse(json, raw: bodyUTF8, headers: res.headers);
  }

  /// PUT method
  Future<DbResponse> put(String path,
      {Object body, Map<String, String> reqHeaders}) async {
    modifyRequestHeaders(reqHeaders);

    Object encodedBody;
    if (body != null) {
      body is Map ? encodedBody = jsonEncode(body) : encodedBody = body;
    }

    final res = await _client.put(Uri.parse('$connectUri/$path'),
        headers: headers, body: encodedBody);

    final bodyUTF8 = utf8.decode(res.bodyBytes);
    final resBody = jsonDecode(bodyUTF8);
    final json = Map<String, Object>.from(resBody);

    _checkForErrorStatusCode(res.statusCode,
        body: bodyUTF8, headers: res.headers);

    return DbResponse(json, headers: res.headers);
  }

  /// POST method
  Future<DbResponse> post(String path,
      {Object body, Map<String, String> reqHeaders}) async {
    modifyRequestHeaders(reqHeaders);

    Object encodedBody;
    if (body != null) {
      body is Map ? encodedBody = jsonEncode(body) : encodedBody = body;
    }

    final res = await _client.post(Uri.parse('$connectUri/$path'),
        headers: headers, body: encodedBody);

    final bodyUTF8 = utf8.decode(res.bodyBytes);
    final resBody = jsonDecode(bodyUTF8);

    Map<String, Object> json;
    if (resBody is List) {
      json = <String, Object>{'list': List<Object>.from(resBody)};
    } else {
      json = Map<String, Object>.from(resBody);
    }

    _checkForErrorStatusCode(res.statusCode,
        body: bodyUTF8, headers: res.headers);

    return DbResponse(json, headers: res.headers);
  }

  /// DELETE method
  Future<DbResponse> delete(String path,
      {Map<String, String> reqHeaders}) async {
    modifyRequestHeaders(reqHeaders);

    final res =
        await _client.delete(Uri.parse('$connectUri/$path'), headers: headers);

    final bodyUTF8 = utf8.decode(res.bodyBytes);
    final resBody = jsonDecode(bodyUTF8);
    final json = Map<String, Object>.from(resBody);

    _checkForErrorStatusCode(res.statusCode,
        body: bodyUTF8, headers: res.headers);

    return DbResponse(json, headers: res.headers);
  }

  /// COPY method
  Future<DbResponse> copy(String path, {Map<String, String> reqHeaders}) async {
    modifyRequestHeaders(reqHeaders);
    final request = Request('copy', Uri.parse('$connectUri/$path'));
    request.headers.addAll(headers);

    final res = await _client.send(request);

    final body = await res.stream.transform(utf8.decoder).join();

    final resBody = jsonDecode(body);
    final json = Map<String, Object>.from(resBody);

    _checkForErrorStatusCode(res.statusCode, body: body, headers: res.headers);

    return DbResponse(json, headers: res.headers);
  }

  /// Makes request with specific [method] and with long or continuous connection
  ///
  /// Returns undecoded response.
  Future<Stream<String>> streamed(String method, String path,
      {Object body, Map<String, String> reqHeaders}) async {
    modifyRequestHeaders(reqHeaders);

    final uriString = path.isNotEmpty ? '$connectUri/$path' : '$connectUri';
    final request = Request(method, Uri.parse(uriString));
    request.headers.addAll(headers);
    if (body != null && (method == 'post' || method == 'put')) {
      request.body =
          body is Map || body is List ? jsonEncode(body) : body.toString();
    }
    final res = await _client.send(request);

    final resStream = res.stream.asBroadcastStream().transform(utf8.decoder);
    _checkForErrorStatusCode(res.statusCode,
        body: await resStream.first, headers: res.headers);

    return resStream;
  }

  /// Checks if response is returned with status codes lower than `200` of greater than `202`
  ///
  /// Returns `CouchDbException` if status code is out of range `200-202`.
  void _checkForErrorStatusCode(int code,
      {String body, Map<String, String> headers}) {
    if (code < 200 || code > 202) {
      throw CouchDbException(code,
          response:
              DbResponse(jsonDecode(body), headers: headers).errorResponse());
    }
  }

  /// Initiates new session for specified user credentials by providing `Cookie` value
  ///
  /// If [next] parameter was provided the response will trigger redirection
  /// to the specified location in case of successful authentication.
  ///
  /// Structured response is available in `ServerModelResponse`.
  ///
  /// Returns JSON like:
  /// ```json
  /// {"ok": true, "name": "root", "roles": ["_admin"]}
  /// ```
  Future<DbResponse> authenticate([String next]) async {
    DbResponse res;
    final path = next != null ? '_session?next=$next' : '_session';

    try {
      res = await post(path,
          body: <String, String>{'name': username, 'password': password});
    } on CouchDbException {
      rethrow;
    }
    _cookies = res.headers['set-cookie'];
    return res;
  }

  /// Closes user’s session by instructing the browser to clear the cookie
  ///
  /// Structured response is available in `ServerModelResponse`.
  ///
  /// Returns JSON like:
  /// ```json
  /// {"ok": true}
  /// ```
  Future<DbResponse> logout() async {
    DbResponse res;

    try {
      res = await delete('_session');
    } on CouchDbException {
      rethrow;
    }
    _cookies = null;
    return res;
  }

  /// Returns information about the authenticated user, including a User Context Object,
  /// the authentication method and database that were used, and a list of configured
  /// authentication handlers on the server
  ///
  /// Structured response is available in `ServerModelResponse`.
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "info": {
  ///         "authenticated": "cookie",
  ///         "authentication_db": "_users",
  ///         "authentication_handlers": [
  ///             "cookie",
  ///             "default"
  ///         ]
  ///     },
  ///     "ok": true,
  ///     "userCtx": {
  ///         "name": "root",
  ///         "roles": [
  ///             "_admin"
  ///         ]
  ///     }
  /// }
  /// ```
  Future<DbResponse> userInfo({bool basic = false}) async {
    DbResponse res;
    final prevAuth = auth;

    if (basic) {
      auth = 'basic';
    }

    try {
      res = await get('_session');
    } on CouchDbException {
      rethrow;
    }

    auth = prevAuth;
    return res;
  }
}
