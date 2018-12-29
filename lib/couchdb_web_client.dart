/// Library that provide http methods for connecting with CouchDB from browser
///
/// Only **Basic Authentication** is implemented at that moment.
/// **Cookie Authentication** isn't implemented yet.
///
/// By default all methods set to request `Accept` header with value `application/json`
/// and if body presented - `Content-Type` header with `application/json` value
///
/// This client sends the proper headers to allow accessing a remote CouchDB
/// via CORS (Cross-Origin Resource Sharing) requests.
///
/// Note that even if both CouchDB and you application are running on the same server,
/// but listening on different ports, you will need to use CORS to ensure your
/// requests are not being blocked by the user's browser.
library couchdb_web_client;

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
  CouchDbWebClient(
      {String username,
      String password,
      String host,
      int port,
      bool cors = false})
      : super(username, password, host, port, cors: cors);

  @override
  String get origin => window.location.hostname;

  final _browserClient = BrowserClient();

  @override
  Future<DbResponse> head(String path, {Map<String, String> reqHeaders}) async {
    final resHeaders = <String, List<String>>{};

    modifyRequestHeaders(reqHeaders);

    final res =
        await _browserClient.head('$connectUri/$path', headers: headers);
    _browserClient.close();

    if (res.statusCode < 200 || res.statusCode > 202) {
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

    modifyRequestHeaders(reqHeaders);

    final uriString = path.isNotEmpty ? '$connectUri/$path' : '$connectUri';

    final res = await _browserClient.get(uriString, headers: headers);
    _browserClient.close();

    if (res.headers['content-type'] == 'application/json') {
      final resBody = jsonDecode(res.body);

      if (resBody is int) {
        json = <String, Object>{'limit': resBody};
      } else if (resBody is List) {
        json = <String, Object>{'results': List<Object>.from(resBody)};
      } else {
        json = Map<String, Object>.from(resBody);
      }
    } else {
      json = <String, String>{'raw': res.body};
    }

    res.headers.forEach((headerName, headerValue) =>
        resHeaders[headerName] = <String>[headerValue]);
    json['headers'] = resHeaders;

    if (res.statusCode < 200 || res.statusCode > 202) {
      throw CouchDbException(res.statusCode,
          response: DbResponse.fromJson(json));
    }

    return DbResponse.fromJson(json);
  }

  @override
  Future<DbResponse> put(String path,
      {Object body, Map<String, String> reqHeaders}) async {
    final resHeaders = <String, List<String>>{};

    modifyRequestHeaders(reqHeaders);

    final encodedData = body is Map ? jsonEncode(body) : body;

    final res = await _browserClient.put('$connectUri/$path',
        headers: headers, body: encodedData);
    _browserClient.close();

    final resBody = jsonDecode(res.body);
    final json = Map<String, Object>.from(resBody);

    res.headers.forEach((headerName, headerValue) =>
        resHeaders[headerName] = <String>[headerValue]);
    json['headers'] = resHeaders;

    if (res.statusCode < 200 || res.statusCode > 202) {
      throw CouchDbException(res.statusCode,
          response: DbResponse.fromJson(json));
    }

    return DbResponse.fromJson(json);
  }

  @override
  Future<DbResponse> post(String path,
      {Object body, Map<String, String> reqHeaders}) async {
    final resHeaders = <String, List<String>>{};

    modifyRequestHeaders(reqHeaders);

    final encodedData = body is Map ? jsonEncode(body) : body;

    final res = await _browserClient.post('$connectUri/$path',
        headers: headers, body: encodedData);
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

    if (res.statusCode < 200 || res.statusCode > 202) {
      throw CouchDbException(res.statusCode,
          response: DbResponse.fromJson(json));
    }

    return DbResponse.fromJson(json);
  }

  @override
  Future<DbResponse> delete(String path,
      {Map<String, String> reqHeaders}) async {
    final resHeaders = <String, List<String>>{};

    modifyRequestHeaders(reqHeaders);

    final res =
        await _browserClient.delete('$connectUri/$path', headers: headers);
    _browserClient.close();

    final resBody = jsonDecode(res.body);
    final json = Map<String, Object>.from(resBody);

    res.headers.forEach((headerName, headerValue) =>
        resHeaders[headerName] = <String>[headerValue]);
    json['headers'] = resHeaders;

    if (res.statusCode < 200 || res.statusCode > 202) {
      throw CouchDbException(res.statusCode,
          response: DbResponse.fromJson(json));
    }

    return DbResponse.fromJson(json);
  }

  @override
  Future<DbResponse> copy(String path, {Map<String, String> reqHeaders}) async {
    final resHeaders = <String, List<String>>{};

    modifyRequestHeaders(reqHeaders);

    final res = await HttpRequest.request('$connectUri/$path',
        requestHeaders: headers, method: 'COPY');

    final rawBody = res.responseText;
    final resBody = jsonDecode(rawBody);
    final json = Map<String, Object>.from(resBody);

    res.responseHeaders.forEach((headerName, headerValue) =>
        resHeaders[headerName] = <String>[headerValue]);
    json['headers'] = resHeaders;

    if (res.status < 200 || res.status > 202) {
      throw CouchDbException(res.status, response: DbResponse.fromJson(json));
    }

    return DbResponse.fromJson(json);
  }
}
