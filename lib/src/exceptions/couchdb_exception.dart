import '../entities/db_response.dart';

class CouchDbException implements Exception {

  CouchDbException(this.code, { this.response });

  int code;
  DbResponse response;

  @override
  String toString() => '''
    Code: $code
    Responce: $response''';
}