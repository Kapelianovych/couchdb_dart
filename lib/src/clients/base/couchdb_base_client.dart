import 'dart:convert';

import '../../entities/db_response.dart';

/// The basic class that describes the supported methods of HTTP interaction with the database
///
/// All methods return [DbResponse] with results of query
abstract class CouchDbBaseClient {
  /// Creates instance of client with [username], [password], [host], [port] and [cors]
  CouchDbBaseClient(this.username,
          this.password,
          this.host,
          this.port, {this.cors});

  /// Host
  String host;

  /// Port
  int port;

  /// Username of database user
  String username;

  /// Password of database user
  String password;

  /// Tells if CORS is enabled
  bool cors;

  /// Request headers
  /// 
  /// Already contains `Accept` and `Content-Type` headers defaults to `application/json`.
  final Map<String, String> _headers = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  /// Gets connection URI like http://host:port
  String get connectUri => 'http://$host:$port';

  /// Base64 encoded [username] and [password]
  String get authCredentials =>
      const Base64Encoder().convert('$username:$password'.codeUnits);

  /// Origin to be sent in CORS header
  String get origin;

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
    _headers['Authorization'] = 'Basic $authCredentials';
    if (cors) {
      _headers['Origin'] = origin;
    }
  }

  /// HEAD method
  Future<DbResponse> head(String path, {Map<String, String> reqHeaders});

  /// GET method
  Future<DbResponse> get(String path, {Map<String, String> reqHeaders});

  /// PUT method
  Future<DbResponse> put(String path,
      {Object body, Map<String, String> reqHeaders});

  /// POST method
  Future<DbResponse> post(String path,
      {Object body, Map<String, String> reqHeaders});

  /// DELETE method
  Future<DbResponse> delete(String path, {Map<String, String> reqHeaders});

  /// COPY method
  Future<DbResponse> copy(String path, {Map<String, String> reqHeaders});
}
