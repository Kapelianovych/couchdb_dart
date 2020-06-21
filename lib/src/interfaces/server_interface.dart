import 'package:meta/meta.dart';

import '../responses/server_response.dart';

/// Server interface provides the basic interface to a CouchDB server
/// for obtaining CouchDB information and getting and setting configuration information
abstract class ServerInterface {

  /// Accessing the root of a CouchDB instance returns meta information about the instance
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///   "couchdb": "Welcome",
  ///   "uuid": "85fb71bf700c17267fef77535820e371",
  ///   "vendor": {
  ///       "name": "The Apache Software Foundation",
  ///       "version": "1.3.1"
  ///   },
  ///   "version": "1.3.1"
  /// }
  /// ```
  Future<ServerResponse> couchDbInfo({Map<String, String> headers});

  /// List of running tasks, including the task type, name, status and process ID
  ///
  /// Returns JSON like:
  /// ```json
  /// [
  ///     {
  ///         "changes_done": 64438,
  ///         "database": "mailbox",
  ///         "pid": "<0.12986.1>",
  ///         "progress": 84,
  ///         "started_on": 1376116576,
  ///         "total_changes": 76215,
  ///         "type": "database_compaction",
  ///         "updated_on": 1376116619
  ///     },
  ///     {
  ///         "checkpointed_source_seq": 68585,
  ///         "continuous": false,
  ///         "doc_id": null,
  ///         "doc_write_failures": 0,
  ///         "docs_read": 4524,
  ///         "docs_written": 4524,
  ///         "missing_revisions_found": 4524,
  ///         "pid": "<0.1538.5>",
  ///         "progress": 44,
  ///         "replication_id": "9bc1727d74d49d9e157e260bb8bbd1d5",
  ///         "revisions_checked": 4524,
  ///         "source": "mailbox",
  ///         "source_seq": 154419,
  ///         "started_on": 1376116644,
  ///         "target": "http://mailsrv:5984/mailbox",
  ///         "type": "replication",
  ///         "updated_on": 1376116651
  ///     }
  /// ]
  /// ```
  Future<ServerResponse> activeTasks({Map<String, String> headers});

  /// Returns a list of all the databases in the CouchDB instance
  ///
  /// Returns JSON like:
  /// ```json
  /// [
  ///   "_users",
  ///   "contacts",
  ///   "docs",
  ///   "invoices",
  ///   "locations"
  /// ]
  /// ```
  Future<ServerResponse> allDbs({Map<String, String> headers});

  /// Returns information of a list of the specified databases in the CouchDB instance
  ///
  /// Returns JSON like:
  /// ```json
  /// [
  ///   {
  ///     "key": "animals",
  ///     "info": {
  ///       "db_name": "animals",
  ///       "update_seq": "52232",
  ///       "sizes": {
  ///         "file": 1178613587,
  ///         "external": 1713103872,
  ///         "active": 1162451555
  ///       },
  ///       "purge_seq": 0,
  ///       "other": {
  ///         "data_size": 1713103872
  ///       },
  ///       "doc_del_count": 0,
  ///       "doc_count": 52224,
  ///       "disk_size": 1178613587,
  ///       "disk_format_version": 6,
  ///       "data_size": 1162451555,
  ///       "compact_running": false,
  ///       "cluster": {
  ///        "q": 8,
  ///         "n": 3,
  ///         "w": 2,
  ///         "r": 2
  ///       },
  ///       "instance_start_time": "0"
  ///     }
  ///   },
  ///   {
  ///     "key": "plants",
  ///     "info": {
  ///       "db_name": "plants",
  ///       "update_seq": "303",
  ///       "sizes": {
  ///         "file": 3872387,
  ///         "external": 2339,
  ///         "active": 67475
  ///       },
  ///       "purge_seq": 0,
  ///       "other": {
  ///         "data_size": 2339
  ///       },
  ///       "doc_del_count": 0,
  ///       "doc_count": 11,
  ///       "disk_size": 3872387,
  ///       "disk_format_version": 6,
  ///       "data_size": 67475,
  ///       "compact_running": false,
  ///       "cluster": {
  ///         "q": 8,
  ///         "n": 3,
  ///         "w": 2,
  ///         "r": 2
  ///       },
  ///       "instance_start_time": "0"
  ///     }
  ///   }
  /// ]
  /// ```
  Future<ServerResponse> dbsInfo(List<String> keys);

