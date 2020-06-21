import 'package:meta/meta.dart';

import '../responses/databases_response.dart';

/// Class that define methods for interacting with entire database in CouchDB
abstract class DatabasesInterface {
  /// Returns the HTTP Headers containing a minimal amount of information
  /// about the specified database
  Future<DatabasesResponse> headDbInfo(String dbName);

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
  Future<DatabasesResponse> dbInfo(String dbName);

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
  Future<DatabasesResponse> createDb(String dbName, {int q = 8});

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
  Future<DatabasesResponse> deleteDb(String dbName);

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
  Future<DatabasesResponse> createDocIn(
      String dbName, Map<String, Object> doc,
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
  Future<DatabasesResponse> allDocs(String dbName,
      {bool conflicts = false,
      bool descending = false,
      Object endKey,
      String endKeyDocId,
      bool group = false,
      int groupLevel,
      bool includeDocs = false,
      bool attachments = false,
      bool altEncodingInfo = false,
      bool inclusiveEnd = true,
      Object key,
      List<Object> keys,
      int limit,
      bool reduce,
      int skip,
      bool sorted = true,
      bool stable = false,
      String stale,
      Object startKey,
      String startKeyDocId,
      String update,
      bool updateSeq = false});

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
  Future<DatabasesResponse> docsByKeys(String dbName, {List<String> keys});

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
  Future<DatabasesResponse> allDesignDocs(String dbName,
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
  Future<DatabasesResponse> designDocsByKeys(
      String dbName, List<String> keys);

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
  Future<DatabasesResponse> queriesDocsFrom(
      String dbName, List<Map<String, Object>> queries);

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
  Future<DatabasesResponse> bulkDocs(String dbName, List<Object> docs,
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
  Future<DatabasesResponse> insertBulkDocs(String dbName, List<Object> docs,
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
  Future<DatabasesResponse> find(
      String dbName, Map<String, Object> selector,
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
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "result": "created",
  ///     "id": "_design/a5f4711fc9448864a13c81dc71e660b524d7410c",
  ///     "name": "foo-index"
  /// }
  /// ```
  Future<DatabasesResponse> createIndexIn(String dbName,
      {@required List<String> indexFields,
      String ddoc,
      String name,
      String type = 'json',
      Map<String, Object> partialFilterSelector});

  /// Gets a list of all indexes in the database
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "total_rows": 2,
  ///     "indexes": [
  ///     {
  ///         "ddoc": null,
  ///         "name": "_all_docs",
  ///         "type": "special",
  ///         "def": {
  ///             "fields": [
  ///                 {
  ///                     "_id": "asc"
  ///                 }
  ///             ]
  ///         }
  ///     },
  ///     {
  ///         "ddoc": "_design/a5f4711fc9448864a13c81dc71e660b524d7410c",
  ///         "name": "foo-index",
  ///         "type": "json",
  ///         "def": {
  ///             "fields": [
  ///                 {
  ///                     "foo": "asc"
  ///                 }
  ///             ]
  ///         }
  ///     }
  ///   ]
  /// }
  /// ```
  Future<DatabasesResponse> indexesAt(String dbName);

  /// Delets index in the database
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "ok": "true"
  /// }
  /// ```
  Future<DatabasesResponse> deleteIndexIn(
      String dbName, String designDoc, String name);

  /// Shows which index is being used by the query
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "dbname": "movies",
  ///     "index": {
  ///         "ddoc": "_design/0d61d9177426b1e2aa8d0fe732ec6e506f5d443c",
  ///         "name": "0d61d9177426b1e2aa8d0fe732ec6e506f5d443c",
  ///         "type": "json",
  ///         "def": {
  ///             "fields": [
  ///                 {
  ///                     "year": "asc"
  ///                 }
  ///             ]
  ///         }
  ///     },
  ///     "selector": {
  ///         "year": {
  ///             "$gt": 2010
  ///         }
  ///     },
  ///     "opts": {
  ///         "use_index": [],
  ///         "bookmark": "nil",
  ///         "limit": 2,
  ///         "skip": 0,
  ///         "sort": {},
  ///         "fields": [
  ///             "_id",
  ///             "_rev",
  ///             "year",
  ///             "title"
  ///         ],
  ///         "r": [
  ///             49
  ///         ],
  ///         "conflicts": false
  ///     },
  ///     "limit": 2,
  ///     "skip": 0,
  ///     "fields": [
  ///         "_id",
  ///         "_rev",
  ///         "year",
  ///         "title"
  ///     ],
  ///     "range": {
  ///         "start_key": [
  ///             2010
  ///         ],
  ///         "end_key": [
  ///             {}
  ///         ]
  ///     }
  /// }
  /// ```
  Future<DatabasesResponse> explain(
      String dbName, Map<String, Object> selector,
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

  /// Returns a list of database shards. Each shard will have its internal
  /// database range, and the nodes on which replicas of those shards are stored
  ///
  /// Returns JSON like:
  /// ```dart
  /// {
  ///   "shards": {
  ///     "00000000-1fffffff": [
  ///       "couchdb@node1.example.com",
  ///       "couchdb@node2.example.com",
  ///       "couchdb@node3.example.com"
  ///     ],
  ///     "20000000-3fffffff": [
  ///       "couchdb@node1.example.com",
  ///       "couchdb@node2.example.com",
  ///       "couchdb@node3.example.com"
  ///     ]
  ///   }
  /// }
  /// ```
  Future<DatabasesResponse> shards(String dbName);

  /// Returns information about the specific shard into which a given document
  /// has been stored, along with information about the nodes on which that
  /// shard has a replica
  ///
  /// Returns JSON like:
  /// ```dart
  /// {
  ///   "range": "e0000000-ffffffff",
  ///   "nodes": [
  ///     "node1@127.0.0.1",
  ///     "node2@127.0.0.1",
  ///     "node3@127.0.0.1"
  ///   ]
  /// }
  /// ```
  Future<DatabasesResponse> shard(String dbName, String docId);

  /// For the given database, force-starts internal shard synchronization
  /// for all replicas of all database shards
  ///
  /// This is typically only used when performing cluster maintenance,
  /// such as moving a shard.
  ///
  /// Returns JSON like:
  /// ```dart
  /// {
  ///     "ok": true
  /// }
  /// ```
  Future<DatabasesResponse> synchronizeShards(String dbName);

  /// Returns a sorted list of changes made to documents in the database
  ///
  /// [feed] may be one from:
  ///
  ///     - `normal`
  ///     - `longpoll`
  ///     - `continuous`
  ///     - `eventsource`
  ///
  /// For `eventsource` value of [feed] JSON response placed at `results` field
  ///  with `Map` objects with two fields `data` and `id`.
  /// `last_seq` and `pending` fields are missing in returned JSON if [feed]
  /// have `eventsource` or `continuous` values.
  ///
  /// [Read more about difference between above values.](http://docs.couchdb.org/en/stable/api/database/changes.html#changes-feeds)
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "last_seq": "5-g1AAAAIreJyVkEsKwjAURZ-toI5cgq5A0sQ0OrI70XyppcaRY
  /// 92J7kR3ojupaSPUUgotgRd4yTlwbw4A0zRUMLdnpaMkwmyF3Ily9xBwEIuiKLI05KOT
  /// W0wkV4rruP29UyGWbordzwKVxWBNOGMKZhertDlarbr5pOT3DV4gudUC9-MPJX9tpEA
  /// Yx4TQASns2E24ucuJ7rXJSL1BbEgf3vTwpmedCZkYa7Pulck7Xt7x_usFU2aIHOD4e
  /// EfVTVA5KMGUkqhNZV-8_o5i",
  ///     "pending": 0,
  ///     "results": [
  ///         {
  ///             "changes": [
  ///                 {
  ///                     "rev": "2-7051cbe5c8faecd085a3fa619e6e6337"
  ///                 }
  ///             ],
  ///             "id": "6478c2ae800dfc387396d14e1fc39626",
  ///             "seq": "3-g1AAAAG3eJzLYWBg4MhgTmHgz8tPSTV0MDQy1zMAQsMcoAR
  /// TIkOS_P___7MSGXAqSVIAkkn2IFUZzIkMuUAee5pRqnGiuXkKA2dpXkpqWmZeagpu_Q4
  /// g_fGEbEkAqaqH2sIItsXAyMjM2NgUUwdOU_JYgCRDA5ACGjQfn30QlQsgKvcjfGaQZma
  /// UmmZClM8gZhyAmHGfsG0PICrBPmQC22ZqbGRqamyIqSsLAAArcXo"
  ///         },
  ///         {
  ///             "changes": [
  ///                 {
  ///                     "rev": "3-7379b9e515b161226c6559d90c4dc49f"
  ///                 }
  ///             ],
  ///             "deleted": true,
  ///             "id": "5bbc9ca465f1b0fcd62362168a7c8831",
  ///             "seq": "4-g1AAAAHXeJzLYWBg4MhgTmHgz8tPSTV0MDQy1zMAQsMcoAR
  /// TIkOS_P___7MymBMZc4EC7MmJKSmJqWaYynEakaQAJJPsoaYwgE1JM0o1TjQ3T2HgLM1L
  /// SU3LzEtNwa3fAaQ_HqQ_kQG3qgSQqnoUtxoYGZkZG5uS4NY8FiDJ0ACkgAbNx2cfROUCi
  /// Mr9CJ8ZpJkZpaaZEOUziBkHIGbcJ2zbA4hKsA-ZwLaZGhuZmhobYurKAgCz33kh"
  ///         },
  ///         {
  ///             "changes": [
  ///                 {
  ///                     "rev": "6-460637e73a6288cb24d532bf91f32969"
  ///                 },
  ///                 {
  ///                     "rev": "5-eeaa298781f60b7bcae0c91bdedd1b87"
  ///                 }
  ///             ],
  ///             "id": "729eb57437745e506b333068fff665ae",
  ///             "seq": "5-g1AAAAIReJyVkE0OgjAQRkcwUVceQU9g-mOpruQm2tI2SLCuX
  /// OtN9CZ6E70JFmpCCCFCmkyTdt6bfJMDwDQNFcztWWkcY8JXyB2cu49AgFwURZGloRid3MMk
  /// EUoJHbXbOxVy6arc_SxQWQzRVHCuYHaxSpuj1aqbj0t-3-AlSrZakn78oeSvjRSIkIhSNiC
  /// FHbsKN3c50b02mURvEB-yD296eNOzzoRMRLRZ98rkHS_veGcC_nR-fGe1gaCaxihhjOI2lX
  /// 0BhniHaA"
  ///         }
  ///     ]
  /// }
  /// ```
  Future<Stream<DatabasesResponse>> changesIn(String dbName,
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
  /// but is widely used with [filter]='_doc_ids' query parameter and allows
  /// one to pass a larger list of document IDs to [filter]
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "last_seq": "5-g1AAAAIreJyVkEsKwjAURZ-toI5cgq5A0sQ0OrI70XyppcaRY92J7kR3ojupaSPUUgotgRd4yTlwbw4A0zRUMLdnpaMkwmyF3Ily9xBwEIuiKLI05KOTW0wkV4rruP29UyGWbordzwKVxWBNOGMKZhertDlarbr5pOT3DV4gudUC9-MPJX9tpEAYx4TQASns2E24ucuJ7rXJSL1BbEgf3vTwpmedCZkYa7Pulck7Xt7x_usFU2aIHOD4eEfVTVA5KMGUkqhNZV8_o5i",
  ///     "pending": 0,
  ///     "results": [
  ///         {
  ///             "changes": [
  ///                 {
  ///                     "rev": "13-bcb9d6388b60fd1e960d9ec4e8e3f29e"
  ///                 }
  ///             ],
  ///             "id": "SpaghettiWithMeatballs",
  ///             "seq":  "5-g1AAAAIReJyVkE0OgjAQRkcwUVceQU9g-mOpruQm2tI2SLCuXOtN9CZ6E70JFmpCCCFCmkyTdt6bfJMDwDQNFcztWWkcY8JXyB2cu49AgFwURZGloRid3MMkEUoJHbXbOxVy6arc_SxQWQzRVHCuYHaxSpuj1aqbj0t-3-AlSrZakn78oeSvjRSIkIhSNiCFHbsKN3c50b02mURvEB-yD296eNOzzoRMRLRZ98rkHS_veGcC_nR-fGe1gaCaxihhjOI2lX0BhniHaA"
  ///         }
  ///     ]
  /// }
  /// ```
  Future<Stream<DatabasesResponse>> postChangesIn(String dbName,
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
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "ok": true
  /// }
  /// ```
  Future<DatabasesResponse> compact(String dbName);

  /// Compacts the view indexes associated with the specified design document
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "ok": true
  /// }
  /// ```
  Future<DatabasesResponse> compactViewIndexesWith(
      String dbName, String ddocName);

  /// Commits any recent changes to the specified database to disk
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     // This property isn't listed in [DatabaseModelResponse]
  ///     "instance_start_time": "0",
  ///     "ok": true
  /// }
  /// ```
  Future<DatabasesResponse> ensureFullCommit(String dbName);

  /// Removes view index files that are no longer required by CouchDB as a result of changed views within design documents
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "ok": true
  /// }
  /// ```
  Future<DatabasesResponse> viewCleanup(String dbName);

  /// Returns the current security object from the specified database
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "admins": {
  ///         "names": [
  ///             "superuser"
  ///         ],
  ///         "roles": [
  ///             "admins"
  ///         ]
  ///     },
  ///     "members": {
  ///         "names": [
  ///             "user1",
  ///             "user2"
  ///         ],
  ///         "roles": [
  ///             "developers"
  ///         ]
  ///     }
  /// }
  /// ```
  Future<DatabasesResponse> securityOf(String dbName);

  /// Sets the security object for the given database
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "ok": true
  /// }
  /// ```
  Future<DatabasesResponse> setSecurityFor(
      String dbName, Map<String, Map<String, List<String>>> security);

  /// Permanently removes the references to deleted documents from the database
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///   "purge_seq": null,
  ///   "purged": {
  ///     "c6114c65e295552ab1019e2b046b10e": {
  ///       "purged": [
  ///         "3-c50a32451890a3f1c3e423334cc92745"
  ///       ]
  ///     }
  ///   }
  /// }
  /// ```
  Future<DatabasesResponse> purge(
      String dbName, Map<String, List<String>> docs);

  /// Gets the current purged_infos_limit (purged documents limit) setting,
  /// the maximum number of historical purges (purged document Ids with their revisions)
  /// that can be stored in the database
  ///
  /// Returns JSON like:
  /// ```json
  /// 1000
  /// ```
  Future<DatabasesResponse> purgedInfosLimit(String dbName);

  /// Sets the maximum number of purges (requested purged Ids with their revisions)
  /// that will be tracked in the database, even after compaction has occurred
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "ok": true
  /// }
  /// ```
  Future<DatabasesResponse> setPurgedInfosLimit(String dbName, int limit);

  /// Returns the document revisions that do not exist in the database
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "missed_revs":{
  ///         "c6114c65e295552ab1019e2b046b10e": [
  ///             "3-b06fcd1c1c9e0ec7c480ee8aa467bf3b"
  ///         ]
  ///     }
  /// }
  /// ```
  Future<DatabasesResponse> missingRevs(
      String dbName, Map<String, List<String>> revs);

  /// Returns the subset of those that do not correspond to revisions stored in the database
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "190f721ca3411be7aa9477db5f948bbb": {
  ///         "missing": [
  ///             "3-bb72a7682290f94a985f7afac8b27137",
  ///             "5-067a00dff5e02add41819138abb3284d"
  ///         ],
  ///         "possible_ancestors": [
  ///             "4-10265e5a26d807a3cfa459cf1a82ef2e"
  ///         ]
  ///     }
  /// }
  /// ```
  Future<DatabasesResponse> revsDiff(
      String dbName, Map<String, List<String>> revs);

  /// Gets the current **revs_limit** (revision limit) setting
  ///
  /// Returns JSON like:
  /// ```json
  /// 1000
  /// ```
  Future<DatabasesResponse> revsLimitOf(String dbName);

  /// Sets the maximum number of document revisions that will be tracked by CouchDB, even after compaction has occurred
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "ok": true
  /// }
  /// ```
  Future<DatabasesResponse> setRevsLimit(String dbName, int limit);
}
