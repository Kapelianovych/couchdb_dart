import 'error_response.dart';

/// Base class that unit all responses of CouchDB
class ApiResponse {
  /// Creates instance of [ApiResponse] with [raw] and [json]
  ApiResponse(this.json, {this.headers, this.raw});

  /// Field that contain raw body of response
  final String raw;

  /// Field that contain json itself in order to grab custom fields
  final Map<String, Object> json;

  /// Headers of response
  final Map<String, String> headers;

  /// Returns error response if exists, otherwise return `null`
  ErrorResponse errorResponse() {
    ErrorResponse e;
    if (isError()) {
      e = ErrorResponse(json['error'] as String, json['reason'] as String);
    }
    return e;
  }

  /// Check if this response is error
  bool isError() => json['error'] != null;

  @override
  String toString() => '''
    json - $json
    raw - $raw
    ''';
}
