import '../responses/api_response.dart';

/// Client for interacting with CouchDB server
abstract class ClientInterface {

  /// HEAD method
  Future<ApiResponse> head(String path, {Map<String, String> reqHeaders});

  /// GET method
  Future<ApiResponse> get(String path, {Map<String, String> reqHeaders});

  /// PUT method
  Future<ApiResponse> put(String path,
      {Object body, Map<String, String> reqHeaders});

  /// POST method
  Future<ApiResponse> post(String path,
      {Object body, Map<String, String> reqHeaders});

  /// DELETE method
  Future<ApiResponse> delete(String path,
      {Map<String, String> reqHeaders});

  /// COPY method
  Future<ApiResponse> copy(String path, {Map<String, String> reqHeaders});

  /// Makes request with specific [method] and with long or
  /// continuous connection
  ///
  /// Returns undecoded response.
  Future<Stream<String>> streamed(String method, String path,
      {Object body, Map<String, String> reqHeaders});

  /// Initiates new session for specified user credentials by
  /// providing `Cookie` value
  ///
  /// If [next] parameter was provided the response will trigger redirection
  /// to the specified location in case of successful authentication.
  ///
  /// Structured response is available in `ServerModelResponse`.
  ///
  /// Returns JSON like:
  /// ```json
  /// {'ok': true, 'name': 'root', 'roles': ['_admin']}
  /// ```
  Future<ApiResponse> authenticate([String next]);

  /// Closes user’s session by instructing the browser to clear the cookie
  ///
  /// Structured response is available in `ServerModelResponse`.
  ///
  /// Returns JSON like:
  /// ```json
  /// {'ok': true}
  /// ```
  Future<ApiResponse> logout();

  /// Returns information about the authenticated user, including a
  /// User Context Object, the authentication method and database
  /// that were used, and a list of configured
  /// authentication handlers on the server
  ///
  /// Structured response is available in `ServerModelResponse`.
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     'info': {
  ///         'authenticated': 'cookie',
  ///         'authentication_db': '_users',
  ///         'authentication_handlers': [
  ///             'cookie',
  ///             'default'
  ///         ]
  ///     },
  ///     'ok': true,
  ///     'userCtx': {
  ///         'name': 'root',
  ///         'roles': [
  ///             '_admin'
  ///         ]
  ///     }
  /// }
  /// ```
  Future<ApiResponse> userInfo({bool basic = false});
}
