import '../../entities/db_response.dart';

abstract class CouchDbBaseClient {
  String get connectUri;

  Future<DbResponse> head(String path);

  Future<DbResponse> get(String path, { Map<String, String> reqHeaders });

  Future<DbResponse> put(String path, { Map<String, Object> body });

  Future<DbResponse> post(String path, { Map<String, Object> body, Map<String, String> reqHeaders });

  Future<DbResponse> delete(String path, { Map<String, Object> body });

  Future<DbResponse> copy(String path);
}