  /// Returns the status of the node or cluster, per the cluster setup wizard
  ///
  /// If [ensureDbsExist] isn't specified, it is defaults to `["_users","_replicator","_global_changes"]`.
  /// Return JSON like:
  /// ```json
  /// {"state": "cluster_enabled"}
  /// ```
  /// May be one of the following:
  /// - `cluster_disabled`,
  /// - `single_node_disabled`,
  /// - `single_node_enabled`,
  /// - `cluster_enabled`,
  /// - `cluster_finished`
  Future<ServerResponse> clusterSetupStatus(
      {List<String> ensureDbsExist, Map<String, String> headers});

  /// Configure a node as a single (standalone) node, as part of a cluster, or finalise a cluster
  ///
  /// Correspond to `POST /_cluster_setup` method.
  /// If [ensureDbsExist] isn't specified, it is defaults to `["_users","_replicator","_global_changes"]`.
  /// [bindAdress] should be provided not [host], if CouchDB is configuring as `single_node`.
  Future<ServerResponse> configureCouchDb(
      {@required String action,
      @required String bindAdress,
      @required String username,
      @required String password,
      @required int port,
      int nodeCount,
      String remoteNode,
      String remoteCurrentUser,
      String remoteCurrentPassword,
      String host,
      List<String> ensureDbsExist,
      Map<String, String> headers});

