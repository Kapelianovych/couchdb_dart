import 'package:meta/meta.dart';

import '../../clients/base/couchdb_base_client.dart';
import '../../entities/db_response.dart';
import 'base_model.dart';

/// Class that define methods for interacting with entire database in CouchDB
abstract class DatabaseBaseModel extends BaseModel {
  /// Create DatabaseModel by accepting web-based or server-based client
  DatabaseBaseModel(CouchDbBaseClient client) : super(client);

  /// Returns the HTTP Headers containing a minimal amount of information about the specified database
  Future<DbResponse> headDbInfo(String dbName);

  /// Gets information about the specified database
  Future<DbResponse> dbInfo(String dbName);

  /// Creates a new database
  Future<DbResponse> createDb(String dbName, {int q = 8});

  /// Deletes the specified database, and all the documents and attachments contained within it
  Future<DbResponse> deleteDb(String dbName);

  /// Creates a new document in the specified database, using the supplied JSON document structure
  Future<DbResponse> createDocInDb(String dbName, Map<String, Object> doc,
      {String batch, Map<String, String> headers});

  /// Executes the built-in _all_docs view, returning all of the documents in the database
  Future<DbResponse> getAllDocs(String dbName);

  /// Executes the built-in _all_docs view, returning specified documents in the database
  ///
  /// The POST to _all_docs allows to specify multiple [keys] to be selected from the database.
  /// This enables you to request multiple documents in a single request, in place of multiple [getDoc()] requests
  Future<DbResponse> getDocsByKeys(String dbName, {List<String> keys});

  /// Returns a JSON structure of all of the design documents in a given database
  Future<DbResponse> getAllDesignDocs(String dbName,
      {bool conflicts = false,
      bool descending = false,
      String endKey,
      String endKeyDocId,
      bool includeDocs = false,
      bool inclusiveEnd = true,
      String key,
      String keys,
      int limit,
      int skip = 0,
      String startKey,
      String startKeyDocId,
      bool updateSeq = false});

  /// Returns a JSON structure of specified design documents in a given database
  ///
  /// The POST to _design_docs allows to specify multiple [keys] to be selected from the database.
  /// This enables you to request multiple design documents in a single request, in place of multiple [getDesignDoc()] requests
  Future<DbResponse> getDesignDocsByKeys(String dbName, List<String> keys);

  /// Executes multiple specified built-in view queries of all documents in this database
  Future<DbResponse> queriesDocsFrom(String dbName, List<Object> keys);

  /// Queries several documents in bulk
  Future<DbResponse> getBulkDocs(String dbName, List<Object> docs,
      {@required bool revs});

  /// Creates and updates multiple documents at the same time within a single request
  Future<DbResponse> insertBulkDocs(String dbName, List<Object> docs,
      {bool newEdits = true, Map<String, String> headers});

  /// Find documents using a declarative JSON querying syntax
  Future<DbResponse> find(String dbName, Map<String, Object> selector,
      {int limit = 25,
      int skip,
      List<Object> sort,
      List<String> fields,
      Object useIndex,
      int r = 1,
      String bookmark,
      bool update = true,
      bool stable,
      String stale = 'false',
      bool executionStats = false});

  /// Create a new index on a database
  Future<DbResponse> createIndexIn(String dbName,
      {@required List<String> indexFields,
      String ddoc,
      String name,
      String type = 'json',
      Map<String, Object> partialFilterSelector});

  /// Gets a list of all indexes in the database
  Future<DbResponse> indexesAt(String dbName);

  /// Delets index in the database
  Future<DbResponse> deleteIndexIn(
      String dbName, String designDoc, String name);

  /// Shows which index is being used by the query
  Future<DbResponse> explain(String dbName, Map<String, Object> selector,
      {int limit = 25,
      int skip,
      List<Object> sort,
      List<String> fields,
      Object useIndex,
      int r = 1,
      String bookmark,
      bool update = true,
      bool stable,
      String stale = 'false',
      bool executionStats = false});

  /// Returns a sorted list of changes made to documents in the database
  Future<DbResponse> changesIn(String dbName,
      {List<String> docIds,
      bool conflicts = false,
      bool descending = false,
      String feed = 'normal',
      String filter,
      int heartbeat = 60000,
      bool includeDocs = false,
      bool attachments = false,
      bool attEncodingInfo = false,
      int lastEventId,
      int limit,
      String since = '0',
      String style = 'main_only',
      int timeout = 60000,
      String view,
      int seqInterval});

  /// Requests the database changes feed in the same way as [changesIn()] does,
  /// but is widely used with [filter]='_doc_ids' query parameter and allows one to pass
  /// a larger list of document IDs to [filter]
  Future<DbResponse> postChangesIn(String dbName,
      {List<String> docIds,
      bool conflicts = false,
      bool descending = false,
      String feed = 'normal',
      String filter = '_doc_ids',
      int heartbeat = 60000,
      bool includeDocs = false,
      bool attachments = false,
      bool attEncodingInfo = false,
      int lastEventId,
      int limit,
      String since = '0',
      String style = 'main_only',
      int timeout = 60000,
      String view,
      int seqInterval});

  /// Request compaction of the specified database
  Future<DbResponse> compact(String dbName);

  /// Compacts the view indexes associated with the specified design document
  Future<DbResponse> compactViewIndexesWith(String dbName, String ddocName);

  /// Commits any recent changes to the specified database to disk
  Future<DbResponse> ensureFullCommit(String dbName);

  /// Removes view index files that are no longer required by CouchDB as a result of changed views within design documents
  Future<DbResponse> viewCleanup(String dbName);

  /// Returns the current security object from the specified database
  Future<DbResponse> securityOf(String dbName);

  /// Sets the security object for the given database
  Future<DbResponse> setSecurityFor(
      String dbName, Map<String, Map<String, List<String>>> security);

  /// Permanently removes the references to deleted documents from the database
  Future<DbResponse> purge(String dbName, Map<String, List<String>> docs);

  /// Returns the document revisions that do not exist in the database
  Future<DbResponse> missingRevs(String dbName, Map<String, List<String>> revs);

  /// Returns the subset of those that do not correspond to revisions stored in the database
  Future<DbResponse> revsDiff(String dbName, Map<String, List<String>> revs);

  /// Gets the current **revs_limit** (revision limit) setting
  Future<DbResponse> revsLimitOf(String dbName);

  /// Sets the maximum number of document revisions that will be tracked by CouchDB, even after compaction has occurred
  Future<DbResponse> setRevsLimit(String dbName, int limit);
}
