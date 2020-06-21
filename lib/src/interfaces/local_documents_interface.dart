import 'package:meta/meta.dart';

import '../responses/local_documents_response.dart';

/// The Local (non-replicating) document interface allows to create local documents
/// that are not replicated to other databases
///
/// Local documents don't store attachments.
abstract class LocalDocumentsInterface {

  /// Returns a JSON structure of all of the local documents in a given database
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "offset": null,
  ///     "rows": [
  ///         {
  ///             "id": "_local/localdoc01",
  ///             "key": "_local/localdoc01",
  ///             "value": {
  ///                 "rev": "0-1"
  ///             }
  ///         },
  ///         {
  ///             "id": "_local/localdoc02",
  ///             "key": "_local/localdoc02",
  ///             "value": {
  ///                 "rev": "0-1"
  ///             }
  ///         },
  ///         {
  ///             "id": "_local/localdoc03",
  ///             "key": "_local/localdoc03",
  ///             "value": {
  ///                 "rev": "0-1"
  ///             }
  ///         },
  ///         {
  ///             "id": "_local/localdoc04",
  ///             "key": "_local/localdoc04",
  ///             "value": {
  ///                 "rev": "0-1"
  ///             }
  ///         },
  ///         {
  ///             "id": "_local/localdoc05",
  ///             "key": "_local/localdoc05",
  ///             "value": {
  ///                 "rev": "0-1"
  ///             }
  ///         }
  ///     ],
  ///     "total_rows": null
  /// }
  /// ```
  Future<LocalDocumentsResponse> localDocs(String dbName,
      {bool conflicts = false,
      bool descending = false,
      String endKey,
      String endKeyDocId,
      bool includeDocs = false,
      bool inclusiveEnd = true,
      String key,
      List<String> keys,
      int limit,
      int skip = 0,
      String startKey,
      String startKeyDocId,
      bool updateSeq = false,
      Map<String, String> headers});

  /// Requests multiple local documents in a single request specifying multiple [keys]
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "total_rows" : null,
  ///     "rows" : [
  ///         {
  ///             "value" : {
  ///                 "rev" : "0-1"
  ///             },
  ///             "id" : "_local/localdoc02",
  ///             "key" : "_local/localdoc02"
  ///         },
  ///         {
  ///             "value" : {
  ///                 "rev" : "0-1"
  ///             },
  ///             "id" : "_local/localdoc05",
  ///             "key" : "_local/localdoc05"
  ///         }
  ///     ],
  ///     "offset" : null
  /// }
  /// ```
  Future<LocalDocumentsResponse> localDocsWithKeys(String dbName,
      {@required List<String> keys,
      bool conflicts = false,
      bool descending = false,
      String endKey,
      String endKeyDocId,
      bool includeDocs = false,
      bool inclusiveEnd = true,
      String key,
      int limit,
      int skip = 0,
      String startKey,
      String startKeyDocId,
      bool updateSeq = false});

  /// Gets the specified local document
  ///
  /// [docId] must match pattern - `_local/{id}`
  Future<LocalDocumentsResponse> localDoc(String dbName, String docId,
      {Map<String, String> headers,
      bool conflicts = false,
      bool deletedConflicts = false,
      bool latest = false,
      bool localSeq = false,
      bool meta = false,
      Object openRevs,
      String rev,
      bool revs = false,
      bool revsInfo = false});

  /// Stores the specified local document
  ///
  /// [docId] must match pattern - `_local/{id}`
  Future<LocalDocumentsResponse> putLocalDoc(
      String dbName, String docId, Map<String, Object> body,
      {Map<String, String> headers,
      String rev,
      String batch,
      bool newEdits = true});

  /// Deletes the specified local document
  ///
  /// [docId] must match pattern - `_local/{id}`
  Future<LocalDocumentsResponse> deleteLocalDoc(
      String dbName, String docId, String rev,
      {Map<String, String> headers, String batch});

  /// Copies the specified local document
  ///
  /// [docId] must match pattern - `_local/{id}`
  Future<LocalDocumentsResponse> copyLocalDoc(String dbName, String docId,
      {Map<String, String> headers, String rev, String batch});
}