  /// Returns a list of all database events in the CouchDB instance
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "results": [
  ///         {
  ///           "db_name": "mailbox",
  ///           "type": "created",
  ///           "seq": "1-g1AAAAFReJzLYWBg4MhgTmHgzcvPy09JdcjLz8gvLskBCjMlMiTJ____PyuDOZExFyjAnmJhkWaeaIquGIf2JAUgmWQPMiGRAZcaB5CaePxqEkBq6vGqyWMBkgwNQAqobD4h"
  ///         },
  ///         {
  ///           "db_name": "mailbox",
  ///           "type": "deleted",
  ///           "seq": "2-g1AAAAFReJzLYWBg4MhgTmHgzcvPy09JdcjLz8gvLskBCjMlMiTJ____PyuDOZEpFyjAnmJhkWaeaIquGIf2JAUgmWQPMiGRAZcaB5CaePxqEkBq6vGqyWMBkgwNQAqobD4hdQsg6vYTUncAou4-IXUPIOpA7ssCAIFHa60"
  ///         },
  ///     ],
  ///     "last_seq": "2-g1AAAAFReJzLYWBg4MhgTmHgzcvPy09JdcjLz8gvLskBCjMlMiTJ____PyuDOZEpFyjAnmJhkWaeaIquGIf2JAUgmWQPMiGRAZcaB5CaePxqEkBq6vGqyWMBkgwNQAqobD4hdQsg6vYTUncAou4-IXUPIOpA7ssCAIFHa60"
  /// }
  /// ```
  Future<ServerResponse> dbUpdates(
      {String feed = 'normal',
      int timeout = 60,
      int heartbeat = 60000,
      String since,
      Map<String, String> headers});

  /// Displays the nodes that are part of the cluster as `cluster_nodes`\
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "all_nodes": [
  ///         "node1@127.0.0.1",
  ///         "node2@127.0.0.1",
  ///         "node3@127.0.0.1"
  ///     ],
  ///     "cluster_nodes": [
  ///         "node1@127.0.0.1",
  ///         "node2@127.0.0.1",
  ///         "node3@127.0.0.1"
  ///     ]
  /// }
  /// ```
  Future<ServerResponse> membership({Map<String, String> headers});

  /// Request, configure, or stop, a replication operation
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "history": [
  ///         {
  ///             "doc_write_failures": 0,
  ///             "docs_read": 10,
  ///             "docs_written": 10,
  ///             "end_last_seq": 28,
  ///             "end_time": "Sun, 11 Aug 2013 20:38:50 GMT",
  ///             "missing_checked": 10,
  ///             "missing_found": 10,
  ///             "recorded_seq": 28,
  ///             "session_id": "142a35854a08e205c47174d91b1f9628",
  ///             "start_last_seq": 1,
  ///             "start_time": "Sun, 11 Aug 2013 20:38:50 GMT"
  ///         },
  ///         {
  ///             "doc_write_failures": 0,
  ///             "docs_read": 1,
  ///             "docs_written": 1,
  ///             "end_last_seq": 1,
  ///             "end_time": "Sat, 10 Aug 2013 15:41:54 GMT",
  ///             "missing_checked": 1,
  ///             "missing_found": 1,
  ///             "recorded_seq": 1,
  ///             "session_id": "6314f35c51de3ac408af79d6ee0c1a09",
  ///             "start_last_seq": 0,
  ///             "start_time": "Sat, 10 Aug 2013 15:41:54 GMT"
  ///         }
  ///     ],
  ///     "ok": true,
  ///     "replication_id_version": 3,
  ///     "session_id": "142a35854a08e205c47174d91b1f9628",
  ///     "source_last_seq": 28
  /// }
  /// ```
  Future<ServerResponse> replicate(
      {bool cancel,
      bool continuous,
      bool createTarget,
      List<String> docIds,
      String filterFunJS,
      String proxy,
      Object source,
      Object target,
      Map<String, String> headers});

  /// List of replication jobs
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "jobs": [
  ///         {
  ///             "database": "_replicator",
  ///             "doc_id": "cdyno-0000001-0000003",
  ///             "history": [
  ///                 {
  ///                     "timestamp": "2017-04-29T05:01:37Z",
  ///                     "type": "started"
  ///                 },
  ///                 {
  ///                     "timestamp": "2017-04-29T05:01:37Z",
  ///                     "type": "added"
  ///                 }
  ///             ],
  ///             "id": "8f5b1bd0be6f9166ccfd36fc8be8fc22+continuous",
  ///             "node": "node1@127.0.0.1",
  ///             "pid": "<0.1850.0>",
  ///             "source": "http://myserver.com/foo",
  ///             "start_time": "2017-04-29T05:01:37Z",
  ///             "target": "http://adm:*****@localhost:15984/cdyno-0000003/",
  ///             "user": null
  ///         }
  ///     ],
  ///     "offset": 0,
  ///     "total_rows": 2
  ///  }
  /// ```
  Future<ServerResponse> schedulerJobs({int limit, int skip});

  /// List of replication document states
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "docs": [
  ///         {
  ///             "database": "_replicator",
  ///             "doc_id": "cdyno-0000001-0000002",
  ///             "error_count": 0,
  ///             "id": "e327d79214831ca4c11550b4a453c9ba+continuous",
  ///             "info": null,
  ///             "last_updated": "2017-04-29T05:01:37Z",
  ///             "node": "node2@127.0.0.1",
  ///             "proxy": null,
  ///             "source": "http://myserver.com/foo",
  ///             "start_time": "2017-04-29T05:01:37Z",
  ///             "state": "running",
  ///             "target": "http://adm:*****@localhost:15984/cdyno-0000002/"
  ///         }
  ///     ],
  ///     "offset": 0,
  ///     "total_rows": 2
  /// }
  /// ```
  Future<ServerResponse> schedulerDocs({int limit, int skip});

  /// Gets information about replication documents from a [replicator] database
  ///
  /// The default [replicator] database is `_replicator` but other [replicator] databases can exist
  /// if their name ends with the suffix `/_replicator`.
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "docs": [
  ///         {
  ///             "database": "other/_replicator",
  ///             "doc_id": "cdyno-0000001-0000002",
  ///             "error_count": 0,
  ///             "id": "e327d79214831ca4c11550b4a453c9ba+continuous",
  ///             "info": null,
  ///             "last_updated": "2017-04-29T05:01:37Z",
  ///             "node": "node2@127.0.0.1",
  ///             "proxy": null,
  ///             "source": "http://myserver.com/foo",
  ///             "start_time": "2017-04-29T05:01:37Z",
  ///             "state": "running",
  ///             "target": "http://adm:*****@localhost:15984/cdyno-0000002/"
  ///         }
  ///     ],
  ///     "offset": 0,
  ///     "total_rows": 1
  /// }
  /// ```
  Future<ServerResponse> schedulerDocsWithReplicatorDbName(
      {String replicator = '_replicator', int limit, int skip});

  /// Gets information about replication document from a [replicator] database
  ///
  /// The default [replicator] database is `_replicator` but other [replicator] databases can exist
  /// if their name ends with the suffix `/_replicator`.
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "database": "other/_replicator",
  ///     "doc_id": "cdyno-0000001-0000002",
  ///     "error_count": 0,
  ///     "id": "e327d79214831ca4c11550b4a453c9ba+continuous",
  ///     "info": null,
  ///     "last_updated": "2017-04-29T05:01:37Z",
  ///     "node": "node2@127.0.0.1",
  ///     "proxy": null,
  ///     "source": "http://myserver.com/foo",
  ///     "start_time": "2017-04-29T05:01:37Z",
  ///     "state": "running",
  ///     "target": "http://adm:*****@localhost:15984/cdyno-0000002/"
  /// }
  /// ```
  Future<ServerResponse> schedulerDocsWithDocId(String docId,
      {String replicator = '_replicator'});

  /// Returns a JSON object containing the statistics for the running server
  ///
  /// [statisticSection] may be one of:
  ///
  ///     1. couch_log: Logging subsystem
  ///     2. couch_replicator: Replication scheduler and subsystem
  ///     3. couchdb: Primary CouchDB database operations
  ///     4. fabric: Cluster-related operations
  ///     5. global_changes: Global changes feed
  ///     6. mem3: Node membership-related statistics
  ///     7. pread: CouchDB file-related exceptions
  ///     8. rexi: Cluster internal RPC-related statistics
  ///
  /// and [statisticId] is individual part of [statisticSection].
  ///
  /// JSON may be like if [statisticSection] and [statisticId] are provided:
  /// ```json
  /// {
  ///   "value": {
  ///     "min": 0,
  ///     "max": 0,
  ///     "arithmetic_mean": 0,
  ///     "geometric_mean": 0,
  ///     "harmonic_mean": 0,
  ///     "median": 0,
  ///     "variance": 0,
  ///     "standard_deviation": 0,
  ///     "skewness": 0,
  ///     "kurtosis": 0,
  ///     "percentile": [
  ///       [
  ///         50,
  ///         0
  ///       ],
  ///       [
  ///         75,
  ///         0
  ///       ],
  ///       [
  ///         90,
  ///         0
  ///       ],
  ///       [
  ///         95,
  ///         0
  ///       ],
  ///       [
  ///         99,
  ///         0
  ///       ],
  ///       [
  ///         999,
  ///         0
  ///       ]
  ///     ],
  ///     "histogram": [
  ///       [
  ///         0,
  ///         0
  ///       ]
  ///     ],
  ///     "n": 0
  ///   },
  ///   "type": "histogram",
  ///   "desc": "length of a request inside CouchDB without MochiWeb"
  /// }
  /// ```
  Future<ServerResponse> nodeStats(
      {String nodeName = '_local',
      String statisticSection,
      String statisticId,
      Map<String, String> headers});

  /// Returns a JSON object containing various system-level statistics for the running server
  ///
  /// **These statistics are generally intended for CouchDB developers only.**
  Future<ServerResponse> systemStatsForNode(
      {String nodeName = '_local', Map<String, String> headers});

  // /// Accesses the built-in Fauxton administration interface for CouchDB.
  // ///
  // /// Don't work in browser environment!
  // Future<void> utils();

  /// Confirms that the server is up, running, and ready to respond to requests
  ///
  /// Returns JSON like:
  /// ```json
  /// {"status": "ok"}
  /// ```
  Future<ServerResponse> up();

  /// Requests one or more Universally Unique Identifiers (UUIDs) from the CouchDB instance
  ///
  /// Returns JSON like:
  /// ```json
  /// {
  ///     "uuids": [
  ///         "75480ca477454894678e22eec6002413",
  ///         "75480ca477454894678e22eec600250b",
  ///         "75480ca477454894678e22eec6002c41",
  ///         "75480ca477454894678e22eec6003b90",
  ///         "75480ca477454894678e22eec6003fca",
  ///         "75480ca477454894678e22eec6004bef",
  ///         "75480ca477454894678e22eec600528f",
  ///         "75480ca477454894678e22eec6005e0b",
  ///         "75480ca477454894678e22eec6006158",
  ///         "75480ca477454894678e22eec6006161"
  ///     ]
  /// }
  /// ```
  Future<ServerResponse> uuids(
      {int count = 1, Map<String, String> headers});

// /// Binary content for the favicon.ico site icon
// /// Returns 'Not found' if favicon isn't exist.
// /// Throws `FormatException` all time. **Don't use it!**
// Future<DbResponse> favicon();
}
