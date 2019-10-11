import 'package:couchdb/couchdb.dart';

import '../responses/api_response.dart';
import '../responses/error_response.dart';
import 'database_model_response.dart';
import 'design_document_model_response.dart';
import 'document_model_response.dart';
import 'local_document_model_response.dart';
import 'server_model_response.dart';

/// Only provided for backward compatibility
@Deprecated('Use ApiResponse instead')
class DbResponse extends ApiResponse {
  /// Creates instance of [DbResponse] with [raw] and [json]
  DbResponse(Map<String, Object> json,
      {Map<String, Object> headers, String raw})
      : super(json, headers: headers, raw: raw);

  /// Returns response with fields that may be returned by `ServerModel`
  /// request methods
  ServerModelResponse serverModelResponse() {
    return ServerModelResponse.from(this);
  }

  /// Returns response with fields that may be returned by `DatabaseModel`
  /// request methods
  DatabaseModelResponse databaseModelResponse() {
    return DatabaseModelResponse.from(this);
  }

  /// Returns response with fields that may be returned by `DocumentModel`
  /// request methods
  DocumentModelResponse documentModelResponse() {
    return DocumentModelResponse.from(this);
  }

  /// Returns response with fields that may be returned by `DesignDocumentModel`
  /// request methods
  DesignDocumentModelResponse designDocumentModelResponse() {
    return DesignDocumentModelResponse.from(this);
  }

  /// Returns response with fields that may be returned by `LocalDocumentModel`
  /// request methods
  LocalDocumentModelResponse localDocumentModelResponse() {
    return LocalDocumentModelResponse.from(this);
  }

  /// Returns error response if exists, otherwise returns `null`
  @override
  ErrorResponse errorResponse() {
    ErrorResponse e;
    if (isError()) {
      e = ErrorResponse(json['error'] as String, json['reason'] as String);
    }
    return e;
  }
}
