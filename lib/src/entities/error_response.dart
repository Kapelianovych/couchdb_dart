/// Class that contains error info from CouchDB
class ErrorResponse {
  /// Creates [ErrorResponse] instance
  ErrorResponse(this.error, this.reason);

  /// Holds error type
  String error;

  /// Holds error reason
  String reason;

  @override
  String toString() => 'Error - $error, reason: $reason';
}
