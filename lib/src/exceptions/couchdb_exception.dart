import '../responses/error_response.dart';

/// Exception that triggers when database respond with code 300 and above
class CouchDbException implements Exception {
  /// Returns instance with given error [code] and optional [response]
  CouchDbException(this.code, {this.response});

  /// Status code
  int code;

  /// Error response
  ErrorResponse response;

  @override
  String toString() => '''
    Code: $code
    Error: ${response.error}
    Reason: ${response.reason}''';
}
