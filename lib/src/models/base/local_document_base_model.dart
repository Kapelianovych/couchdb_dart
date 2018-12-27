import 'package:meta/meta.dart';

import '../../clients/base/couchdb_base_client.dart';
import '../../entities/db_response.dart';
import 'base_model.dart';

/// The Local (non-replicating) document interface allows to create local documents
/// that are not replicated to other databases
///
/// Local documents don't store attachments.
abstract class LocalDocumentBaseModel extends BaseModel {
  /// Create LocalDocumentModel by accepting web-based or server-based client
  LocalDocumentBaseModel(CouchDbBaseClient client) : super(client);

  /// Returns a JSON structure of all of the local documents in a given database
  Future<DbResponse> localDocs(String dbName,
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
  Future<DbResponse> localDocsWithKeys(String dbName,
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
  Future<DbResponse> localDoc(String dbName, String docId,
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
  Future<DbResponse> putLocalDoc(
      String dbName, String docId, Map<String, Object> body,
      {Map<String, String> headers,
      String rev,
      String batch,
      bool newEdits = true});

  /// Deletes the specified local document
  ///
  /// [docId] must match pattern - `_local/{id}`
  Future<DbResponse> deleteLocalDoc(String dbName, String docId, String rev,
      {Map<String, String> headers, String batch});

  /// Copies the specified local document
  ///
  /// [docId] must match pattern - `_local/{id}`
  Future<DbResponse> copyLocalDoc(String dbName, String docId,
      {Map<String, String> headers, String rev, String batch});
}
