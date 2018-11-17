import 'base/couchdb_base_client.dart';

class CouchDbWebClient extends CouchDbBaseClient {
  @override
  // TODO: implement connectUri
  String get connectUri => null;

  @override
  Future<Map<String, Object>> copy(String path) {
    // TODO: implement copy
    return null;
  }

  @override
  Future<Map<String, Object>> delete(String path, [Object body]) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<Map<String, Object>> get(String path) {
    // TODO: implement get
    return null;
  }

  @override
  Future<Map<String, List<String>>> head(String path) {
    // TODO: implement head
    return null;
  }

  @override
  Future<Map<String, Object>> post(String path, Object body) {
    // TODO: implement post
    return null;
  }

  @override
  Future<Map<String, Object>> put(String path, Object body) {
    // TODO: implement put
    return null;
  }

//   factory CouchDbWebClient({
//     String username,
//     String password,
//     String host = '127.0.0.1',
//     int port = 5984
//   }) => _client ??= CouchDbWebClient._create(
//           username,
//           password,
//           host,
//           port
//         );

//   CouchDbWebClient._create(
//     this.username,
//     this.password,
//     this.host,
//     this.port
//   );

//   static CouchDbWebClient _client;

//   String host;
//   int port;
//   String username;
//   String password;


}