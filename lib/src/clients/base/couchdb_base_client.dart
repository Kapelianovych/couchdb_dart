import '../../entities/db_response.dart';

/// The basic class that describes the supported methods of HTTP interaction with the database
///
/// All methods return [DbResponse] with results of query
abstract class CouchDbBaseClient {
  /// Gets connection URI like **http://username:password@host:port**
  String get connectUri;

  /// HEAD method
  Future<DbResponse> head(String path, {Map<String, String> reqHeaders});

  /// GET method
  Future<DbResponse> get(String path, {Map<String, String> reqHeaders});

  /// PUT method
  Future<DbResponse> put(String path,
      {Map<String, Object> body, Map<String, String> reqHeaders});

  /// POST method
  Future<DbResponse> post(String path,
      {Map<String, Object> body, Map<String, String> reqHeaders});

  /// DELETE method
  Future<DbResponse> delete(String path,
      {Map<String, String> reqHeaders, Map<String, Object> body});

  /// COPY method
  Future<DbResponse> copy(String path, {Map<String, String> reqHeaders});
}
