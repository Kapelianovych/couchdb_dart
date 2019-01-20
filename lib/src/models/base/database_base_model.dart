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
  /// 
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "cluster": {
  ///         "n": 3,
  ///         "q": 8,
  ///         "r": 2,
  ///         "w": 2
  ///     },
  ///     "compact_running": false,
  ///     "data_size": 65031503,
  ///     "db_name": "receipts",
  ///     "disk_format_version": 6,
  ///     "disk_size": 137433211,
  ///     "doc_count": 6146,
  ///     "doc_del_count": 64637,
  ///     "instance_start_time": "0",
  ///     "other": {
  ///         "data_size": 66982448
  ///     },
  ///     "purge_seq": 0,
  ///     "sizes": {
  ///         "active": 65031503,
  ///         "external": 66982448,
  ///         "file": 137433211
  ///     },
  ///     "update_seq": "292786-g1AAAAF..."
  /// }
  /// ```
  Future<DbResponse> dbInfo(String dbName);

  /// Creates a new database
  /// 
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "ok": true
  /// }
  /// ```
  /// 
  /// Otherwise error response is returned.
  Future<DbResponse> createDb(String dbName, {int q = 8});

  /// Deletes the specified database, and all the documents and attachments contained within it
  /// 
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "ok": true
  /// }
  /// ```
  /// 
  /// Otherwise error response is returned.
  Future<DbResponse> deleteDb(String dbName);

  /// Creates a new document in the specified database, using the supplied JSON document structure
  /// 
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "id": "ab39fe0993049b84cfa81acd6ebad09d",
  ///     "ok": true,
  ///     "rev": "1-9c65296036141e575d32ba9c034dd3ee"
  /// }
  /// ```
  Future<DbResponse> createDocIn(String dbName, Map<String, Object> doc,
      {String batch, Map<String, String> headers});

  /// Executes the built-in _all_docs view, returning all of the documents in the database
  /// 
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "offset": 0,
  ///     "rows": [
  ///         {
  ///             "id": "16e458537602f5ef2a710089dffd9453",
  ///             "key": "16e458537602f5ef2a710089dffd9453",
  ///             "value": {
  ///                 "rev": "1-967a00dff5e02add41819138abb3284d"
  ///             }
  ///         },
  ///         {
  ///             "id": "a4c51cdfa2069f3e905c431114001aff",
  ///             "key": "a4c51cdfa2069f3e905c431114001aff",
  ///             "value": {
  ///                 "rev": "1-967a00dff5e02add41819138abb3284d"
  ///             }
  ///         }
  ///     ],
  ///     "total_rows": 2
  /// }
  /// ```
  Future<DbResponse> allDocs(String dbName, {bool includeDocs = false});

  /// Executes the built-in _all_docs view, returning specified documents in the database
  ///
  /// The POST to _all_docs allows to specify multiple [keys] to be selected from the database.
  /// This enables you to request multiple documents in a single request, in place of multiple [getDoc()] requests.
  /// 
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "offset": 0,
  ///     "rows": [
  ///         {
  ///             "id": "16e458537602f5ef2a710089dffd9453",
  ///             "key": "16e458537602f5ef2a710089dffd9453",
  ///             "value": {
  ///                 "rev": "1-967a00dff5e02add41819138abb3284d"
  ///             }
  ///         },
  ///         {
  ///             "id": "a4c51cdfa2069f3e905c431114001aff",
  ///             "key": "a4c51cdfa2069f3e905c431114001aff",
  ///             "value": {
  ///                 "rev": "1-967a00dff5e02add41819138abb3284d"
  ///             }
  ///         }
  ///     ],
  ///     "total_rows": 2453
  /// }
  /// ```
  Future<DbResponse> docsByKeys(String dbName, {List<String> keys});

  /// Returns a JSON structure of all of the design documents in a given database
  /// 
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "offset": 0,
  ///     "rows": [
  ///         {
  ///             "id": "_design/16e458537602f5ef2a710089dffd9453",
  ///             "key": "_design/16e458537602f5ef2a710089dffd9453",
  ///             "value": {
  ///                 "rev": "1-967a00dff5e02add41819138abb3284d"
  ///             }
  ///         },
  ///         {
  ///             "id": "_design/a4c51cdfa2069f3e905c431114001aff",
  ///             "key": "_design/a4c51cdfa2069f3e905c431114001aff",
  ///             "value": {
  ///                 "rev": "1-967a00dff5e02add41819138abb3284d"
  ///             }
  ///         }
  ///     ],
  ///     "total_rows": 2
  /// }
  /// ```
  Future<DbResponse> allDesignDocs(String dbName,
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
  /// This enables you to request multiple design documents in a single request, in place of multiple [designDoc()] requests
  /// 
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "offset": 0,
  ///     "rows": [
  ///         {
  ///             "id": "_design/16e458537602f5ef2a710089dffd9453",
  ///             "key": "_design/16e458537602f5ef2a710089dffd9453",
  ///             "value": {
  ///                 "rev": "1-967a00dff5e02add41819138abb3284d"
  ///             }
  ///         },
  ///         {
  ///             "id": "_design/a4c51cdfa2069f3e905c431114001aff",
  ///             "key": "_design/a4c51cdfa2069f3e905c431114001aff",
  ///             "value": {
  ///                 "rev": "1-967a00dff5e02add41819138abb3284d"
  ///             }
  ///         }
  ///     ],
  ///     "total_rows": 6
  /// }
  /// ```
  Future<DbResponse> designDocsByKeys(String dbName, List<String> keys);

  /// Executes multiple specified built-in view queries of all documents in this database
  /// 
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "results" : [
  ///         {
  ///             "rows": [
  ///                 {
  ///                     "id": "SpaghettiWithMeatballs",
  ///                     "key": "meatballs",
  ///                     "value": 1
  ///                 },
  ///                 {
  ///                     "id": "SpaghettiWithMeatballs",
  ///                     "key": "spaghetti",
  ///                     "value": 1
  ///                 },
  ///                 {
  ///                     "id": "SpaghettiWithMeatballs",
  ///                     "key": "tomato sauce",
  ///                     "value": 1
  ///                 }
  ///             ],
  ///             "total_rows": 3
  ///         },
  ///         {
  ///             "offset" : 2,
  ///             "rows" : [
  ///                 {
  ///                     "id" : "Adukiandorangecasserole-microwave",
  ///                     "key" : "Aduki and orange casserole - microwave",
  ///                     "value" : [
  ///                         null,
  ///                         "Aduki and orange casserole - microwave"
  ///                     ]
  ///                 },
  ///                 {
  ///                     "id" : "Aioli-garlicmayonnaise",
  ///                     "key" : "Aioli - garlic mayonnaise",
  ///                     "value" : [
  ///                         null,
  ///                         "Aioli - garlic mayonnaise"
  ///                     ]
  ///                 },
  ///                 {
  ///                     "id" : "Alabamapeanutchicken",
  ///                     "key" : "Alabama peanut chicken",
  ///                     "value" : [
  ///                         null,
  ///                         "Alabama peanut chicken"
  ///                     ]
  ///                 }
  ///             ],
  ///             "total_rows" : 2667
  ///         }
  ///     ]
  /// }
  /// ```
  Future<DbResponse> queriesDocsFrom(String dbName, List<Map<String, Object>> queries);

  /// Queries several documents in bulk
  /// 
  /// Returns JSON like:
  /// ```json
  /// {
  ///   "results": [
  ///     {
  ///       "id": "foo",
  ///       "docs": [
  ///         {
  ///           "ok": {
  ///             "_id": "bbb",
  ///             "_rev": "4-753875d51501a6b1883a9d62b4d33f91",
  ///             "value": "this is foo",
  ///             "_revisions": {
  ///               "start": 4,
  ///               "ids": [
  ///                 "753875d51501a6b1883a9d62b4d33f91",
  ///                 "efc54218773c6acd910e2e97fea2a608",
  ///                 "2ee767305024673cfb3f5af037cd2729",
  ///                 "4a7e4ae49c4366eaed8edeaea8f784ad"
  ///               ]
  ///             }
  ///           }
  ///         }
  ///       ]
  ///     },
  ///     {
  ///       "id": "foo",
  ///       "docs": [
  ///         {
  ///           "ok": {
  ///             "_id": "bbb",
  ///             "_rev": "1-4a7e4ae49c4366eaed8edeaea8f784ad",
  ///             "value": "this is the first revision of foo",
  ///             "_revisions": {
  ///               "start": 1,
  ///               "ids": [
  ///                 "4a7e4ae49c4366eaed8edeaea8f784ad"
  ///               ]
  ///             }
  ///           }
  ///         }
  ///       ]
  ///     },
  ///     {
  ///       "id": "bar",
  ///       "docs": [
  ///         {
  ///           "ok": {
  ///             "_id": "bar",
  ///             "_rev": "2-9b71d36dfdd9b4815388eb91cc8fb61d",
  ///             "baz": true,
  ///             "_revisions": {
  ///               "start": 2,
  ///               "ids": [
  ///                 "9b71d36dfdd9b4815388eb91cc8fb61d",
  ///                 "309651b95df56d52658650fb64257b97"
  ///               ]
  ///             }
  ///           }
  ///         }
  ///       ]
  ///     }
  ///   ]
  /// }
  /// ```
  Future<DbResponse> bulkDocs(String dbName, List<Object> docs,
      {@required bool revs});

  /// Creates and updates multiple documents at the same time within a single request
  /// 
  /// Returns JSON like:
  /// ```json
  /// [
  ///     {
  ///         "ok": true,
  ///         "id": "FishStew",
  ///         "rev":" 1-967a00dff5e02add41819138abb3284d"
  ///     },
  ///     {
  ///         "ok": true,
  ///         "id": "LambStew",
  ///         "rev": "3-f9c62b2169d0999103e9f41949090807"
  ///     }
  /// ]
  /// ```
  Future<DbResponse> insertBulkDocs(String dbName, List<Object> docs,
      {bool newEdits = true, Map<String, String> headers});

  /// Find documents using a declarative JSON querying syntax
  /// 
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "docs": [
  ///         {
  ///             "_id": "176694",
  ///             "_rev": "1-54f8e950cc338d2385d9b0cda2fd918e",
  ///             "year": 2011,
  ///             "title": "The Tragedy of Man"
  ///         },
  ///         {
  ///             "_id": "780504",
  ///             "_rev": "1-5f14bab1a1e9ac3ebdf85905f47fb084",
  ///             "year": 2011,
  ///             "title": "Drive"
  ///         }
  ///     ],
  ///     "execution_stats": {
  ///         "total_keys_examined": 0,
  ///         "total_docs_examined": 200,
  ///         "total_quorum_docs_examined": 0,
  ///         "results_returned": 2,
  ///         "execution_time_ms": 5.52
  ///     }
  /// }
  /// ```
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
