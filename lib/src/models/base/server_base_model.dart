import 'package:meta/meta.dart';

import '../../clients/base/couchdb_base_client.dart';
import '../../entities/db_response.dart';
import 'base_model.dart';

/// Server interface provides the basic interface to a CouchDB server
/// for obtaining CouchDB information and getting and setting configuration information
abstract class ServerBaseModel extends BaseModel {
  /// Create ServerModel by accepting web-based or server-based client
  ServerBaseModel(CouchDbBaseClient client) : super(client);

  /// Accessing the root of a CouchDB instance returns meta information about the instance
  Future<DbResponse> couchDbInfo({Map<String, String> headers});

  /// List of running tasks, including the task type, name, status and process ID
  ///
  /// Result of this method is available in [DbResponse.results] field
  Future<DbResponse> activeTasks({Map<String, String> headers});

  /// Returns a list of all the databases in the CouchDB instance
  ///
  /// Result of this method is available in [DbResponse.results] field
  Future<DbResponse> allDbs({Map<String, String> headers});

  /// Returns information of a list of the specified databases in the CouchDB instance
  ///
  /// Result of this method is available in [DbResponse.results] field
  Future<DbResponse> dbsInfo(List<String> keys);

  /// Returns the status of the node or cluster, per the cluster setup wizard
  ///
  /// If [ensureDbsExist] isn't specified, it is defaults to `["_users","_replicator","_global_changes"]`
  Future<DbResponse> getClusterSetup(
      {List<String> ensureDbsExist, Map<String, String> headers});

  /// Configure a node as a single (standalone) node, as part of a cluster, or finalise a cluster
  ///
  /// Correspond to `POST /_cluster_setup` method.
  /// If [ensureDbsExist] isn't specified, it is defaults to `["_users","_replicator","_global_changes"]`.
  /// [bindAdress] should be provided not [host], if CouchDB is configuring as `single_node`.
  Future<DbResponse> configureCouchDb(
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
  Future<DbResponse> dbUpdates(
      {String feed = 'normal',
      int timeout = 60,
      int heartbeat = 60000,
      String since,
      Map<String, String> headers});

  /// Displays the nodes that are part of the cluster as `cluster_nodes`
  Future<DbResponse> membership({Map<String, String> headers});

  /// Request, configure, or stop, a replication operation
  Future<DbResponse> replicate(
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
  Future<DbResponse> schedulerJobs({int limit, int skip});

  /// List of replication document states
  Future<DbResponse> schedulerDocs({int limit, int skip});

  /// Gets information about replication documents from a [replicator] database
  ///
  /// The default [replicator] database is `_replicator` but other [replicator] databases can exist
  /// if their name ends with the suffix `/_replicator`
  Future<DbResponse> schedulerDocsWithReplicatorDbName(
      {String replicator = '_replicator', int limit, int skip});

  /// Gets information about replication document from a [replicator] database
  ///
  /// The default [replicator] database is `_replicator` but other [replicator] databases can exist
  /// if their name ends with the suffix `/_replicator`
  Future<DbResponse> schedulerDocsWithDocId(String docId,
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
  Future<DbResponse> nodeStats(
      {String nodeName = '_local',
      String statisticSection,
      String statisticId,
      Map<String, String> headers});

  /// Returns a JSON object containing various system-level statistics for the running server
  ///
  /// **These statistics are generally intended for CouchDB developers only.**
  Future<DbResponse> systemStatsForNode(
      {String nodeName = '_local', Map<String, String> headers});

  // /// Accesses the built-in Fauxton administration interface for CouchDB.
  // ///
  // /// Don't work in browser environment!
  // Future<void> utils();

  /// Confirms that the server is up, running, and ready to respond to requests
  Future<DbResponse> up();

  /// Requests one or more Universally Unique Identifiers (UUIDs) from the CouchDB instance
  Future<DbResponse> uuids({int count = 1, Map<String, String> headers});

  // /// Binary content for the favicon.ico site icon
  // /// Returns 'Not found' if favicon isn't exist.
  // /// Throws `FormatException` all time. **Don't use it!**
  // Future<DbResponse> favicon();
}
