abstract class CouchDbBaseClient {
  String get connectUri;

  Future<Map<String, List<String>>> head(String path);

  Future<Map<String, Object>> get(String path);

  Future<Map<String, Object>> put(String path, Object body);

  Future<Map<String, Object>> post(String path, Object body);

  Future<Map<String, Object>> delete(String path, [Object body]);

  Future<Map<String, Object>> copy(String path);
}