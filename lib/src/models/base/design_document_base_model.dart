import 'package:meta/meta.dart';

import '../../clients/base/couchdb_base_client.dart';
import '../../entities/db_response.dart';
import 'base_model.dart';

/// Class that contains methods that allow operate with design documents
abstract class DesignDocumentBaseModel extends BaseModel {
  /// Create DesignDocumentBaseModel by accepting web-based or server-based client
  DesignDocumentBaseModel(CouchDbBaseClient client) : super(client);

  /// Returns the HTTP Headers containing a minimal amount of information about the specified design document
  Future<DbResponse> designDocHeaders(String dbName, String ddocId,
      {Map<String, String> headers,
      bool attachments = false,
      bool attEncodingInfo = false,
      List<String> attsSince,
      bool conflicts = false,
      bool deletedConflicts = false,
      bool latest = false,
      bool localSeq = false,
      bool meta = false,
      Object openRevs,
      String rev,
      bool revs = false,
      bool revsInfo = false});

  /// Returns the contents of the design document specified with the name of the design document and
  /// from the specified database
  Future<DbResponse> designDoc(String dbName, String ddocId,
      {Map<String, String> headers,
      bool attachments = false,
      bool attEncodingInfo = false,
      List<String> attsSince,
      bool conflicts = false,
      bool deletedConflicts = false,
      bool latest = false,
      bool localSeq = false,
      bool meta = false,
      Object openRevs,
      String rev,
      bool revs = false,
      bool revsInfo = false});

  /// Creates a new named design document, or creates a new revision of the existing design document
  ///
  /// The design documents have some agreement upon their fields and structure. Currently it is the following:
  ///
  ///     1. language (string): Defines Query Server key to process design document functions
  ///     2. options (object): View’s default options
  ///     3. filters (object): Filter functions definition
  ///     4. lists (object): List functions definition
  ///     5. rewrites (array or string): Rewrite rules definition
  ///     6. shows (object): Show functions definition
  ///     7. updates (object): Update functions definition
  ///     8. validate_doc_update (string): Validate document update function source
  ///     9. views (object): View functions definition.
  ///
  /// Note, that for `filters`, `lists`, `shows` and `updates` fields objects are mapping of function name to string function
  /// source code. For `views` mapping is the same except that values are objects with `map` and `reduce` (optional) keys
  /// which also contains functions source code.
  Future<DbResponse> insertDesignDoc(
      String dbName, String ddocId, Map<String, Object> body,
      {Map<String, String> headers,
      String rev,
      String batch,
      bool newEdits = true});

  /// Deletes the specified document from the database
  Future<DbResponse> deleteDesignDoc(String dbName, String ddocId, String rev,
      {Map<String, String> headers, String batch});

  /// Copies an existing design document to a new or existing one
  Future<DbResponse> copyDesignDoc(String dbName, String ddocId,
      {Map<String, String> headers, String rev, String batch});

  /// Returns the HTTP headers containing a minimal amount of information about the specified attachment
  Future<DbResponse> attachmentInfo(
      String dbName, String ddocId, String attName,
      {Map<String, String> headers, String rev});

  /// Returns the file attachment associated with the design document
  Future<DbResponse> attachment(String dbName, String ddocId, String attName,
      {Map<String, String> headers, String rev});

  /// Uploads the supplied content as an attachment to the specified design document
  ///
  /// You must supply the `Content-Type` header, and for an existing document
  /// you must also supply either the [rev] query argument or the `If-Match` HTTP header
  Future<DbResponse> uploadAttachment(
      String dbName, String ddocId, String attName, Object body,
      {Map<String, String> headers, String rev});

  /// Deletes the attachment of the specified design document
  Future<DbResponse> deleteAttachment(
      String dbName, String ddocId, String attName,
      {@required String rev, Map<String, String> headers, String batch});

  /// Obtains information about the specified design document, including the index, index size
  /// and current status of the design document and associated index information
  Future<DbResponse> designDocInfo(String dbName, String ddocId,
      {Map<String, String> headers});

  /// Executes the specified view function from the specified design document
  ///
  /// Supported values for [update]:
  ///
  ///     - true
  ///     - false
  ///     - lazy
  Future<DbResponse> executeViewFunction(
      String dbName, String ddocId, String viewName,
      {bool conflicts = false,
      bool descending = false,
      Object endKey,
      String endKeyDocId,
      bool group = false,
      int groupLevel,
      bool includeDocs = false,
      bool attachments = false,
      bool attEncodingInfo = false,
      bool inclusiveEnd = true,
      Object key,
      List<Object> keys,
      int limit,
      bool reduce,
      int skip = 0,
      bool sorted = true,
      bool stable = false,
      String stale,
      Object startKey,
      String startKeyDocId,
      String update = 'true',
      bool updateSeq = false,
      Map<String, String> headers});

  /// Executes the specified view function from the specified design document.
  ///
  /// Unlike GET [executeViewFunction] for accessing views, the POST method
  /// supports the specification of explicit [keys] to be retrieved from the view results
  Future<DbResponse> executeViewFunctionWithKeys(
      String dbName, String ddocId, String viewName,
      {@required List<Object> keys,
      bool conflicts = false,
      bool descending = false,
      Object endKey,
      String endKeyDocId,
      bool group = false,
      int groupLevel,
      bool includeDocs = false,
      bool attachments = false,
      bool attEncodingInfo = false,
      bool inclusiveEnd = true,
      Object key,
      int limit,
      bool reduce,
      int skip = 0,
      bool sorted = true,
      bool stable = false,
      String stale,
      Object startKey,
      String startKeyDocId,
      String update = 'true',
      bool updateSeq = false,
      Map<String, String> headers});

  /// Executes multiple specified view queries against the view function from the specified design document
  ///
  /// [queries] might have the same parameters as [executeViewFunctionWithKeys] or [executeViewFunction].
  /// Multi-key fetchs for `reduce` views must use `group=true`
  Future<DbResponse> executeViewQueries(
      String dbName, String ddocId, String viewName, List<Object> queries);

  /// Applies show function for null document
  Future<DbResponse> executeShowFunctionForNull(
      String dbName, String ddocId, String funcName,
      {String format});

  /// Applies show function for the specified document
  Future<DbResponse> executeShowFunctionForDocument(
      String dbName, String ddocId, String funcName, String docId,
      {String format});

  /// Applies list function for the [view] function from the same design document
  Future<DbResponse> executeListFunctionForView(
      String dbName, String ddocId, String funcName, String view,
      {String format});

  /// Applies list function for the [view] function from the other design document
  Future<DbResponse> executeListFunctionForViewFromDoc(String dbName,
      String ddocId, String funcName, String otherDoc, String view,
      {String format});

  /// Executes update function on server side for null document
  Future<DbResponse> executeUpdateFunctionForNull(
      String dbName, String ddocId, String funcName, Object body);

  /// Executes update function on server side for the specified document
  Future<DbResponse> executeUpdateFunctionForDocument(
      String dbName, String ddocId, String funcName, String docId, Object body);

  /// Rewrites the specified path by rules defined in the specified design document
  ///
  /// The rewrite rules are defined by the `rewrites` field of the design document.
  /// The `rewrites` field can either be a string containing the a rewrite function or an array of rule definitions.
  Future<DbResponse> rewritePath(String dbName, String ddocId, String path);
}
